# ====================
#
# Internet Gateway
#
# ====================

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-igw"
  }
}
