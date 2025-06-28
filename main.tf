provider "aws" {
  region = var.region
}

module "eks_cluster" {
  source = "./modules/eks-cluster"
  region = var.region
  cluster_name    = var.cluster_name
#  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  vpc_cidr_block     = var.vpc_cidr_block       # ✅ Required for subnet CIDRs
#  subnet_ids      = var.subnet_ids
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  desired_capacity = var.desired_capacity
  min_size        = var.min_size
  max_size        = var.max_size
  ssh_key_name    = var.ssh_key_name
}
