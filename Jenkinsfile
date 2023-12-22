pipeline {
    agent any
    environment {
      // Define your AWS and ECR credentials
        AWS_ACCOUNT_ID="875040446953"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="hello-world-nextjs"
        IMAGE_TAG="v${BUILD_ID}"
        REPOSITORY_URL ="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
        AWS_CREDENTIAL = credentials('aws-credentials') // Configure the AWS Credentials         
    }   
    stages {        
       stage('Logging into AWS ECR') {
          steps {
            // Get credentials for AWS ECR Login 
            script {
              sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
              }
                 
            }
        }
        
        stage('Cloning Git') {
          steps {
            // Checkout the code from git-repo
            checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sharjeelk63/hello-world-nextjs.git']])     
            }
        }
  
    
        stage('Building image') {
          steps{
            // Building Docker images
            script {
              dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }
          }
        }
   
    
        stage('Pushing to ECR') {
          steps{  
            // Tagging and Uploading Docker images into AWS ECR
            script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URL}:$IMAGE_TAG"
                sh "docker push ${REPOSITORY_URL}:${IMAGE_TAG}"
            }
            }
          }
    }  
    post {
      success {
        // Print out success message on successful build 
        echo 'Build and push to ECR successful!'
        }
      failure {
        // Print out failure message on build failure
        echo 'Build and push to ECR failed.'
        }
    }
}