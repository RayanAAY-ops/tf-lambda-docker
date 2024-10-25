
resource "aws_secretsmanager_secret" "main" {
  name = var.sm_secret_name
}


resource "aws_secretsmanager_secret_policy" "example" {
  secret_arn = aws_secretsmanager_secret.main.arn  # Reference to the ARN of the Secrets Manager secret

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "EnableAllPermissions",
        Effect   = "Allow",
        Principal = {
          AWS = aws_iam_role.lambda_exec.arn  # Replace with your IAM role ARN
        },
        Action   = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "arn:aws:secretsmanager:eu-west-3:523987126142:secret:${var.sm_secret_name}-*"
      }
    ]
  })
}
# rn:aws:secretsmanager:eu-west-3:523987126142:secret:${var.sm_secret_name}-*"