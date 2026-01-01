resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

locals {
  docker_image_uri = "${aws_ecr_repository.app.repository_url}:latest"
  log_group_name  = "/ecs/${var.ecs_cluster_name}-app"
}

resource "aws_cloudwatch_log_group" "app" {
  name              = local.log_group_name
  retention_in_days = 14
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.ecs_cluster_name}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "4096"
  memory                   = "16384"
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  container_definitions    = jsonencode([
    {
      name  = "app"
      image = local.docker_image_uri
      command = ["/bin/bash", "-c", "sleep 5; timebomb"]
      environment = [
        {
          name  = "S6_KEEP_ENV"
          value = "1"
        },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "app"
        }
      }
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
          protocol      = "tcp"
        }
      ]
    }
  ])
  depends_on = [aws_ecr_repository.app]
}

resource "aws_iam_role" "ecs_execution" {
  name = "${var.ecs_cluster_name}-ecs-execution-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_task_definition_family" {
  value = aws_ecs_task_definition.app.family
}

output "ecs_execution_role_name" {
  value = aws_iam_role.ecs_execution.name
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}

output "ecs_execution_role_policy_arn" {
  value = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "ecs_execution_role_policy_name" {
  value = "AmazonECSTaskExecutionRolePolicy"
}

output "ecs_execution_role_policy_document" {
  value = data.aws_iam_policy_document.ecs_execution_policy.json
}

