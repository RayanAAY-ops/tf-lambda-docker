
LAMBDA_FUNCTION_NAME := $(shell terraform output -raw lambda_function_name)

create-ecr-repo:
	terraform apply --target=aws_ecr_repository.main -auto-approve


push_image:
	bash ./push2ecr.sh

tf-apply-all:
	terraform apply -auto-approve

test-lambda-invoke:
	aws lambda invoke --function-name $(LAMBDA_FUNCTION_NAME) lambda_response.json

all: create-ecr-repo push_image tf-apply-all

