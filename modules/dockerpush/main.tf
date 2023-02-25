# ====================
#
# Docker Push
#
# ====================

resource "null_resource" "docker_push" {
  triggers = {
    ecr_login    = var.ecr_login_id,
    docker_start = var.docker_start_id
  }

  ## Dockerイメージ作成
  provisioner "local-exec" {
    command = "docker build --platform linux/amd64 -f ${var.dockerfile_path} -t ${var.system}-${var.project}-${var.environment}-${var.image_name} ."
  }

  ## ECRリポジトリにイメージをプッシュできるように、イメージにタグ付け
  provisioner "local-exec" {
    command = "docker tag ${var.system}-${var.project}-${var.environment}-${var.image_name}:latest ${var.ecr_repository_url}:${var.image_name}"
  }

  ## ECRリポジトリにイメージをプッシュ
  provisioner "local-exec" {
    command = "docker push ${var.ecr_repository_url}:${var.image_name}"
  }
}
