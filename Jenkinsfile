// def user
// node {
//   wrap([$class: 'BuildUser']) {
//     user = env.BUILD_USER_ID
//   }
  
//   emailext mimeType: 'text/html',
//                  subject: "[Jenkins]${currentBuild.fullDisplayName}",
//                  to: "naga.poornima22@gmail.com",
//                  body: '''<a href="${BUILD_URL}input">click to approve</a>'''
// }

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
        // stage('build approval') {
        //    steps {
        //     input "Build proceed?"
        // }
        // }
        stage('build') {  
          steps {
                sh 'mvn clean install'
                }
            }
        stage('Building docker image') {
            steps{
               script {
                   sh 'docker build -t webapp .'
                }
            }
        }
        stage('mail') {
            steps {
                emailext mimeType: 'text/html',
                subject: "[Jenkins]${currentBuild.fullDisplayName}",
                to: 'naga.poornima22@gmail.com',
                body: '''<a href="${BUILD_URL}input">click to approve for Production Deployment</a>'''
            }
        }
        stage('Approval for deploy') {
           steps {
            input "deploy proceed?"
              }
        }
       stage('stop previous containers') {
         steps {
            sh 'docker ps -f name=webcontainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=webcontainer -q | xargs -r docker container rm'
         }
       }
        stage('Deploy the docker image') {
            steps{
                script {
                   sh "docker run -d -p 9090:8080 --name webcontainer webapp "
                }
            }
        }
           stage('JaCoCo') {
            steps {
                echo 'Code Coverage'
                jacoco(execPattern: '**/target/**.exec',
                    classPattern: '**/target/classes',
                    sourcePattern: '**/src',
                    changeBuildStatus: true,
                    minimumInstructionCoverage: '30',
                    maximumInstructionCoverage: '50')
            }
        }
    }
}
