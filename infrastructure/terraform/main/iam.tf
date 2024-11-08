################################################################################
# EKS cluster role
################################################################################

data "aws_iam_policy_document" "eks_trust_relationship" {
  statement {
    sid     = "AllowAssumeRoleOnlyFromEKSService"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks" {
  name = "${local.eks_name}-eks-cluster"

  assume_role_policy = data.aws_iam_policy_document.eks_trust_relationship.json
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}


################################################################################
# EKS nodes roles
################################################################################

data "aws_iam_policy_document" "nodes_trust_relationship" {
  statement {
    sid     = "AllowAssumeRoleOnlyFromEC2Service"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "nodes" {
  name = "${local.eks_name}-eks-nodes"

  assume_role_policy = data.aws_iam_policy_document.nodes_trust_relationship.json
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}


################################################################################
# EKS manager role
################################################################################

data "aws_iam_policy_document" "eks_admin_trust_relationship" {
  statement {
    sid     = "AllowAssumeRoleOnlyFromAdminUsers" # for POC purposes only
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-reserved/sso.amazonaws.com/${local.admin_role_name}"]
    }
  }
}

resource "aws_iam_role" "eks_admin" {
  name = "${local.eks_name}-eks-admin"

  assume_role_policy = data.aws_iam_policy_document.eks_admin_trust_relationship.json
}

data "aws_iam_policy_document" "eks_admin" {
  statement {
    sid       = "AllowEKSActions"
    effect    = "Allow"
    actions   = ["eks:*"]
    resources = ["*"] # for POC purposes
  }

  statement {
    sid       = "AllowIAMPassRole"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"] # for POC purposes
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "eks_admin" {
  name   = "AmazonEKSAdminPolicy"
  policy = data.aws_iam_policy_document.eks_admin.json
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
  role       = aws_iam_role.eks_admin.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_eks_access_entry" "manager" {
  cluster_name      = aws_eks_cluster.eks.name
  principal_arn     = aws_iam_role.eks_admin.arn
  kubernetes_groups = ["my-admin"]
}


################################################################################
# EKS AWS Loadbalancer Controller
################################################################################

data "aws_iam_policy_document" "aws_lbc_trust_relationship" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "aws_lbc" {
  name               = "${aws_eks_cluster.eks.name}-aws-lbc"
  assume_role_policy = data.aws_iam_policy_document.aws_lbc_trust_relationship.json
}

resource "aws_iam_policy" "aws_lbc" {
  policy = file("${path.module}/refs/AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
  policy_arn = aws_iam_policy.aws_lbc.arn
  role       = aws_iam_role.aws_lbc.name
}

