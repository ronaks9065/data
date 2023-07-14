variable "ports" {}
variable "image_id" {}
variable "instance_type" {}
variable "instance_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "public_subnet_cidr1" {}
variable "private_subnet_cidr" {}
variable "private_subnet_cidr1" {}
variable "s3_bucket_name" {}
variable "username" {}
variable "password" {}
variable "instance_class" {}
variable "allocated_storage" {}

module "s3-module" {
  source         = "./s3-module"
  s3_bucket_name = var.s3_bucket_name
}

module "role-policy-module" {
  source = "./role-policy-module"
}

module "vpc-module" {
  source               = "./vpc-module"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  private_subnet_cidr1 = var.private_subnet_cidr1
  public_subnet_cidr1 = var.public_subnet_cidr1
}

module "ec2-module" {
  source           = "./ec2-module"
  ports            = var.ports
  image_id         = var.image_id
  instance_type    = var.instance_type
  instance_name    = var.instance_name
  vpc_id           = module.vpc-module.vpc_id
  public_subnet_id = module.vpc-module.public_subnet_id
  private_subnet_id = module.vpc-module.private_subnet_id
  public_subnet_id1 = module.vpc-module.public_subnet_id1
  iamprofilearn    = module.role-policy-module.iamprofilearn
  depends_on       = [module.vpc-module]
}

module "LB-module" {
  source = "./LB-module"
  vpc_id           = module.vpc-module.vpc_id
  public_subnet_id = module.vpc-module.public_subnet_id
  public_subnet_id1 = module.vpc-module.public_subnet_id1
  instance_id       = module.ec2-module.instance_id
  security_group_id = module.ec2-module.security_group_id
  depends_on = [module.ec2-module]
}

module "rds-module" {
  source             = "./rds-module"
  username           = var.username
  password           = var.password
  allocated_storage  = var.allocated_storage
  instance_class     = var.instance_class
  vpc_id             = module.vpc-module.vpc_id
  security_group_id  = module.ec2-module.security_group_id
  private_subnet_id  = module.vpc-module.private_subnet_id
  private_subnet_id1 = module.vpc-module.private_subnet_id1
}




# Outputs 

output "bucket_details" {
  value = {
    bucket_name = module.s3-module.bucket_name
    bucket_arn  = module.s3-module.bucket_arn
  }
}

output "ec2_instance_details" {
  value = {
    instance_id       = module.ec2-module.instance_id
    public_ip         = module.ec2-module.public_ip
    private_dns       = module.ec2-module.private_dns
    security_group_id = module.ec2-module.security_group_id
  }
}

output "vpc_details" {
  value = {
    vpc_id             = module.vpc-module.vpc_id
    public_subnet_id   = module.vpc-module.public_subnet_id
    public_subnet_id1   = module.vpc-module.public_subnet_id1
    private_subnet_id  = module.vpc-module.private_subnet_id
    private_subnet_id1 = module.vpc-module.private_subnet_id1
  }
}

output "rds_details" {
  value = {
    rds_endpoint = module.rds-module.rds_endpoint
  }
}

output "LB_details" {
  value = {
    alb_dns_name = module.LB-module.dns_name
    alb_target_group_arn = module.LB-module.arn
  }
}