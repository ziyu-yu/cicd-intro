pipeline {
   agent any
   environment {
      AWS_REGION = 'us-east-1'
      ECR_REPOSITORY = '896470658577.dkr.ecr.us-east-1.amazonaws.com/code2cloud-ecr'
      CONTAINER_NAME = 'code2cloud'
   }
    stages {
        stage('Build') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                  sh ''' 
                  docker ps
                  aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY:$CONTAINER_NAME
                  echo "Building the Docker image..."
                  docker build -t $ECR_REPOSITORY:$CONTAINER_NAME ./app/
                  docker image  prune -f
                  docker image ls
                  '''
               }
            }
        }
        stage('Image Deploy') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                  sh ''' 
                  docker ps
                  $(aws ecr get-login --region $AWS_DEFAULT_REGION --no-include-email)
                  echo "Image push into registry"
                  docker push $ECR_REPOSITORY:$CONTAINER_NAME
                  '''
               }
            }
        }
        stage('Deploy Server') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                sh '''
                    aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY:$CONTAINER_NAME
                    chmod +x ./script.sh
                    ECR_REPOSITORY=$ECR_REPOSITORY CONTAINER_NAME=$CONTAINER_NAME ./script.sh
                '''
                }
            }
        }
    }
}