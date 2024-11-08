# # UNCOMMENT if needed

# import {
#   to = module.terraform_state_bucket.aws_s3_bucket.this
#   id = "tf-state-bucket-${local.name_posfix}"
# }

# import {
#   to = module.terraform_state_bucket.aws_s3_bucket_versioning.this
#   id = "tf-state-bucket-${local.name_posfix}"
# }

# import {
#   to = module.terraform_state_bucket.aws_s3_bucket_server_side_encryption_configuration.this
#   id = "tf-state-bucket-${local.name_posfix}"
# }

# import {
#   to = module.terraform_state_bucket.aws_s3_bucket_public_access_block.this
#   id = "tf-state-bucket-${local.name_posfix}"
# }

# import {
#   to = module.terraform_state_bucket.aws_s3_bucket_policy.this
#   id = "tf-state-bucket-${local.name_posfix}"
# }

# import {
#   to = aws_dynamodb_table.terraform_state_lock
#   id = "tf-state-lock-${local.name_posfix}"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_role.general[0]
#     id = "TerraformServiceRoleGeneral"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_policy.general_permissions_policy[0]
#     id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/TerraformGeneralRolePermissions"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_role_policy_attachment.general_permissions_attach[0]
#     id = "TerraformServiceRoleGeneral/arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/TerraformGeneralRolePermissions"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_role.state[0]
#     id = "TerraformServiceRoleState"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_policy.state_permissions_policy[0]
#     id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/TerraformStateRolePermissions"
# }

# import {
#     to = module.terraform_service_roles.aws_iam_role_policy_attachment.state_permissions_attach[0]
#     id = "TerraformServiceRoleState/arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/TerraformStateRolePermissions"
# }