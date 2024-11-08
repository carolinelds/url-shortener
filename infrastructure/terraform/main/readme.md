# URL Shortener Project - IaC

## How to use

### Pre-requisites

1. Have a Terraform version manager installed (suggestion: https://github.com/tofuutils/tenv) in order to compy with `versions.tf` required Terraform version.
2. SSO into a role that can assume both Terraform service roles that were created previously (i.e. in this case, an AdministratorAccess role). Remember to select profile name as `admin` and run `export AWS_PROFILE=admin` at the end.

### Initializing an S3 Backend

3. Setup helper variables, e.g.:

```bash
export VAR_PATH="var/dev.tfvars"
export ENV_PATH="env/dev.s3.tfbackend"
export WORKSPACE="dev" # for simplicity/POC, usually it is better to add more information in name
export PLAN_PATH="default.tfplan"
```

4. Run: 

```bash
terraform init -backend-config=$ENV_PATH
terraform workspace select -or-create=true $WORKSPACE
terraform plan -var-file=$VAR_PATH -out=$PLAN_PATH
```

5. Review the Terraform plan shown in the terminal.

6. If everything seems fine, make Terraform apply and clean-up any residual local files after:

```bash
terraform apply $PLAN_PATH
```

7. Clean up any residual local file:

```bash
rm -rf $PLAN_PATH
```

8. Confirm in AWS Console that the associated resources have been created or updated as expected.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.68.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.68.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git@github.com:terraform-aws-modules/terraform-aws-vpc.git | caffe1979732bd2771d2c240e6ee7c63dc3f308d |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | git@github.com:terraform-aws-modules/terraform-aws-vpc.git//modules/vpc-endpoints | caffe1979732bd2771d2c240e6ee7c63dc3f308d |

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_entry.manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.aws_lbc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_lbc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_lbc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.aws_lbc](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.aws_lbc_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_admin_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.nodes_trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_roles.all_roles](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws"></a> [aws](#input\_aws) | AWS configuration. | <pre>map(object({<br/>    region          = string<br/>    assume_role_arn = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_azs"></a> [azs](#input\_azs) | List of availability zones to provision subnets to. | `list(string)` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name to which request an ACM certificate. | `string` | `"carolinelds.com"` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment to deploy to. | `string` | n/a | yes |
| <a name="input_iac_source"></a> [iac\_source](#input\_iac\_source) | Source for Terraform code. | `string` | `"github.com/carolinelds/url-shortener"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the project. | `string` | `"carolinelds"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project that will be provisioned and managed with this IaC code. | `string` | `"shortly"` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | Configuration values for the VPCs. | <pre>map(object({<br/>    cidr                   = string<br/>    subnet_newbits         = number<br/>    enable_nat_gateway     = bool<br/>    one_nat_gateway_per_az = bool<br/>    single_nat_gateway     = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_waf_allowed_cidrs"></a> [waf\_allowed\_cidrs](#input\_waf\_allowed\_cidrs) | List of whitelisted IPs to have access to the application. | `list(string)` | `[]` | no |
| <a name="input_waf_enable_rate_limiting"></a> [waf\_enable\_rate\_limiting](#input\_waf\_enable\_rate\_limiting) | Whether to enable rate limiting rule in WAF or not. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
