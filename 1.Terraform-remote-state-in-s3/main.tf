resource "aws_s3_bucket" "cybr_lab_aws_s3_bucket" {
  bucket = var.aws_s3_backet_name
  force_destroy = true
  tags   = var.aws_tagging
}

resource "aws_s3_bucket_versioning" "versioning_s3_cybrlab" {
  bucket = aws_s3_bucket.cybr_lab_aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}