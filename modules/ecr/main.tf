# ====================
#
# ECR
#
# ====================


locals {
  ecr_lifecycle_rule = {
    "rules" = [
      {
        "rulePriority" = 1
        "description"  = "Expire excess images more than ${var.image_count_lifecycle_policy}"

        "selection" = {
          "tagStatus"   = "any"
          "countType"   = "imageCountMoreThan"
          "countNumber" = "${var.image_count_lifecycle_policy}"
        }

        "action" = {
          "type" = "expire"
        }
      }
    ]
  }
}

resource "aws_ecr_repository" "tf_ecr_repository" {
  name                 = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-repository"
  image_tag_mutability = var.allow_latest_tag == true ? "MUTABLE" : "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = var.force_destroy
}

resource "aws_ecr_lifecycle_policy" "tf_ecr_image_clean_lifecycle_policy" {
  repository = aws_ecr_repository.tf_ecr_repository.name
  policy     = jsonencode(local.ecr_lifecycle_rule)
}
