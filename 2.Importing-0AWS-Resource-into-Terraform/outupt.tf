output "aws_s3_bucket_details" {
  description = "Output bucketdetails"
  value = [
    "bucket Id: ${aws_s3_bucket.cybr-lab-bucket.id}",
    "bucket ARN: ${aws_s3_bucket.cybr-lab-bucket.arn}",
    "bucket Domain: ${aws_s3_bucket.cybr-lab-bucket.bucket_domain_name}"
  ]
}