# ====================
#
# Rancher Desktop Start
#
# ====================

# ローカルでのRancher Desktopの開始コマンドを定義

resource "terraform_data" "rancher_desktop_start" {
  provisioner "local-exec" {
    command = "rdctl start --application.admin-access"
  }

  ##
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
