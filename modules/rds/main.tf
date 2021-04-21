
resource "aws_db_subnet_group" "rds" {
  name        = "rds-subnet-group${var.suffix}"
  description = "Terraform example RDS subnet group"
  subnet_ids  = var.private_subnet_ids
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.default.engine
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = var.mysql_user
  master_password         = var.mysql_pass
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
  vpc_security_group_ids  = var.vpc_security_group_id
}

