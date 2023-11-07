#!/bin/bash
key_id=$(echo $AWS_KEY_ID | jq '.aws_key_id' | tr -d '"') 
key_secret=$(echo $AWS_KEY_ID | jq '.aws_key_secret' | tr -d '"')
export AWS_ACCESS_KEY_ID=$key_id
export AWS_SECRET_ACCESS_KEY=$key_secret
export AWS_REGION=$REGION
echo $key_id
aws sts get-caller-identity
export EKS_CODEBUILD_ROLE_ARN=`aws sts get-caller-identity | jq -r '.Arn'`
echo $EKS_CODEBUILD_ROLE_ARN
helm version
mkdir ~/.kube/
aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name $EKS_CLUSTER_NAME --role-arn=$EKS_CODEBUILD_ROLE_ARN
chmod 0600 ~/.kube/config
aws sts get-caller-identity
kubectl version --output=json