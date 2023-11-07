#!/bin/bash
key_id=$(echo $AWS_KEY_ID | jq '.aws_key_id' | tr -d '"') 
key_secret=$(echo $AWS_KEY_ID | jq '.aws_key_secret' | tr -d '"')
export AWS_ACCESS_KEY_ID=$key_id
export AWS_SECRET_ACCESS_KEY=$key_secret
export AWS_REGION=$REGION
echo $key_id
aws sts get-caller-identity