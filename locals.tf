locals {
  common_tags = {
    company     = var.company
    project     = "${var.company}-${var.project}"
    environment = var.environment
  }
  naming_prefix = "${var.naming_prefix}-${var.environment}"
}

resource "random_integer" "randint" {
  min = 10000
  max = 99999
}
