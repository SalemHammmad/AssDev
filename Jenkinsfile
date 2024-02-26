pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SalemHammmad/AssDev.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-java-app:latest", "-f dockerfile .")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    docker.image("my-java-app:latest").run("-d -p 8080:8080 my-java-app:latest")
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh 'cd src/ ; java -jar ../lib/junit-platform-console-standalone-1.7.0-all.jar -cp "." --select-class CarTest --test-dir="test"' 
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