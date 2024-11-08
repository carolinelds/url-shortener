locals {
  admin_role_name = [
    for role in data.aws_iam_roles.all_roles.names : role if strcontains(role, "AWSReservedSSO_AdministratorAccess_")
  ][0]
}