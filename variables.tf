variable "script_source_file" {
  description = "The source file for the Lambda function"
  type        = string
  default     = "app/main.py"
}

variable "archive_output_path" {
  description = "The output path for the Lambda function archive"
  type        = string
  default     = "app/main.zip"
}

variable "lambda_function_name" {
  description = "The Lambda handler name"
  type        = string
  default     = "my-lambda-function"
}

variable "lambda_handler_name" {
  description = "The Lambda handler name"
  type        = string
  default     = "main.handler"
}

variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "domain_name" {
  type        = string
  description = "Name of the domain"
}

variable "git_repository" {
  type        = string
  description = "git repository from which this resource is from"
}

variable "ecr_repo_name" {
  type        = string
  description = "Name of the ECR repo"
  default     = "docker-lambda"
}

variable "image_tag" {
  type        = string
  description = "Tag of the ECR image"
  default     = "latest"
}

variable "sm_secret_name" {
  type        = string
  description = "secret name, no credentials"
}

variable "region_name" {
  type        = string
  description = "AWS Region"
}