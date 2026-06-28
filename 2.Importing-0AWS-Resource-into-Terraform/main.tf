import {
  to = aws_s3_bucket.cybr-lab-bucket
  identity = {
    bucket = "cybrlab-import-bucket-014498641692"
  }
}

resource "aws_s3_bucket" "cybr-lab-bucket" {
  ### Configuration omitted for brevity ###
}