output "state_role_arn" {
  description = "ARN of Terraform service role for state operations."
  value       = var.tf_roles_to_create.state ? aws_iam_role.state[0].arn : "Not created"
}

output "general_role_arn" {
  description = "ARN of Terraform service role for general operations."
  value       = var.tf_roles_to_create.general ? aws_iam_role.general[0].arn : "Not created"
}