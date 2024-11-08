data "aws_iam_policy_document" "trust_relationship" {
  statement {
    sid     = "AllowAssumeRoleOnlyFromAdminUsers"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/${local.admin_role_name}"
      ]
    }
  }
}
