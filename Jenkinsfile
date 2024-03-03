pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SalemHammmad/AssDev.git'
            withMaven(
            // Maven installation declared in the Jenkins "Global Tool Configuration"
            maven: 'maven-3', // (1)
            // Use `$WORKSPACE/.repository` for local repository folder to avoid shared repositories
            mavenLocalRepo: '.repository', // (2)
            // Maven settings.xml file defined with the Jenkins Config File Provider Plugin
            // We recommend to define Maven settings.xml globally at the folder level using
            // navigating to the folder configuration in the section "Pipeline Maven Configuration / Override global Maven configuration"
            // or globally to the entire master navigating to  "Manage Jenkins / Global Tools Configuration"
            mavenSettingsConfig: 'my-maven-settings' // (3)
        ) {
          // Run the maven build
          sh "mvn clean verify"
        }
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
                    sh 'mvn test'
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
