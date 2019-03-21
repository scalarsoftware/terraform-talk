variable "count" {
  default = 1
}

variable "region" {
  description = "AWS region to host your infrastructure"
  default = "us-east-1"
}

variable "key_name" {
  description = "Private key name to use with instance"
  default = "terraform"
}

variable "instance_type" {
  description = "AWS instance type"
  default = "t3.small"
}

variable "ami" {
  description = "Base AMI to launch the instances"
  # Bitnami NGINX AMI
  default = "ami-021acbdb89706aa89"
}
