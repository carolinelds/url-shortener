output "account_id" {
  description = "AWS account ID."
  value       = data.aws_caller_identity.current.account_id
}

output "s3_bucket" {
  description = "S3 bucket name."
  value       = module.terraform_state_bucket.s3_id
}

output "dynamodb_region" {
  description = "AWS Region for DynamoDB table."
  value       = var.aws.primary.region
}

output "dynamodb_table" {
  description = "DynamoDB table name."
  value       = aws_dynamodb_table.terraform_state_lock.id
}

output "state_role_arn" {
  description = "ARN of Terraform service role for state operations."
  value       = module.terraform_service_roles.state_role_arn
}

output "general_role_arn" {
  description = "ARN of Terraform service role for general operations."
  value       = module.terraform_service_roles.general_role_arn
}