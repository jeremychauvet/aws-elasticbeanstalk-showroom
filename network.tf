module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ebshowroom-vpc"
  cidr = "172.32.0.0/16"

  azs             = ["eu-central-1a"]
  public_subnets  = ["172.32.1.0/24"]
  private_subnets = ["172.32.2.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "production"
  }
}