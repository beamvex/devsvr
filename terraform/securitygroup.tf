data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "app" {
  name        = "${var.ecs_cluster_name}-security-group"
  description = "Security group for ECS application"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.app.id
  description = "The ID of the security group"
}

output "security_group_name" {
  value = aws_security_group.app.name
  description = "The name of the security group"
}

output "security_group_description" {
  value = aws_security_group.app.description
  description = "The description of the security group"
}

output "security_group_vpc_id" {
  value = aws_security_group.app.vpc_id
  description = "The VPC ID where the security group is created"
}

output "security_group_ingress_rules" {
  value = aws_security_group.app.ingress
  description = "The ingress rules of the security group"
}

output "security_group_egress_rules" {
  value = aws_security_group.app.egress
  description = "The egress rules of the security group"
}

output "security_group_owner_id" {
  value = aws_security_group.app.owner_id
  description = "The owner ID of the security group"
}

output "security_group_tags" {
  value = aws_security_group.app.tags
  description = "The tags of the security group"
}

output "security_group_all_tags" {
  value = aws_security_group.app.tags
  description = "The tags of the security group"
}

output "security_group_all_tags" {
  value = aws_security_group.app.tags
  description = "The tags of the security group"
}

output "security_group_tag_list" {
  value = [for k, v in aws_security_group.app.tags : "${k}=${v}"]
  description = "The tags of the security group as a list of key=value strings"
}
