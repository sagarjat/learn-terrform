
variable "vpc_id" {}
variable sg_name {}




resource "aws_security_group" "aws_security_group_ts" {
    name        = "${var.sg_name}"
    description = "instance security group "
    vpc_id      = "${var.vpc_id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    

    tags = {
        Name = "instance_sg_${var.sg_name}"
    }
}


output "sg_output_id" {
    value = "${aws_security_group.aws_security_group_ts.id}"
}


// load balancer security group 
resource "aws_security_group" "load_balancer_sg" {
    name        = "load_balancer_${var.sg_name}"
    description = "load balancer security group "
    vpc_id      = "${var.vpc_id}"


    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    

    tags = {
        Name = "load_balancer_${var.sg_name}"
    }
}

output "load_balancer_sg_output_id" {
    value = "${aws_security_group.load_balancer_sg.id}"
}






