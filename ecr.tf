resource "aws_ecr_repository" "main" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  encryption_configuration {
    encryption_type = "AES256"
  }
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = "bash push2ecr.sh"
  }

  depends_on = [aws_ecr_repository.main]
}


data "aws_ecr_image" "main" {
  repository_name = aws_ecr_repository.main.name
  image_tag       = var.image_tag
  depends_on      = [null_resource.wait_container]
}