data "aws_caller_identity" "current" {}

data "aws_iam_roles" "all_roles" {}

data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}
