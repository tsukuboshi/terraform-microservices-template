# ====================
#
# Docker Start
#
# ====================

locals {
  desktop_commands = {
    docker_desktop  = "docker desktop start && sleep 60"
    rancher_desktop = "rdctl start --application.admin-access && sleep 60"
  }
  start_command = lookup(local.desktop_commands, var.desktop_app_name, "")
}

# ローカルでのDesktopアプリの開始コマンドを定義
resource "terraform_data" "docker_start" {
  provisioner "local-exec" {
    command = local.start_command
  }
}
