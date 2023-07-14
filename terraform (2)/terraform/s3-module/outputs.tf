output "bucket_name" {
  value = "${aws_s3_bucket.b.bucket}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.b.arn}"
}

