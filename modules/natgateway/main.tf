# ====================
#
# Elastic IP
#
# ====================

resource "aws_eip" "tf_eip" {
  domain     = "vpc"
  depends_on = [var.igw_id]

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-eip"
  }
}

# ====================
#
# Nat Gateway
#
# ====================

resource "aws_nat_gateway" "tf_ngw" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.system}-${var.project}-${var.environment}-${var.resourcetype}-ngw"
  }
}
