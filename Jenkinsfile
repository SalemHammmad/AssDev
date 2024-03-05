pipeline {
    agent any
     tools {
        maven 'maven' 
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
            docker.build("salemhammad24/newapp:latest", "-f dockerfile .")
            }
        }
    }
        /*stage('Test') {
            steps {
                script {
                    withMaven(maven: 'maven') {
                        sh 'mvn test'
                    }
                }
            }
        }*/
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dc2cd4bc-7254-4f66-8c18-958b2ca55193') {
                        docker.image("salemhammad24/newapp:latest").push()
                    }
                }
            }
        }
    }
}
