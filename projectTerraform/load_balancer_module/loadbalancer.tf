variable load_balancer_sg_output_id {}
variable subnet_id1 {}
variable subnet_id2 {}
variable vpc_id{}
variable instance_id1 {}
variable instance_id2 {}

module "shared_vars" {
    source = "../shared_vars"
}

resource "aws_lb" "test" {
  name               = "test-lb-${module.shared_vars.env_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.load_balancer_sg_output_id}"]
  subnets            = ["${var.subnet_id1}","${var.subnet_id2}"]

  enable_deletion_protection = false


  tags = {
    Name = "test_load_bal_${module.shared_vars.env_suffix}"
    Environment = "test"
  }
}



resource "aws_alb_target_group" "my_target_group" {
  name     = "my-target-group-${module.shared_vars.env_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  # Alter the destination of the health check to be the login page.
  #health_check {
  #  path = "/"
  #  port = 80
  #}
}


// attach ec2 instance with target group

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = "${aws_alb_target_group.my_target_group.arn}"
  target_id        = "${var.instance_id1}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = "${aws_alb_target_group.my_target_group.arn}"
  target_id        = "${var.instance_id2}"
  port             = 80
}



resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.my_target_group.arn}"
    type             = "forward"
  }
}


// output load balancer id 

output "aws_lb_id" {
  value = "${aws_lb.test.id}"
}