resource "aws_ecr_repository" "foo" {
  name                 = var.repository_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = var.tags
}