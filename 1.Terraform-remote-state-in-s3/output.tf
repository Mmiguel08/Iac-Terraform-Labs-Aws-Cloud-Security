output "s3_bucket_details" {
  description = "output attributes of our s3 bucket"
  value = [
    "bucket ID: ${aws_s3_bucket.cybr_lab_aws_s3_bucket.id}",
    "Bucket ARN: ${aws_s3_bucket.cybr_lab_aws_s3_bucket.arn}",
    "Bucket Domain: ${aws_s3_bucket.cybr_lab_aws_s3_bucket.bucket_domain_name}"
  ]
}