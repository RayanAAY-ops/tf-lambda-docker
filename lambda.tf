# IAM Role for Lambda Execution with CloudWatch Logs permission
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach policy to allow Lambda to write to CloudWatch Logs
resource "aws_iam_role_policy" "lambda_logging_policy" {
  name = "lambda_logging_policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}


# Create the Lambda function
resource "null_resource" "wait_container" {
  provisioner "local-exec" {
    command = "sleep 30"
  }
  depends_on = [null_resource.docker_push]
}

# Create the Lambda function
resource "aws_lambda_function" "main" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.lambda_handler_name
  image_uri     = data.aws_ecr_image.main.image_uri
  architectures = ["arm64"]
  package_type  = "Image"
  depends_on    = [null_resource.wait_container, null_resource.docker_push, aws_ecr_repository.main, data.aws_ecr_image.main]
}
