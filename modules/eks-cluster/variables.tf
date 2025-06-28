# variables.tf

variable "region" {
  description = "The AWS region to deploy EKS into"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the pre-existing VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the existing VPC (used for subnet calculations)"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
  default     = "private-node-group"
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "ssh_key_name" {
  description = "The name of the EC2 Key Pair to enable SSH access to the worker nodes"
  type        = string
}

variable "instance_types" {
  description = "List of EC2 instance types for EKS worker nodes"
  type        = list(string)
}