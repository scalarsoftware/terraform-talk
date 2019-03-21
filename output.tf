output "instance_ips" {
  value = ["${aws_instance.demo.*.public_ip}"]
}

output "elb_dns_name" {
  value = "${aws_elb.demo.dns_name}"
}
