provider "aws" {
    region     = "us-east-2"
    profile = "sagar"
}

resource "aws_s3_bucket" "sagarTestingBucket" {
  bucket = "testing-bucketjun112021"
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "myfirstobject" {
  bucket = "${aws_s3_bucket.sagarTestingBucket.id}"
  key    = "sample.txt"
  source = "sample.txt"
  etag = "${md5(file("sample.txt"))}"
  # etag = filemd5("path/to/file")
}

terraform {
  backend "s3"{
    region     = "us-east-2"
    bucket     = "testing-bucketjun112021"
    key        = "terraform.tfstate"
    encrypt    = "false"
    profile    = "sagar"
  }
}