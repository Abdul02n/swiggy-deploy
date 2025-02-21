pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'abdul2n/dockertest'  // Docker Hub repository
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials'  // Docker Hub credentials in Jenkins
        DEPLOYMENT_NAME = 'swiggy-app'
        CONTAINER_PORT = '88'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Abdul02n/swiggy-deploy.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID, url: '']) {
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh '''
                    kubectl create deployment $DEPLOYMENT_NAME --image=$DOCKER_IMAGE --dry-run=client -o yaml > deployment.yaml
                    kubectl apply -f deployment.yaml
                    '''
                }
            }
        }

        stage('Expose and Access the App') {
            steps {
                script {
                    sh '''
                    kubectl expose deployment $DEPLOYMENT_NAME --type=NodePort --port=$CONTAINER_PORT
                    minikube service $DEPLOYMENT_NAME --url
                    '''
                }
            }
        }
    }
}
