resource "aws_iam_role" "state" {
  count = var.tf_roles_to_create.state ? 1 : 0

  name               = "TerraformServiceRoleState" # follows AWS default roles naming standard
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
}

resource "aws_iam_policy" "state_permissions_policy" {
  count = var.tf_roles_to_create.state ? 1 : 0

  name   = "TerraformStateRolePermissions" # follows AWS default policies naming standard
  policy = data.aws_iam_policy_document.state_permissions.json
}

resource "aws_iam_role_policy_attachment" "state_permissions_attach" {
  count = var.tf_roles_to_create.state ? 1 : 0

  role       = aws_iam_role.state[0].name
  policy_arn = aws_iam_policy.state_permissions_policy[0].arn
}

data "aws_iam_policy_document" "state_permissions" {
  statement {
    sid       = "AllowListBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["${var.tf_state_bucket_arn}"]
  }

  statement {
    sid    = "AllowManagementOfStateObjects"
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.tf_state_bucket_arn}/*",
    ]
  }

  statement {
    sid    = "AllowManagementOfStateLockTable"
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = ["${var.tf_state_dynamodb_table_arn}"]
  }
}