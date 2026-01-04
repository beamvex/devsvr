resource "aws_efs_file_system" "app" {
  creation_token = "${var.ecs_cluster_name}-efs"

  tags = {
    Name = "${var.ecs_cluster_name}-efs"
  }
}

resource "aws_security_group" "efs" {
  name        = "${var.ecs_cluster_name}-efs-sg"
  description = "Security group for EFS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_mount_target" "app" {
  for_each = toset(data.aws_subnets.default.ids)

  file_system_id  = aws_efs_file_system.app.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs.id]
}