# EC2 Instance Parameters
ports         = [80, 443, 22, 3306, 8080]
image_id      = "ami-08e5424edfe926b43"
instance_type = "t2.micro"
instance_name = "Ronak"

# VPC Parameters
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
private_subnet_cidr1 = "10.0.3.0/24"
public_subnet_cidr1  = "10.0.4.0/24"


# S3 Bucket Parameters 
s3_bucket_name = "my-tf-test-bucket-gfbdgcsccvsgdjskdh"

# RDS Parameters
username          = "ronak"
password          = "ronak1234"
instance_class    = "db.t2.micro"
allocated_storage = "20"