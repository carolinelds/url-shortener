# Terraform S3 Backend Initializer

This code configures an S3 bucket, DynamoDB table and Terraform service roles to be used in subsequent IaC projects. 

For simplicity, this version assumes a 1:1:1 relationship between account, environment and region (i.e., add new .tfvars for new accounts only, not for environments in the same account nor for environments in multiple regions).

## Terraform state

The Terraform state of this IaC project is generated locally, but is not to be saved/commited locally, which is never a good practice. The state file and others are already being ignored with .gitignore, but make sure to clean up any residual local file with step 6.

If specific subsequent changes are to be made (e.g. update tags), the import blocks are already configures in `imports.tf`, just uncomment them.

## How to use

### Pre-requisites

1. Have a Terraform version manager installed (suggestion: https://github.com/tofuutils/tenv) in order to compy with `versions.tf` required Terraform version.
2. SSO into a role with at least S3, IAM and DynamoDB general permissions, since this code will be locally applied.

### Initializing an S3 Backend

3. Setup helper variables, e.g.:

```bash
export VAR_PATH="var/shortly/dev.tfvars"
export PLAN_PATH="default.tfplan"
```

4. Run: 

```bash
terraform init
terraform plan -var-file=$VAR_PATH -out=$PLAN_PATH
```

5. Review the Terraform plan shown in the terminal.

6. If everything seems fine, make Terraform apply and clean-up any residual local files after:

```bash
terraform apply $PLAN_PATH && rm -f $PLAN_PATH && rm -f 'terraform.tfstate' && rm -f 'terraform.tfstate.backup'
```

7. Confirm in AWS Console that the S3 Bucket, DynamoDB table and Terraform service roles have been created correctly in the specified account and region (DynamoDB is a regional resource).

## Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_state_bucket"></a> [terraform\_state\_bucket](#module\_terraform\_state\_bucket) | ./modules/s3-tf-state/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws"></a> [aws](#input\_aws) | AWS configuration. | <pre>map(object({<br/>    region              = string<br/>    allowed_account_ids = list(string)<br/>    profile_name        = string<br/>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment to deploy to. | `string` | n/a | yes |
| <a name="input_iac_source"></a> [iac\_source](#input\_iac\_source) | Source for Terraform code. | `string` | `"github.com/carolinelds/url-shortener"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the project. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project that will be provisioned and managed with this IaC code. | `string` | `"tf-s3-backend-initializer"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | AWS account ID. |
| <a name="output_dynamodb_region"></a> [dynamodb\_region](#output\_dynamodb\_region) | AWS Region for DynamoDB table. |
| <a name="output_dynamodb_table"></a> [dynamodb\_table](#output\_dynamodb\_table) | DynamoDB table name. |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | S3 bucket name. |
<!-- END_TF_DOCS -->