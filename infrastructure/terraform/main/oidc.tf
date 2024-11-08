################################################################################
# AWS/GitHub OIDC Config
################################################################################

resource "aws_iam_openid_connect_provider" "oidc" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  # See: https://github.blog/changelog/2023-07-13-github-actions-oidc-integration-with-aws-no-longer-requires-pinning-of-intermediate-tls-certificates/
  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}


data "aws_iam_policy_document" "oidc_trust_relationship" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:${var.owner}/*"] # for POC purposes only
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

resource "aws_iam_role" "oidc" {
  name               = "GitHubOrganizationAccountAssumeRole"
  assume_role_policy = data.aws_iam_policy_document.oidc_trust_relationship.json
}

data "aws_iam_policy_document" "oidc" {
  statement {
    effect = "Allow"
    actions = [ # for POC purposes only
      "ecr:*",
      "eks:*"
    ]
    resources = ["*"] # for POC purposes only
  }
}

resource "aws_iam_policy" "oidc" {
  name        = "GitHubActionsPermissionsPolicy"
  description = "Policy used for deployments with GitHub Actions"
  policy      = data.aws_iam_policy_document.oidc.json
}

resource "aws_iam_role_policy_attachment" "oidc" {
  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.oidc.arn
}
