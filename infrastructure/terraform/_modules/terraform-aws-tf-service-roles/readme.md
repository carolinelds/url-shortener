# Terraform Service Roles

This code create service roles for Terraform operations, which is a good practice and essential for future automations.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.general_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.state_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.general_permissions_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.state_permissions_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.general_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.state_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_roles.all_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tf_roles_to_create"></a> [tf\_roles\_to\_create](#input\_tf\_roles\_to\_create) | Configuration map with the available roles to create. | <pre>object({<br/>        state = bool<br/>        general = bool<br/>    })</pre> | <pre>{<br/>  "general": true,<br/>  "state": true<br/>}</pre> | no |
| <a name="input_tf_state_bucket_arn"></a> [tf\_state\_bucket\_arn](#input\_tf\_state\_bucket\_arn) | ARN of Terraform state bucket. | `string` | n/a | yes |
| <a name="input_tf_state_dynamodb_table_arn"></a> [tf\_state\_dynamodb\_table\_arn](#input\_tf\_state\_dynamodb\_table\_arn) | ARN of Terraform state lock in DynamoDB. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_general_role_arn"></a> [general\_role\_arn](#output\_general\_role\_arn) | ARN of Terraform service role for general operations. |
| <a name="output_state_role_arn"></a> [state\_role\_arn](#output\_state\_role\_arn) | ARN of Terraform service role for state operations. |
<!-- END_TF_DOCS -->
