terraform {
  backend "s3"{
    region     = "us-east-2"
    bucket     = "testing-bucketjun112021"
    key        = "terraform.tfstate"
    encrypt    = "false"
    profile    = "sagar"
    dynamodb_table = "terraform-lock-table"
  }
}