# WAF for Private Application

Simple WAFv2 module to be used for a private application. It works based on whitelisting IPs and/or CIDR ranges.

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
| [aws_wafv2_ip_set.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_rule_groups"></a> [additional\_rule\_groups](#input\_additional\_rule\_groups) | List of rule groups ARNs to attach in this WAF. | `list(string)` | `[]` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of sets of IP addresses to allow. | `list(string)` | `[]` | no |
| <a name="input_enable_cloudwatch_metrics_visibility"></a> [enable\_cloudwatch\_metrics\_visibility](#input\_enable\_cloudwatch\_metrics\_visibility) | Enable WAF logging. | `bool` | `true` | no |
| <a name="input_enable_json_type_validator"></a> [enable\_json\_type\_validator](#input\_enable\_json\_type\_validator) | Enable validator for body of type application/json. | `bool` | `true` | no |
| <a name="input_enable_rate_limiting"></a> [enable\_rate\_limiting](#input\_enable\_rate\_limiting) | Enable rate limiting. | `bool` | `true` | no |
| <a name="input_enable_sampled_requests_visibility"></a> [enable\_sampled\_requests\_visibility](#input\_enable\_sampled\_requests\_visibility) | Enable WAF sampling. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Web ACL | `string` | `""` | no |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | ARN of the resource to be associated with the Web Application Firewall (WAF) Access Control List (ACL). | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_waf_acl_id"></a> [waf\_acl\_id](#output\_waf\_acl\_id) | WAF ACL ID. |
<!-- END_TF_DOCS -->
