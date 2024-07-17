resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = split(",", aws_cloudformation_stack.eks_vpc.outputs["SubnetIds"])
    security_group_ids = split(",", aws_cloudformation_stack.eks_vpc.outputs["SecurityGroups"])
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_cloudformation_stack.eks_vpc
  ]
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}
