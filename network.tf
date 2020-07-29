module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"

  name = "ebshowroom-vpc"
  cidr = "172.32.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  public_subnets  = ["172.32.1.0/24", "172.32.2.0/24"]
  private_subnets = ["172.32.3.0/24", "172.32.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}

module "app_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.11.0"

  name        = "app-sg"
  description = "Allow traffic from NLB to EB."
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"] # To be replaced by NLB.
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
}

module "database_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.11.0"

  name        = "database-sg"
  description = "Allow traffic from EB to RDS."
  vpc_id      = "${module.vpc.vpc_id}"

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${module.app_sg.this_security_group_id}"
    }
  ]
  # Terraform 0.11 has a limitation which does not allow computed values inside count attribute on resources (issues: #16712, #18015, ...)
  # Computed values are values provided as outputs from module. Non-computed values are all others - static values, values referenced as variable and from data-sources.
  # When you need to specify computed value inside security group rule argument you need to specify it using an argument which starts with computed_ and provide a number of elements in the argument which starts with number_of_computed_.
  # https://github.com/terraform-aws-modules/terraform-aws-security-group#note-about-value-of-count-cannot-be-computed
  number_of_computed_ingress_with_source_security_group_id = 1
}
