pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SalemHammmad/AssDev.git'
            }
        }
        stage('Test') {
            steps {
                // Run automated tests
                sh 'mvn test'
            }
        }
        stage('Docker Build') {
            steps {
                // Build Docker image
                sh 'docker build -t my-app .'
            }
        }
        stage('Docker Push') {
            steps {
                // Push Docker image to registry
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                }
                sh 'docker tag my-app:latest my-docker-registry/my-app:latest'
                sh 'docker push my-docker-registry/my-app:latest'
            }
        }

    }
}
