resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "example_node_group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = split(",", aws_cloudformation_stack.eks_vpc.outputs["SubnetIds"])

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  ami_type = "AL2_x86_64"

  disk_size = 20

  instance_types = ["t3.small"]

  remote_access {
    ec2_ssh_key = aws_key_pair.eks_node_key_pair.key_name
  }

  tags = {
    Name = "example-eks-node-group"
  }
}

output "node_group_arn" {
  value = aws_eks_node_group.example.arn
}
