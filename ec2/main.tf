provider "aws" {
    region     = "us-east-2"
    profile = "sagar"
}

resource "aws_key_pair" "ec2-testing-terraform" {
  key_name   = "ec2-testing-terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAudaHbo71fMcr+QdJxj9ymmnfmAlbXC4ZnbOrrRHaAEAznIEDuxvdqxqsgrQEHRN2T2wZIHgXHjyEL65ebrGHxAJuavxaYPBLOnckVxA/6LEkkcY51+a7KX+9dL/Vb3TMdylSahGAbtyTxnZIbkp1TC5QsBvQsyHevxE3grrw5cBimgPWiGachYFdt0L5rFWUFqxIHtEgy0hSKUYE1sFYdHHfbv+zitgNn+F0q7f9CtX11eO7zVSvZluTyoMzT41erQVUZ4VpoWcD90WfVdKAnCDx0zM3No3SIYzBj2sR3Z+ELKGuYOn/hqrY6ugmlwAo1yAeADD5s/k9WaAiJHl1kS51ecU5VUX7rl5Vyro0j1b6lDntOJ/Bv1/EFxsThmnbHtt/c7Co3hacLPUWlQG3SOTbwiNWgFhfLATYinImlL8qSdwPEwsvaExqtgLpTwST/XH7iqqNe/e3VbJplRQb7sLn/yW/j8IoHyZpxs/Yvl3pxXaGHDXoBaOb9+zOe08= sagar@sagar-pc"
}

variable "vpc_id" {
    default = "vpc-81ff60ea"
}

resource "aws_security_group" "aws_security_group_ts" {
  name        = "aws_security_group_ts"
  description = "custom security group "
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "post 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "post 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


variable "ami_id" {
    default = "ami-0d8d212151031f51c"
}

resource "aws_instance" "my_instance" {
  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "ec2-testing-terraform"
  vpc_security_group_ids = ["${aws_security_group.aws_security_group_ts.id}"]
  user_data = <<-EOF
                    #!/bin/bash
                    yum -y install httpd
                    echo "<em style='color:blue;'>This Page is served from :`hostname -f`</em>" >> /var/www/html/index.html
                    service httpd start
                EOF
  tags = {
    Name = "ec2_instance"
  }
}

resource "aws_s3_bucket" "sagarTestingBucket" {
  bucket = "testing-bucketjun1120211"
  acl    = "private"

  tags = {
    Environment = "Dev"
  }
}

