pipeline {
    agent any
     tools { 
        maven 'Maven 3.3.9' 
    }
    stages {
        stage('Clone') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SalemHammmad/AssDev.git'
            }
            
        }

    stage('Build Docker Image') {
    steps {
        script {
            docker.build("my-app-image:latest", "-f dockerfile .")
            }
        }
    }
        stage('Test') {
            steps {
                script {
                    sh 'maven/mvn test'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials-id') {
                        docker.image("my-app-image:latest").push()
                    }
                }
            }
        }
    }
}
