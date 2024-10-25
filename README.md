
# TF-AWS-LAMBDA-DOCKER

This project deploys an AWS Lambda function inside a Docker container using Terraform. Follow these steps to initialize, set up secrets, and test your Lambda function.

---
## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- Make (usually pre-installed on Unix-based systems)

## Configuration

1. **Configure AWS CLI**  
   Run the following command to configure your AWS CLI with your credentials:
   ```bash
   aws configure
   ```
   
2. **Create your Infrastructure**  
In the project directory, initialize Terraform and set up the backend:

   ```bash
   terraform init
   terraform validate
   terraform plan
   terraform apply -auto-approve
   ```

3. **Create your secret credentials**  
Your secret should be secured, I personally created it inside ```~/.aws/sm-secrets/my-secret-manager-credentials.json```:

   ```bash
   echo '{"username": "username", "password": "password"}' > ~/.aws/sm-secrets/my-secret-manager-credentials.json
   chmod 700 ~/.aws/sm-secrets
   make sm-create-secret
   ```

   
4. **Results**  
If everything is well configured, you should be able to get a ```"statusCode": 200```