module "terraform_state_bucket" {
  source = "../_modules/terraform-aws-tf-state-resources/"

  s3_bucket_name = "tf-state-bucket-${local.name_posfix}"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tf-state-lock-${local.name_posfix}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  deletion_protection_enabled = true

  lifecycle {
    prevent_destroy = true
  }
}

module "terraform_service_roles" {
  source = "../_modules/terraform-aws-tf-service-roles"

  tf_roles_to_create          = var.tf_roles_to_create
  tf_state_bucket_arn         = module.terraform_state_bucket.s3_arn
  tf_state_dynamodb_table_arn = aws_dynamodb_table.terraform_state_lock.arn

  depends_on = [
    module.terraform_state_bucket,
    aws_dynamodb_table.terraform_state_lock
  ]
}