resource "tls_private_key" "eks_node_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks_node_key_pair" {
  key_name   = "eks-node-key"
  public_key = tls_private_key.eks_node_key.public_key_openssh
}

output "eks_node_private_key_pem" {
  value     = tls_private_key.eks_node_key.private_key_pem
  sensitive = true
}
