locals {
  name_posfix = "${var.owner}-${data.aws_caller_identity.current.account_id}-${var.env}"
  # adding account to increase chances of a globally unique name
}