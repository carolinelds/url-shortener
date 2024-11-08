resource "aws_iam_role" "general" {
  count = var.tf_roles_to_create.general ? 1 : 0

  name               = "TerraformServiceRoleGeneral" # follows AWS default roles naming standard
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
}

resource "aws_iam_policy" "general_permissions_policy" {
  count = var.tf_roles_to_create.general ? 1 : 0

  name   = "TerraformGeneralRolePermissions" # follows AWS default policies naming standard
  policy = data.aws_iam_policy_document.general_permissions.json
}

resource "aws_iam_role_policy_attachment" "general_permissions_attach" {
  count = var.tf_roles_to_create.general ? 1 : 0

  role       = aws_iam_role.general[0].name
  policy_arn = aws_iam_policy.general_permissions_policy[0].arn
}

data "aws_iam_policy_document" "general_permissions" {
  statement {
    sid    = "AllowGeneralTerraformPermissions"
    effect = "Allow"

    # OBS: it is good practice to further limit these permissions
    actions   = ["*"]
    resources = ["*"]

    # Also configure SCPs in organization to globally limit permissions of sensitive actions:
    # https://github.com/aws-samples/service-control-policy-examples
  }

  statement {
    sid    = "DenyTerraformStateBucketAccess"
    effect = "Deny"
    actions = [
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersionTagging",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.tf_state_bucket_arn}",
      "${var.tf_state_bucket_arn}/*",
    ]
  }

  statement {
    sid    = "DenyTerraformStateLockTableAccess"
    effect = "Deny"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = ["${var.tf_state_dynamodb_table_arn}"]
  }
}