# Terraform Lab — Remote State in S3

## Objective
Store and manage Terraform state remotely using an Amazon S3 bucket (optionally with DynamoDB for state locking).

## Prerequisites
- AWS account and credentials configured (via `aws configure` or environment variables `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`).
- Terraform installed (recommended >= 0.12).
- An existing S3 bucket to hold the state (and an optional DynamoDB table for state locking).

## Repository files
- `provider.tf`: provider and backend configuration (S3 backend settings).
- `main.tf`: Terraform resources for the lab.
- `variables.tf`: variable declarations used by the configuration.
- `output.tf`: outputs produced by the configuration.
- `terraform.tfstate`: local state file (if present from previous runs).

## Typical workflow
1. Review and update `provider.tf` with your S3 backend configuration. Example backend block:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "path/to/terraform.tfstate"
    region = "us-east-1"
    # optional: dynamodb_table = "terraform-locks"
  }
}
```

2. Initialize Terraform (this configures the remote backend):

```
terraform init
```

3. Generate and review a plan:

```
terraform plan
```

4. Apply the changes:

```
terraform apply
# or
terraform apply -auto-approve
```

5. View outputs:

```
terraform output
```

## Verify remote state
- In the AWS Console, browse the S3 bucket and verify the `terraform.tfstate` object exists at the configured key.
- Or use the AWS CLI:

```
aws s3 ls s3://your-terraform-state-bucket/path/to/
aws s3 cp s3://your-terraform-state-bucket/path/to/terraform.tfstate -
```

If you enabled a DynamoDB table for locking, confirm lock entries while running operations that modify state.

## Cleanup
To destroy resources created by this lab and remove remote state objects:

```
terraform destroy -auto-approve
```

After `terraform destroy` completes, you may delete the state object from the S3 bucket and the DynamoDB table used for locks (if any).

## Notes & best practices
- Never commit AWS credentials or other secrets into source control.
- Use server-side encryption and bucket policies to protect state in S3.
- Consider enabling versioning on the state bucket to protect against accidental deletions.
- Use a dedicated S3 bucket and path per environment (dev/stage/prod) to avoid state collisions.

---
Lab created: Terraform remote state in S3
