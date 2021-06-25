variable sg_id { }
variable ami_id{}
variable key_pair_name {}
variable ec2_name{}
resource "aws_instance" "my_instance" {
  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "${var.key_pair_name}"
  vpc_security_group_ids = ["${var.sg_id}"]

  tags = {
    Name = "${var.ec2_name}"
  }
}