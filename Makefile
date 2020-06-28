.PHONY: init plan apply

init:
	terraform init

plan:
	terraform plan -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1"

apply:
	terraform apply -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1"