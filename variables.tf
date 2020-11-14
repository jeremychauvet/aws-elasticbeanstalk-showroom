variable "aws_region" {
  description = "AWS region where ressources must be created. Will affect billing and availability."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Profile used to authenticate to AWS and run Terraform (located in .aws/config)"
  type        = string
  default     = "elasticbeanstalk-showroom"
}
