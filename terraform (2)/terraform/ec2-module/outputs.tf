output "instance_id" {
  value = "${aws_instance.web.id}"
}

output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "private_dns" {
  value = "${aws_instance.web.private_dns}"
}

output "security_group_id" {
  value = "${aws_security_group.sg.id}"
}
