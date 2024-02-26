pipeline {
      agent {
         docker {
            image 'docker:20.10.8'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }



stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-java-app:latest", "-f Dockerfile .")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    docker.image("my-java-app:latest").run("--rm -d -p 8080:8080 my-java-app:latest")
                }
            }
        }
    stage('Clone') {
        steps {
            git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SalemHammmad/AssDev.git'
        }
    }
        
    stage('Build') {
        steps {
            sh 'mvn clean package'
        }
    }
    stage('Docker Build') {
        steps {
            script {
                docker.build("jenkins-image:latest")
            }
        }
    }
    stage('test') {
        steps{
            script{
                sh 'cd src/ ; java -jar ../lib/junit-platform-console-standalone-1.7.0-all.jar -cp "." --select-class CarTest --test-dir="test"' 
            }
        }
    }
    stage('Push to Registry') {
        steps {
            script {
                docker.withRegistry('https://your-docker-registry', 'docker-credentials-id') {
                docker.image("jenkins-image:latest").push()
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
