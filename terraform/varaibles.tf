variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "image_name" {
  description = "Docker image name"
  type        = string
  default     = "devsvr"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "devsvr-app"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "devsvr-cluster"
}

