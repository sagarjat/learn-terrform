locals {
    env = "${terraform.workspace}"

    all_env = {
        default = "default"
        qa = "qa"
        dev = "dev"
    }

    env_suffix = "${lookup(local.all_env,local.env)}"

    vpc_subnet_ips = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]
    vpc_subnet_names = ["sub-pub1", "sub-pub2", "sub-pri1","sub-pri2"]
    vpc_subnet_azs = ["us-east-2a", "us-east-2b", "us-east-2a","us-east-2b"] 
}

output "env_suffix" {
    value = "${local.env_suffix}"
}


output "vpc_subnet_ips" { 
    value =  "${local.vpc_subnet_ips}"
}
output "vpc_subnet_names" {

    value =  "${local.vpc_subnet_ips}"
}
output "vpc_subnet_azs" {

    value = "${local.vpc_subnet_azs}"
}