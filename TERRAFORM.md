## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.67 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.67 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_profile | Profile used to authenticate to AWS and run Terraform (located in .aws/config) | `string` | `"elasticbeanstalk-showroom"` | no |
| aws\_region | AWS region where ressources must be created. Will affect billing and availability. | `string` | `"us-east-1"` | no |
| tags | Tags used for resource group and billing. | `map(string)` | <pre>{<br>  "CreatedBy": "Terraform",<br>  "Project": "ElasticBeanstalk Showroom"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnets | List of IDs of private subnets |
| public\_subnets | List of IDs of public subnets |
| rds\_endpoint | Database endpoint |
