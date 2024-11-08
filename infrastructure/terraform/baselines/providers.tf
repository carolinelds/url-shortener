provider "aws" {
  region              = var.aws.primary.region
  profile             = var.aws.primary.profile_name
  allowed_account_ids = var.aws.primary.allowed_account_ids

  default_tags {
    tags = local.tags
  }
}