# Creation S3 Bucket
resource "aws_s3_bucket" "b" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Enable versioning in bucket
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Enable Public access
resource "aws_s3_bucket_public_access_block" "example_public_access" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


# make bucket publicly accesible
resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = aws_s3_bucket.b.id

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Id": "Policy1425976940968",
    "Statement": [
        {
            "Sid": "Stmt1425976939440",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.b.bucket}/*"
        }
    ]
}
EOF

depends_on = [aws_s3_bucket_public_access_block.example_public_access]
}

# Enable Static hosting in bucket
resource "aws_s3_bucket_website_configuration" "st" {
  bucket = aws_s3_bucket.b.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

