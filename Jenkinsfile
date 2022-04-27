pipeline {
    agent any
    tools {
        maven 'maven'
        
    }
   stages {   
        stage('checkout') {
            steps {
                //echo "pulling changes from the tags ${params.tags}"
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/poornima4824/JavaProject1.git']]])
            }
        }
        stage('build approval') {
           steps {
            input "Build proceed?"
        }
        }
        stage('build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Building image') {
            steps{
               script {
                   sh 'docker build -t webapp .'
                }
            }
        }
        stage('Run the Docker Image') {
            steps{
                script {
                   sh "docker run -d -p 9090:8080 --name webcontainer webapp "
                }
            }
        }
    }
}
