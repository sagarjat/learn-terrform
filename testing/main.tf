provider "aws" {
    region     = "us-east-1"
    profile = "sagar"
}

data "aws_region" "current" {}
locals {
    ami_according_to_region = {
        us-east-1 = "ami-id-1"
        us-east-2 = "ami-id-2"
    }

    env_suffix = "${lookup(local.ami_according_to_region,data.aws_region.current.name)}"
}



output "region_name" {
    value = local.env_suffix
}