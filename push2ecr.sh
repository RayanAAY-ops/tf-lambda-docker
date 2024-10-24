#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Get the AWS account ID and default region
ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
AWS_DEFAULT_REGION=$(aws configure get region)
ECR_REPO="docker-lambda" # Update this with your actual ECR repository name if needed
IMAGE_NAME=${1:-docker-lambda}  # Default image name; can be overridden by passing a parameter
TAG=${2:-latest}  # Default tag; can be overridden by passing a parameter
# Build Image
docker_build() {
    echo "building image on multi platform"
    docker build -t ${IMAGE_NAME} .

}

# Function to log in to ECR
ecr_login() {
    echo "Logging in to ECR..."
    aws ecr get-login-password --region "$AWS_DEFAULT_REGION" | \
    docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
}

# Function to tag the Docker image
image_tag() {
    echo "Tagging image..."
    docker tag "$IMAGE_NAME:latest" "$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO:$TAG"
}

# Function to push the image to ECR
push_to_ecr() {
    echo "Pushing image to ECR..."
    docker push "$ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO:$TAG"
}

# Main script execution
main() {
    docker_build
    ecr_login
    image_tag
    push_to_ecr
}

# Execute the main function
main
