resource "aws_iam_instance_profile" "s3_service" {
  name  = "s3-service-user"
  roles = ["${aws_iam_role.s3_service.name}"]
}

resource "aws_iam_role" "s3_service" {
  name               = "s3-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "elasticbeanstalk_service" {
  name  = "elasticbeanstalk-service-user"
  roles = ["${aws_iam_role.elasticbeanstalk_service.name}"]
}

resource "aws_iam_role" "elasticbeanstalk_service" {
  name               = "elasticbeanstalk-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "elasticbeanstalk"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "elasticbeanstalk_service" {
  name       = "elasticbeanstalk-service"
  roles      = ["${aws_iam_role.elasticbeanstalk_service.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_iam_instance_profile" "elasticbeanstalk_instance" {
  name  = "elasticbeanstalk-ec2-user"
  roles = ["${aws_iam_role.elasticbeanstalk_instance.name}"]
}


resource "aws_iam_role" "elasticbeanstalk_instance" {
  name               = "elasticbeanstalk-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_instance_profile" "elasticbeanstalk_ec2" {
  name  = "elasticbeanstalk-ec2-user"
  roles = ["${aws_iam_role.elasticbeanstalk_ec2.name}"]
}

resource "aws_iam_role" "elasticbeanstalk_ec2" {
  name               = "elasticbeanstalk-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
