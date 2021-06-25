provider "aws" {
    region     = "us-east-2"
    profile = "sagar"
}

variable "ami_id" {
    default = "ami-0d8d212151031f51c"
}


module "shared_vars" {
    source = "./shared_vars"
}

module "vpc_module" {
    source = "./vpc_module"
}

module "key_pair_module" {
    key_name = "ec2-testing-terraform_${module.shared_vars.env_suffix}"
    source = "./key_pair_module"
}

module "sg_module" {
    vpc_id = "${module.vpc_module.vpc_id}"
    sg_name = "sg_${module.shared_vars.env_suffix}"
    source = "./sg_module"
}


module "ec2_module1" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    ec2_name = "public ec2  Server ${module.shared_vars.env_suffix}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    subnet_id = "${module.vpc_module.public_subnet1}"
    source = "./instance_module"
}

module "ec2_module2" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    ec2_name = "public ec2 second ${module.shared_vars.env_suffix}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    subnet_id = "${module.vpc_module.public_subnet2}"
    source = "./instance_module"
}

module "ec2_module3" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    ec2_name = "private ec2 Server ${module.shared_vars.env_suffix}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    subnet_id = "${module.vpc_module.private_subnet1}"
    source = "./instance_module"
}

module "ec2_module4" {
    sg_id = "${module.sg_module.sg_output_id}"
    ami_id = "${var.ami_id}"
    ec2_name = "private ec2 second ${module.shared_vars.env_suffix}"
    key_pair_name = "${module.key_pair_module.key_pair_name}"
    subnet_id = "${module.vpc_module.private_subnet2}"
    source = "./instance_module"
}


module "load_balancer_module" {
    vpc_id = "${module.vpc_module.vpc_id}"
    load_balancer_sg_output_id = "${module.sg_module.load_balancer_sg_output_id}"
    subnet_id1 = "${module.vpc_module.public_subnet1}"
    subnet_id2 = "${module.vpc_module.public_subnet2}"
    instance_id1 = "${module.ec2_module1.instance_id}"
    instance_id2 = "${module.ec2_module2.instance_id}"
    source = "./load_balancer_module"
}
