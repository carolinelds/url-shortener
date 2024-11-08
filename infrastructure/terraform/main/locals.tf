locals {

  ################################################################################
  # VPC locals
  ################################################################################

  azs_length = length(var.azs)

  vpcs = {
    for vpc, vpc_configs in var.vpcs : vpc => merge( # add subnets to vpc_configs
      vpc_configs,
      {
        vpc_name = "${vpc}-${var.owner}-${var.env}"
        private_subnets = [
          for k, v in var.azs : cidrsubnet(
            vpc_configs.cidr,
            vpc_configs.subnet_newbits,
            k + 0 * local.azs_length
          )
        ]
        public_subnets = [
          for k, v in var.azs : cidrsubnet(
            vpc_configs.cidr,
            vpc_configs.subnet_newbits,
            k + 1 * local.azs_length
          )
        ]
        database_subnets = strcontains(vpc, "vpn") ? [] : [ # a vpn vpc does not need database subnet
          for k, v in var.azs : cidrsubnet(
            vpc_configs.cidr,
            vpc_configs.subnet_newbits,
            k + 2 * local.azs_length
          )
        ]
      }
    )
  }

  # For simplicity since we only have 1 VPC. Needs refactor in case of multiple VPCs to be arrays of objects:
  private_subnet_ids = flatten([for vpc, vpc_configs in var.vpcs : concat(module.vpc["${vpc}"].private_subnets)])
  public_subnet_ids  = flatten([for vpc, vpc_configs in var.vpcs : concat(module.vpc["${vpc}"].public_subnets)])
  vpc_id             = flatten([for vpc, vpc_configs in var.vpcs : concat(module.vpc["${vpc}"].vpc_id)])[0]

  ################################################################################
  # EKS locals
  ################################################################################

  eks_name    = "${var.env}-${var.owner}"
  eks_version = 1.30

  admin_role_name = [
    for role in data.aws_iam_roles.all_roles.names : role if strcontains(role, "AWSReservedSSO_AdministratorAccess_")
  ][0]
}