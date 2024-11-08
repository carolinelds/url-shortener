terraform {
  # partial configuration, see more contents in env/*
  backend "s3" {
    region  = "us-east-1"    # do not change
    key     = "main.tfstate" # do not change
    encrypt = true           # do not change

    # change to be the same as var.project
    workspace_key_prefix = "shortly"
  }
}