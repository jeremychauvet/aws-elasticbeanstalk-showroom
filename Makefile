.PHONY: init plan apply estimate-cost destroy validate

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply

validate:
	pre-commit run --all-files

estimate-cost:
	terraform plan -out plan.save
	terraform show -json plan.save > plan.json
	infracost --tfjson ./plan.json

destroy:
	terraform destroy
