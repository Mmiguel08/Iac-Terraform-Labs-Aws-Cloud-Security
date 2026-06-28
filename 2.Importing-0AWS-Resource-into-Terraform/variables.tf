variable "aws_region" {
  description = "The region for this resource"
  type        = string
  default     = "us-east-1"
}

variable "aws_tagging" {
  type = map(string)
  default = {
    "Description" = "Bucket used to practice importing resources into Terraform.",
    "cybr-lab"    = "auto-deployed"
  }
}