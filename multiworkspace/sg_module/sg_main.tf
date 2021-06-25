variable "vpc_id" {
    default = "vpc-81ff60ea"
}

variable sg_name {}
resource "aws_security_group" "aws_security_group_ts" {
  name        = "${var.sg_name}"
  description = "custom security group "
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "post 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "sg_output_id" {
    value = "${aws_security_group.aws_security_group_ts.id}"
}