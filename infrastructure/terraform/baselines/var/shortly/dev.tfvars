env = "dev"

aws = {
  primary = {
    region              = "us-east-1"
    allowed_account_ids = ["160885281351"]
    profile_name        = "admin"
  }
}

tf_roles_to_create = {
  state   = true
  general = true
}
