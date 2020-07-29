# Service.
resource "aws_iam_instance_profile" "elasticbeanstalk_service" {
  name = "elasticbeanstalk-service-user"
  role = aws_iam_role.elasticbeanstalk_service.name
}

resource "aws_iam_role" "elasticbeanstalk_service" {
  name               = "elasticbeanstalk-service-role"
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

# Instance.
resource "aws_iam_instance_profile" "elasticbeanstalk_instance" {
  name = "elasticbeanstalk-ec2-user"
  role = aws_iam_role.elasticbeanstalk_instance.name
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
