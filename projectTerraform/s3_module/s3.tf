resource "aws_s3_bucket" "sagarTestingBucket" {
  bucket = "testing-bucketjun112021"
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

