# Terraform Lab — Import Existing AWS Resources into Terraform

## Overview

This lab demonstrates how to bring an **existing Amazon S3 bucket** under Terraform management without recreating or modifying the resource.

In real-world cloud environments, many resources are created manually before Infrastructure as Code (IaC) is adopted. Terraform's import capability allows these existing resources to be incorporated into the Terraform state, enabling future infrastructure management through code.

The objective of this lab was to import a manually created S3 bucket, ensure Terraform detected **no infrastructure drift**, and finally destroy the resource using Terraform.

---

## Learning Objectives

* Configure the AWS Provider.
* Discover existing AWS resources.
* Import an existing Amazon S3 bucket into Terraform.
* Validate that Terraform configuration matches the existing infrastructure.
* Manage previously manual infrastructure as code.
* Destroy imported resources using Terraform.

---

## Technologies

* Terraform
* Amazon S3
* AWS CLI

---

## Project Structure

```text
.
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

---

## Architecture

```text
                Existing S3 Bucket
                        │
                        ▼
             terraform import/apply
                        │
                        ▼
              Terraform State File
                        │
                        ▼
          Infrastructure managed as Code
```

---

## Workflow

### 1. Configure AWS Credentials

```bash
aws configure
```

---

### 2. Initialize Terraform

```bash
terraform init
```

---

### 3. Validate Configuration

```bash
terraform validate
```

---

### 4. Discover Existing Buckets

```bash
aws s3 ls
```

---

### 5. Import the Existing Bucket

Terraform imports the existing resource into its state instead of creating a new one.

```bash
terraform apply
```

During the apply process, Terraform performs the resource import and associates it with the Terraform state.

---

### 6. Verify Infrastructure Drift

After importing, Terraform should report:

```text
No changes. Your infrastructure matches the configuration.
```

This confirms the Terraform configuration accurately represents the existing infrastructure.

---

### 7. View Resource Information

Outputs include:

* Bucket ID
* Bucket ARN
* Bucket Domain Name

```bash
terraform output
```

---

### 8. Destroy the Imported Resource

Once the resource is managed by Terraform, it can be deleted like any other managed infrastructure.

```bash
terraform destroy
```

---

### 9. Verify Cleanup

Confirm that no S3 buckets remain.

```bash
aws s3api list-buckets
```

Expected output:

```json
{
    "Buckets": []
}
```

---

## Skills Demonstrated

* Terraform Import
* Infrastructure as Code (IaC)
* AWS S3 Management
* Terraform State Management
* AWS CLI
* Infrastructure Drift Detection
* Cloud Infrastructure Lifecycle
* Cloud Resource Discovery

---

## Key Takeaways

This lab demonstrates one of the most important Terraform workflows used in production environments:

* Adopting Infrastructure as Code for existing cloud resources.
* Importing manually created infrastructure into Terraform.
* Detecting configuration drift.
* Managing imported resources through Terraform.
* Safely removing infrastructure using Infrastructure as Code.

---

## Best Practices

* Import existing resources before attempting to recreate them.
* Ensure Terraform configuration matches the actual resource configuration to avoid unintended changes.
* Always review `terraform plan` before applying changes.
* Use version control to track infrastructure definitions.
* Never store AWS credentials inside the repository.

---

## Future Improvements

* Import additional AWS resources (IAM, VPC, EC2, Security Groups).
* Store Terraform state in an Amazon S3 Remote Backend.
* Implement DynamoDB State Locking.
* Organize the project using reusable Terraform modules.
* Integrate GitHub Actions for automated Terraform validation and deployment.

---

## Author

**Moisés Miguel**

Cloud Security • AWS • Terraform • Infrastructure as Code
