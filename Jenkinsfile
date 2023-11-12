pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_IMAGE_NAME = "vadakkan01/djangolp"
        DOCKER_IMAGE_TAG = "0.1"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[url: 'https://github.com/adithyanrk67/djangolp.git']]])
            }
        }
        stage('Build') {
            steps {
                sh "docker-compose build"
                sh "docker images" // Add this line to print Docker images for debugging
            }
        }
        stage('Deploy') {
            steps {
                sh "docker-compose up -d"
            }
        }
        stage('Check Docker Images') {
            steps {
                sh "docker images"
            }
        }
        stage('Push the image') {
            steps {
                withCredentials([
                    string(credentialsId: 'github_token_dlp', variable: 'GITHUB_TOKEN'),
                    string(credentialsId: 'dockerhub_dlp', variable: 'DOCKER_PASSWORD')
                ]) {
                    sh "docker login -u vadakkan01 -p \$DOCKER_PASSWORD \$DOCKER_REGISTRY"
                    sh "docker tag djangolp_web:latest ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    sh "docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }
}

