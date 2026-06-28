# Terraform Lab — Building Reusable EC2 Modules

## Overview

This project demonstrates how to build a **reusable Terraform module** for provisioning Amazon EC2 instances following Infrastructure as Code (IaC) best practices.

Instead of defining infrastructure directly in the root configuration, the EC2 deployment is encapsulated inside a reusable module that can be shared across multiple projects or teams.

The module automatically retrieves the latest supported AMI (Ubuntu Server or Amazon Linux), validates user input, provisions the required networking components, and launches an encrypted EC2 instance.

---

## Architecture

```text
                     Root Module
                          │
                          ▼
                  EC2 Terraform Module
                          │
        ┌─────────────────┼──────────────────┐
        │                 │                  │
        ▼                 ▼                  ▼
   Latest AMI         Custom VPC      Security Group
   (Data Source)          │                  │
        │                 ▼                  │
        └────────────► Subnet ◄──────────────┘
                          │
                          ▼
                     EC2 Instance
```

---

## Objectives

* Build a reusable Terraform module.
* Separate infrastructure into reusable components.
* Automatically retrieve the latest Ubuntu or Amazon Linux AMI.
* Validate user input using Terraform variable validation.
* Deploy a custom VPC and networking resources.
* Launch an encrypted EC2 instance.
* Demonstrate Infrastructure as Code best practices.

---

## Technologies

* Terraform
* Amazon EC2
* Amazon VPC
* Amazon Subnet
* Amazon Security Groups
* AWS CLI

---

## Project Structure

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── modules
│   └── ec2
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

---

## Features

* Reusable EC2 module
* Latest Ubuntu or Amazon Linux AMI
* Variable validation
* Custom VPC creation
* Private Subnet deployment
* Security Group creation
* Encrypted EBS Root Volume
* Standardized resource tagging
* Modular Infrastructure as Code

---

## Deployment Workflow

### Initialize Terraform

```bash
terraform init
```

### Validate the configuration

```bash
terraform validate
```

### Review the execution plan

```bash
terraform plan
```

### Deploy the infrastructure

```bash
terraform apply
```

---

## Module Example

```hcl
module "ec2_instance" {
  source = "./modules/ec2"

  instance_type = "t3.micro"
  image_os      = "ubuntu"

  tagging = {
    name         = "ec2-linux-instance"
    BusinessUnit = "infosec"
  }
}
```

---

## Automatic AMI Selection

The module uses Terraform **Data Sources** to retrieve the latest available operating system image.

Supported operating systems include:

* Ubuntu Server 22.04 LTS
* Amazon Linux 2023

The AMI is selected dynamically using Terraform locals and the `coalesce()` function.

---

## Variable Validation

The module validates user input before deployment.

Examples include:

* Only `ubuntu` or `amazon linux` are accepted as operating systems.
* Only approved EC2 instance types are allowed.
* The `BusinessUnit` tag is mandatory.

These validation rules help enforce organizational standards across deployments.

---

## Networking Components

The module provisions the networking resources required for the EC2 instance, including:

* Custom VPC
* Private Subnet
* Security Group
* HTTP Ingress Rule
* Outbound Internet Access

---

## Outputs

After deployment, Terraform returns useful resource information such as:

* EC2 Instance ID
* EC2 Instance ARN
* VPC ID
* Subnet ID
* Security Group ID
* Private IP Address

---

## Verify Resources

### Verify the EC2 Instance

```bash
aws ec2 describe-instances
```

### Verify the VPC

```bash
aws ec2 describe-vpcs
```

### Verify the Subnet

```bash
aws ec2 describe-subnets
```

### Verify the Security Group

```bash
aws ec2 describe-security-groups
```

---

## Destroy the Infrastructure

```bash
terraform destroy
```

Terraform removes all resources created by the module, including:

* EC2 Instance
* Security Group
* Subnet
* VPC

---

## Skills Demonstrated

* Terraform Modules
* Infrastructure as Code (IaC)
* Terraform Data Sources
* Terraform Local Values
* Variable Validation
* AWS EC2
* Amazon VPC
* AWS Networking
* AWS Security Groups
* AWS CLI
* Cloud Infrastructure Automation

---

## Key Learning Outcomes

Through this project, I learned how to:

* Build reusable Terraform modules.
* Separate infrastructure into reusable components.
* Dynamically retrieve the latest AMIs.
* Implement input validation using Terraform.
* Provision complete networking infrastructure.
* Launch standardized EC2 instances.
* Apply Infrastructure as Code best practices for reusable cloud deployments.

---

## Future Improvements

* Add SSH Key Pair support.
* Create Internet Gateway and Route Tables.
* Provision Public and Private Subnets.
* Add IAM Roles for EC2.
* Integrate Remote State with Amazon S3.
* Add DynamoDB State Locking.
* Implement GitHub Actions for CI/CD.
* Add automated security scanning using Checkov and tfsec.

---

## Author

**Moisés Miguel**

Cloud Security • AWS • Terraform • Infrastructure as Code
