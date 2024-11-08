# module "waf" {
#   source = "../_modules/terraform-aws-wafv2-private-app"

#   name         = "${local.eks_name}-waf"
#   resource_arn = # UPDATE AFTER MANIFEST APPLY -> TF APPLY

#   allowed_cidrs              = var.waf_allowed_cidrs
#   enable_rate_limiting       = var.waf_enable_rate_limiting
# }