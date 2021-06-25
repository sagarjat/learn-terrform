provider "aws" {
    region     = "us-east-2"
    profile = "sagar"
}

variable "ami_id" {
    default = "ami-0d8d212151031f51c"
}



module "key_pair_module" {
    source = "./key_pair_module"
}


module "sg_module" {
    source = "./sg_module"
}

module "ec2_module" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    source = "./instance_module"
}


