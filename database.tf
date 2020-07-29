module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.16.0"

  # Database name shown in the console.
  identifier = "ebshowroom"

  # Database engine parameters.
  engine               = "mysql"
  major_engine_version = "5.7"
  engine_version       = "5.7.30"
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  storage_encrypted    = true

  # Maintenance and backup.
  backup_retention_period = 0 # The days to retain backups for
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"

  # Database configuration parameters.
  name     = "ebshowroomdb"
  username = "ebshowroomuser"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  # Networking configuration.
  vpc_security_group_ids = [module.database_sg.this_security_group_id]
  subnet_ids             = module.vpc.private_subnets
  multi_az               = false

  # Observability management.
  enabled_cloudwatch_logs_exports = ["audit", "general"]

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}
