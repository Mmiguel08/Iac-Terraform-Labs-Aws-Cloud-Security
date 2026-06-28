variable "aws_region" {
  description = "The aws region to deploy in."
  type        = string
  default     = "ap-south-1"
}
variable "aws_s3_backet_name" {
  description = "name of the bucket"
  type = string
  default = "cybr-backet-lab-name-90989"
}
variable "aws_tagging" {
  description = "Resource tags."
  type        = map(string)
  default = {
    "Team"        = "security",
    "Environment" = "dev"
  }
}
