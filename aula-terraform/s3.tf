resource "aws_s3_bucket" "sc_s3" {
  bucket = "sc-ada-s3-bucket"

  tags = {
    Name = "SC ADA S3 Bucket"
  }
}