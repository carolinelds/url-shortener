variable "tf_roles_to_create" {
  description = "Configuration map with the available roles to create."
  type = object({
    state   = bool
    general = bool
  })
  default = {
    state   = true
    general = true
  }
}

variable "tf_state_bucket_arn" {
  description = "ARN of Terraform state bucket."
  type        = string
}

variable "tf_state_dynamodb_table_arn" {
  description = "ARN of Terraform state lock in DynamoDB."
  type        = string
}