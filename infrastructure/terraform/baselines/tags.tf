# can be replaced by a module, using locals for simplicity

locals {
  tags = {
    project    = var.project
    owner      = var.owner
    env        = var.env
    iac_source = var.iac_source
    workspace  = "na" # Not Applicable
    managed_by = "terraform"
  }
}