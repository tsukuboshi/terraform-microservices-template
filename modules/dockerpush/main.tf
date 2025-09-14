# ====================
#
# Docker Push
#
# ====================

resource "terraform_data" "docker_push" {
  triggers_replace = {
    ecr_login = var.ecr_login_id
  }

  ## Dockerイメージ作成
  provisioner "local-exec" {
    command = "docker build --platform linux/amd64 -f ${var.dockerfile_path} -t ${var.system}-${var.project}-${var.environment}-${var.image_name} ."
  }

  ## ECRリポジトリにイメージをプッシュできるように、イメージにタグ付け
  provisioner "local-exec" {
    command = "docker tag ${var.system}-${var.project}-${var.environment}-${var.image_name}:${var.image_tag} ${var.ecr_repository_url}:${var.image_tag}"
  }

  ## ECRリポジトリにイメージをプッシュ
  provisioner "local-exec" {
    command = "docker push ${var.ecr_repository_url}:${var.image_tag}"
  }
}
