stages {
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
    stages('test') {
        steps{
            script{
                sh 'make check'
                junit './test/SupiciousEventsServiceTest.java' 
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
            }
        }
    }
}

