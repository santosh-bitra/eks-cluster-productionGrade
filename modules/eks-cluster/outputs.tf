# outputs.tf

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "API server endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_security_group_id" {
  description = "Security Group ID for the EKS control plane"
  value       = aws_security_group.eks_cluster_sg.id
}

output "node_security_group_id" {
  description = "Security Group ID for the EKS worker nodes"
  value       = aws_security_group.eks_node_sg.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "public_access_sg_id" {
  description = "Security Group ID for public access"
  value       = aws_security_group.public_access_sg.id
}

output "debug_ssh_key" {
  value = var.ssh_key_name
}