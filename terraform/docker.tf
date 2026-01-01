resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    command = <<EOT
docker build -t ${var.image_name}:${var.image_tag} ..
aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.gui13.repository_url}
docker tag ${var.image_name}:${var.image_tag} ${aws_ecr_repository.gui13.repository_url}:latest
docker push ${aws_ecr_repository.gui13.repository_url}:latest
EOT
  }
  triggers = {
    repo_url = aws_ecr_repository.gui13.repository_url
    timestamp = timestamp()
  }
}

output "docker_image_tag" {
  value = "${var.image_name}:${var.image_tag}"
}

