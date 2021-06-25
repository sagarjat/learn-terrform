provider "aws" {
    region     = "us-east-2"
    profile = "sagar"
}

variable "ami_id" {
    default = "ami-0d8d212151031f51c"
}



module "key_pair_module" {
    key_name = "ec2-testing-terraform_${local.env}"
    source = "./key_pair_module"
}


module "sg_module" {
    sg_name = "outside_${local.env}"
    source = "./sg_module"
}

module "ec2_module" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    ec2_name = "ec2 environment on ${local.env}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    source = "./instance_module"
}


// you can define local variable in terraform by using the following method

locals {
    env = "${terraform.workspace}"

    all_environment_ami = {
        default = "default_ami_id"
        dev = "dev_ami_id"
        qa = "qa_ami_id"
    }
    ami_id = "${lookup(local.all_environment_ami, local.env)}"
}

output "which_ami_id" {
    value = "${local.ami_id}"
}

