# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-talk-bucket"
    key    = "terraform-talk.tfstate"
    region = "us-east-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  # TODO change to a variable in CI
  shared_credentials_file = "/home/alexandar/.aws/credentials"
  region = "us-east-1"
}

data "aws_availability_zones" "all" {}

# Create EC2 instance
resource "aws_instance" "demo" {
  ami               = "${var.ami}"
  count             = "${var.count}"
  key_name          = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.demo.id}"]
  source_dest_check = false
  instance_type = "${var.instance_type}"

tags {
    Name = "${format("demo-%03d", count.index + 1)}"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "demo" {
  name = "terraform-demo-sg"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Launch Configuration
resource "aws_launch_configuration" "demo" {
  image_id               = "${var.ami}"
  instance_type          = "${var.instance_type}"
  security_groups        = ["${aws_security_group.demo.id}"]
  key_name               = "${var.key_name}"
  lifecycle {
    create_before_destroy = true
  }
}

# Create AutoScaling Group
resource "aws_autoscaling_group" "demo" {
  launch_configuration = "${aws_launch_configuration.demo.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  min_size = 2
  max_size = 5
  load_balancers = ["${aws_elb.demo.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform-demo-asg"
    propagate_at_launch = true
  }
}

# Create Security Group for ELB
resource "aws_security_group" "elb" {
  name = "terraform-demo-elb"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create ELB
resource "aws_elb" "demo" {
  name = "terraform-demo-elb"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}
