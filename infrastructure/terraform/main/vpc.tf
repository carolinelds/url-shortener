module "vpc" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=caffe1979732bd2771d2c240e6ee7c63dc3f308d" # v.5.15.0

  for_each = local.vpcs

  azs = var.azs

  name = each.value.vpc_name
  cidr = each.value.cidr

  private_subnets = each.value.private_subnets
  public_subnets  = each.value.public_subnets

  enable_nat_gateway     = each.value.enable_nat_gateway
  one_nat_gateway_per_az = each.value.one_nat_gateway_per_az
  single_nat_gateway     = each.value.single_nat_gateway

  manage_default_network_acl   = true
  public_dedicated_network_acl = true
  public_inbound_acl_rules     = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  public_outbound_acl_rules    = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])

  public_subnet_tags = {
    "kubernetes.io/role/elb"                  = 1
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"         = 1
    "kubernetes.io/cluster/${local.eks_name}" = "owned"
  }
}

module "vpc_endpoints" {
  # enables Session Manager connectivity to EC2s in private subnets

  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git//modules/vpc-endpoints?ref=caffe1979732bd2771d2c240e6ee7c63dc3f308d" # v.5.15.0"

  for_each = local.vpcs

  vpc_id = module.vpc["${each.key}"].vpc_id

  endpoints = { for service in toset(["ssm", "ssmmessages", "ec2messages", "kms"]) :
    replace(service, ".", "_") =>
    {
      service             = service
      subnet_ids          = concat(module.vpc["${each.key}"].private_subnets) # database subnets can use the same endpoints
      private_dns_enabled = true
    }
  }

  create_security_group      = true
  security_group_name_prefix = "vpc-endpoints-"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from subnets"
      cidr_blocks = concat(module.vpc["${each.key}"].private_subnets_cidr_blocks, module.vpc["${each.key}"].database_subnets_cidr_blocks)
    }
    ingress_http = {
      description = "HTTP from subnets"
      cidr_blocks = concat(module.vpc["${each.key}"].private_subnets_cidr_blocks, module.vpc["${each.key}"].database_subnets_cidr_blocks)
    }
  }
}