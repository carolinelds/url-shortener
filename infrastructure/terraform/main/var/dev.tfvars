env = "dev"

aws = {
  primary = {
    region          = "us-east-1"
    assume_role_arn = "arn:aws:iam::160885281351:role/TerraformServiceRoleGeneral"
  }
}

azs = ["us-east-1a", "us-east-1b"]

vpcs = {
  main = {
    cidr                   = "10.44.0.0/20"
    subnet_newbits         = 4
    enable_nat_gateway     = true
    one_nat_gateway_per_az = false
    single_nat_gateway     = true
  }
}

# waf_allowed_cidrs      = ["<my-public-ip>/32"] (add to default.auto.tfvars, git ignored file)
waf_enable_rate_limiting = true
