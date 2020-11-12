resource "aws_elastic_beanstalk_application" "showroom_front_app" {
  name        = "showroom-front-app"
  description = "Showroom front application, made with Symfony 5."

  appversion_lifecycle {
    service_role          = aws_iam_role.elasticbeanstalk_service.arn
    max_age_in_days       = 60 // Version will be removed each 60 days.
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "showroom_front_app_production" {
  name                   = "showroom-front-app-production"
  application            = aws_elastic_beanstalk_application.showroom_front_app.name
  solution_stack_name    = "64bit Amazon Linux 2 v3.0.3 running PHP 7.4 "
  tier                   = "WebServer"
  wait_for_ready_timeout = "15m"

  // IAM.
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_instance_profile.elasticbeanstalk_service.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.elasticbeanstalk_instance.name
  }

  // Network.
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", module.vpc.private_subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", module.vpc.public_subnets)
  }

  // Capacity.
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}
