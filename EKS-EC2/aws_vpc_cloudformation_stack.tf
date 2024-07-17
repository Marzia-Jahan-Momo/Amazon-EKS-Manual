resource "aws_cloudformation_stack" "eks_vpc" {
  name         = "aws-worker-node-vpc-stack"
  template_url = "https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml"
  capabilities = ["CAPABILITY_IAM"]
}

output "vpc_id" {
  value = aws_cloudformation_stack.eks_vpc.outputs["VpcId"]
}

output "subnet_ids" {
  value = aws_cloudformation_stack.eks_vpc.outputs["SubnetIds"]
}

output "security_group_ids" {
  value = aws_cloudformation_stack.eks_vpc.outputs["SecurityGroups"]
}
