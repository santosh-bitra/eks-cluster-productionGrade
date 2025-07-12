# 📦 EKS-Terraform-Infra

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=santosh-bitra_eks-cluster-productionGrade&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=santosh-bitra_eks-cluster-productionGrade)

> **Production-Grade Infrastructure as Code** using Terraform to deploy a highly available, secure, and modular **Amazon EKS Cluster**.

---

## 📁 Project Structure

```
EKS-Terraform-Infra/
├── terraform/
│   ├── main.tf                   # Root module entry
│   ├── variables.tf              # Root variables
│   ├── terraform.tfvars          # Input variable values
│   ├── modules/
│   │   └── eks-cluster/
│   │       ├── main.tf           # EKS cluster & node group
│   │       ├── network.tf        # Subnet, IGW, NAT, route tables
│   │       ├── iam.tf            # IAM roles and policies
│   │       ├── security.tf       # Security groups
│   │       ├── variables.tf      # Module variables
│   │       ├── outputs.tf        # Module outputs
│   │       └── README.md         # Module-level documentation
├── .gitignore
└── README.md                    # Project-level documentation
```

---

## 🚀 What It Does

This Terraform code does the following:

✅ Creates 2 public and 2 private subnets in existing VPC
✅ Provisions an EKS cluster with private worker nodes
✅ Adds separate security groups for:

* Cluster control plane
* Node group
* Public SSH/HTTP access
  ✅ Configures NAT gateway & internet gateway
  ✅ Assigns IAM roles to cluster and nodes
  ✅ Outputs endpoints, SGs, and subnet IDs

---

## 🧠 Prerequisites

* [Terraform >= 1.3](https://www.terraform.io/downloads.html)
* [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* An AWS VPC already created
* An EC2 Key Pair (for SSH access)

---

## 🛠️ Usage

### 1. Clone the Repo

```bash
git clone https://github.com/<your-username>/EKS-Terraform-Infra.git
cd EKS-Terraform-Infra/terraform
```

### 2. Update `terraform.tfvars`

```hcl
region          = "us-east-1"
vpc_id          = "vpc-xxxxxxxx"
vpc_cidr_block  = "192.168.0.0/16"
cluster_name    = "eksdemo"
ssh_key_name    = <your-aws-ssh-key>
instance_types  = ["t3.medium"]
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Validate & Plan

```bash
terraform plan -out=tfplan
```

### 5. Apply

```bash
terraform apply tfplan
```

### 6. Configure `kubectl`

```bash
aws eks update-kubeconfig --region us-east-1 --name eksdemo
kubectl get nodes
```

---

## 🔐 Security Practices

* `terraform.tfvars` **excluded from git** via `.gitignore`
* SSH/HTTP SG is optional and isolated
* NodeGroup uses IAM with least-privilege policies
* All subnets use proper tagging (`kubernetes.io/role/...`)
* EKS endpoint access is configurable (public/private)

---

## 🧪 CI/CD & Static Code Analysis

This project uses **GitHub Actions** to perform automated security and quality checks on every push or pull request to the `main` branch.

### ✅ CI Workflow Overview
The GitHub Actions workflow includes:
- Code checkout and preparation
- Static code analysis with **SonarCloud**
- Detection of security vulnerabilities, code smells, and maintainability issues in Terraform code

### 🛠️ Workflow File
The workflow is defined at:
`.github/workflows/VulnerabilityCheck.yml`

### 🔐 Secrets Used
| Secret Name   | Purpose                          |
|---------------|----------------------------------|
| SONAR_TOKEN   | Authenticates GitHub Action with SonarCloud |

### 📈 SonarCloud Badge
The badge at the top of this README reflects the current quality gate status:
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=santosh-bitra_eks-cluster-productionGrade&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=santosh-bitra_eks-cluster-productionGrade)

You can view the full SonarCloud dashboard [here](https://sonarcloud.io/summary/new_code?id=santosh-bitra_eks-cluster-productionGrade).

---

## 🧹 Cleanup

```bash
terraform destroy -auto-approve
```

---

## ✨ TODO (optional enhancements)

* Add Helm support
* Add EFS or EBS CSI integration
* Add IRSA (IAM roles for service accounts)
* Add Prometheus/Grafana module
* Integrate CI/CD pipeline with GitHub Actions or CodePipeline

---

## 📸 Outputs

```bash
Apply complete! Resources:

cluster_name              = eksdemo
cluster_endpoint          = https://<cluster-api>.eks.amazonaws.com
cluster_security_group_id = sg-xxxxxxxx
node_security_group_id    = sg-yyyyyyyy
public_subnet_ids         = [...]
private_subnet_ids        = [...]
```

---

## 🤝 Credits
Made by Santosh Bitra
DevOps | Terraform | AWS | Azure | Kubernetes | Python 


