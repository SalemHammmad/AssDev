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
                script {
                    sh 'cd src/ ; javac./test/SuspiciousEventsServiceTest.java -cp "." --select-class SuspiciousEventsServiceTest' 
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-java-app:latest", "-f dockerfile .")
                }
            }
        }
       stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials-id') {
                    docker.image("my-java-app:latest").push()
                }
            }
        }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f Deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}