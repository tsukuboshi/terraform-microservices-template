# ====================
#
# ECR Container Push
#
# ====================

resource "null_resource" "docker_start" {
  ## Rancher Desktopを開始
  provisioner "local-exec" {
    command = "rdctl start"
  }

  ##
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
