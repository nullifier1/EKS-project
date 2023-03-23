resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]

  tags = {
    Name = "main"
  }
}

#Create AWS security group for database
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Declare main RDS MariaDB instance
resource "aws_db_instance" "gogs" {
  identifier           = "gogs-mariadb"
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  name              = "gogs"
  username             = var.database_login
  password             = var.database_password
  allocated_storage    = 20
  storage_type         = "gp2"
  publicly_accessible  = false
  backup_retention_period = 7
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
