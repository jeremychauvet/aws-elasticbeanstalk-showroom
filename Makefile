.PHONY: init plan apply

init:
	terraform init

plan:
	terraform plan -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1"

apply:
	terraform apply -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1"

estimate-cost:
	terraform plan -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1" -out plan.save
	terraform show -json plan.save > plan.json
	infracost --tfjson ./plan.json

destroy:
	terraform destroy -var="aws_profile=elasticbeanstalk-showroom" -var="aws_region=eu-central-1"
