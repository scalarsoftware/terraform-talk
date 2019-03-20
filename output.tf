output "instance_ids" {
  value = ["${aws_instance.demo.*.public_ip}"]
}

output "elb_dns_name" {
  value = "${aws_elb.demo.dns_name}"
}
