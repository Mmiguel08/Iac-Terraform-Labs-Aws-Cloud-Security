# Terraform Lab — Remote State Management with Amazon S3

## Overview

This project demonstrates how to configure a **Terraform Remote Backend** using **Amazon S3** to securely store infrastructure state. Instead of relying on a local `terraform.tfstate` file, the state is migrated to an S3 bucket, enabling collaboration between multiple engineers while following Infrastructure as Code (IaC) best practices.

The lab also enables **S3 Bucket Versioning**, providing protection against accidental deletion or corruption of the Terraform state file.

---

## Architecture

```text
                  Terraform CLI
                        │
          terraform init / plan / apply
                        │
                        ▼
             Amazon S3 Remote Backend
         ┌────────────────────────────┐
         │      terraform.tfstate     │
         │    S3 Versioning Enabled   │
         └────────────────────────────┘
```

---

## Objectives

* Provision an Amazon S3 bucket for Terraform state storage.
* Enable S3 Bucket Versioning.
* Migrate Terraform state from a local backend to Amazon S3.
* Verify the remote state using the AWS CLI.
* Demonstrate backend migration between Local and S3.
* Safely destroy the infrastructure by migrating the state back to a local backend.

---

## Technologies Used

* Terraform
* Amazon S3
* AWS CLI

---

## Project Structure

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

## Deployment Workflow

### 1. Clone the Repository

```bash
git clone git@github.com:Mmiguel08/Iac-Terraform-Labs-Aws-Cloud-Security.git
cd Iac-Terraform-Labs-Aws-Cloud-Security
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the Execution Plan

```bash
terraform plan
```

### 4. Deploy the Infrastructure

```bash
terraform apply
```

---

## Remote Backend Configuration

Terraform uses an Amazon S3 bucket as the remote backend to store the state file.

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

---

## S3 Bucket Configuration

The bucket is configured with **Versioning**, allowing previous versions of the state file to be restored if necessary.

```hcl
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "your-terraform-state-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
```

---

## Verify the Remote State

Using the AWS CLI:

```bash
aws s3 ls s3://your-terraform-state-bucket
```

Expected output:

```text
terraform.tfstate
```

---

## Backend Migration

After configuring the S3 backend, Terraform migrates the local state file to Amazon S3:

```bash
terraform init
```

Terraform automatically detects the backend change and prompts for state migration.

Once migrated, the local state files can be removed:

```bash
rm terraform.tfstate terraform.tfstate.backup
```

---

## Destroying the Infrastructure

Since the Terraform state is stored inside the S3 bucket, the backend must first be migrated back to the local backend before destroying the resources.

Update the backend configuration:

```hcl
terraform {
  backend "local" {}
}
```

Then migrate the state:

```bash
terraform init --migrate-state
```

Finally:

```bash
terraform destroy
```

---

## Security Best Practices

* Remote Terraform State stored in Amazon S3.
* S3 Bucket Versioning enabled.
* No hardcoded AWS credentials.
* Infrastructure managed as code.
* State recovery through object versioning.
* Consistent state shared across multiple users.

> **Production Recommendation:** Use Amazon DynamoDB for Terraform State Locking to prevent concurrent modifications to the same state file.

---

## Skills Demonstrated

* Terraform
* Infrastructure as Code (IaC)
* Amazon S3
* Terraform Remote Backend
* Terraform State Management
* AWS CLI
* Cloud Infrastructure
* Cloud Security Fundamentals

---

## Learning Outcomes

Through this lab, I gained hands-on experience with:

* Configuring Terraform Remote Backends.
* Migrating Terraform state from Local to Amazon S3.
* Managing infrastructure collaboratively using shared state.
* Protecting Terraform state with S3 Versioning.
* Managing the Terraform infrastructure lifecycle.
* Applying cloud security and infrastructure best practices.

---

## Future Improvements

* Implement Amazon DynamoDB for State Locking.
* Enable Server-Side Encryption (SSE-KMS).
* Restrict bucket access using IAM policies.
* Organize infrastructure using reusable Terraform modules.
* Integrate GitHub Actions for automated deployments.
* Add security scanning with Checkov or tfsec.
