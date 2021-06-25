module "shared_vars" {
    source = "../shared_vars"
}

// vpc creation 
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
      Name = "vpc_${module.shared_vars.env_suffix}"
  }
}







resource "aws_subnet" "subnets" {
  count             = "${length(module.shared_vars.vpc_subnet_ips)}"
  vpc_id            = "${aws_vpc.custom_vpc.id}"
  cidr_block        = "${element(module.shared_vars.vpc_subnet_ips, count.index)}"
  availability_zone = "${element(module.shared_vars.vpc_subnet_azs, count.index)}"

  tags = {
    Name = "${element(module.shared_vars.vpc_subnet_names, count.index)}"
  }
}


// create internet gateway
resource "aws_internet_gateway" "my_internet_gateway" {
    vpc_id     = "${aws_vpc.custom_vpc.id}"

  tags = {
    Name = "internet_gateway_${module.shared_vars.env_suffix}"
  }
}


// create route table and do entry for internet gateway
resource "aws_route_table" "my_route_table" {
  vpc_id     = "${aws_vpc.custom_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my_internet_gateway.id}"
  }

  tags = {
    Name = "my_route_table_${module.shared_vars.env_suffix}"
  }
}


resource "aws_route_table_association" "subnets" {
  count          = "${length(module.shared_vars.vpc_subnet_ips)}"
  subnet_id      = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.my_route_table.id}"
}


output "vpc_id" {
    value = "${aws_vpc.custom_vpc.id}"
}

output "public_subnet1" {
    value  = "${element(aws_subnet.subnets.*.id, 0)}"
}

output "public_subnet2" {
    value = "${element(aws_subnet.subnets.*.id, 1)}"
}

output "private_subnet1" {
    value = "${element(aws_subnet.subnets.*.id, 2)}"
}

output "private_subnet2" {
    value = "${element(aws_subnet.subnets.*.id, 3)}"
}