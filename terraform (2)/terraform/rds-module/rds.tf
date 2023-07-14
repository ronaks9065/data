# Create RDS
resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.instance_class
  identifier           = "mydbdemo"
  username             = var.username
  password             = var.password
  publicly_accessible  = false
  vpc_security_group_ids = [ var.security_group_id ]
  db_subnet_group_name = aws_db_subnet_group.subnetgroup.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "subnetgroup" {
  name       = "testsubnetgroup"
  subnet_ids = [var.private_subnet_id, var.private_subnet_id1]

  tags = {
    Name = "My DB subnet group"
  }
}