output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.subnet_public.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.subnet_private.id}"
}

output "private_subnet_id1" {
  value = "${aws_subnet.subnet_private1.id}"
}

output "public_subnet_id1" {
  value = "${aws_subnet.subnet_public1.id}"
}