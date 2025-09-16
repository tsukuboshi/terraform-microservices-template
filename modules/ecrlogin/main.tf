# ====================
#
# ECR Login
#
# ====================

# ローカルでのECRログインコマンドを定義

resource "terraform_data" "ecr_login" {
  triggers_replace = {
    ecr_repo_create = var.ecr_repository_arn
  }

  # 認証トークンを取得し、レジストリに対して Docker クライアントを認証
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.ecr_repository_url}"
  }
}
