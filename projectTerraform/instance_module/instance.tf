variable sg_id { }
variable ami_id{}
variable key_pair_name {}
variable ec2_name{}
variable subnet_id{}

resource "aws_instance" "my_instance" {
    ami           = "${var.ami_id}"
    instance_type = "t2.micro"
    key_name = "${var.key_pair_name}"
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["${var.sg_id}"]
    associate_public_ip_address = true
    source_dest_check = false


    tags = {
        Name = "${var.ec2_name}"
    }
}




resource "null_resource" "copy_execute" {
    connection {
        type = "ssh"
        host = aws_instance.my_instance.public_ip
        user = "ec2-user"
        private_key = file("/home/sagar/.ssh/ec2-testing-terraform.pem")
    }

    provisioner "file" {
        source      = "/var/www/learn-Teraform/projectTerraform/instance_module/httpd.sh"
        destination = "/tmp/httpd.sh"
    }
  
    provisioner "remote-exec" {
            inline = [
            "sudo chmod 777 /tmp/httpd.sh",
            "sh /tmp/httpd.sh",
            ]
    }
    depends_on = [ aws_instance.my_instance ]
  
}

























output "instance_id" {
    value = "${aws_instance.my_instance.id}"
} 