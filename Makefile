
LAMBDA_FUNCTION_NAME := $(shell terraform output -raw lambda_function_name)
SECRETS_FOLDER="~/.aws/sm-secrets"
SECRET_NAME=$(shell grep 'sm_secret_name' terraform.tfvars | cut -d'=' -f2 | tr -d '"')
SECRET_FILE_NAME="my-secret-manager-credentials.json"

create-ecr-repo:
	terraform apply --target=aws_ecr_repository.main -auto-approve

# Target to create a secret
sm-create-secret:
	aws secretsmanager update-secret \
		--secret-id $(SECRET_NAME) \
		--secret-string file://$(SECRETS_FOLDER)/$(SECRET_FILE_NAME)


push_image:
	bash ./push2ecr.sh

tf-apply-all:
	terraform apply -auto-approve

test-lambda-invoke:
	aws lambda invoke --function-name $(LAMBDA_FUNCTION_NAME) lambda_response.json

all: create-ecr-repo push_image tf-apply-all

