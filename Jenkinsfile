//${library.jenkins-slack-library.version}
//@Library('Slack-us-east-jenkins-prod') _

pipeline {

  agent { label 'google-jenkins-slave' }

  options {
       buildDiscarder logRotator(
           artifactDaysToKeepStr: '5',
           artifactNumToKeepStr: '5',
           daysToKeepStr: '5',
           numToKeepStr: '5')
          timestamps()
        }
  environment {
    BUILD_NUMBER = "${env.BUILD_ID}"
    //eagunu docker registry repository
    registry="danle360/python-dan-framwork"
    //eagunu dockerhub registry
    registryCredential='dan360-dockerhub-username-and-pwd'
    dockerImage = ''
    //latest_version_update
    imageVersion="danle360/python-dan-framwork:v$BUILD_NUMBER"
  }

  stages {
    stage('Cloning Git') {
            steps {
            //git branch: 'prod-master', credentialsId: 'democalculus-github-login-creds', url: 'https://github.com/Danle360/us-argocd-java-docker-app.git'
             git credentialsId: 'GIT_CREDENTIALS', url:  'https://github.com/Danle360/python-dan-fram-work.git',branch: 'master_branch'
          }
        }

      stage('Building our image') {
           steps{
                script {
                   dockerImage = docker.build registry + ":v$BUILD_NUMBER"
                  }
              }
           }

      // stage('QA approve') {
      //        steps {
      //          notifySlack("Do you approve QA deployment? $registry/job/$BUILD_NUMBER", [])
      //            input 'Do you approve QA deployment?'
      //            }
      //        }

      stage('push Image To DockerHub Repo') {
         steps{
             script {
                docker.withRegistry( '', registryCredential ) {
               dockerImage.push()
              }
            }
           }
         }

    stage('updating image version') {
          steps {
                sh "bash update_image_version.sh"
                }
            }

    stage('Cleaning  up docker Images') {
        steps{
           sh 'docker rmi  ${imageVersion}'
           }
         }

    stage('java_web_app_execute Deployment') {
            steps {
              parallel(
                "Deployment": {
                     sh 'bash python_framwork_app_execute.sh'
                    },
                    "Rollout Status": {
                      sh 'bash python_framwork_rollout.sh'
                        }
                      )
                    }
                }

  // stage ('Deploying To EKS') {
  //      steps {
  //      sh 'kubectl apply -f mss-us-east-4-prod.yml'
  //      }
  //     }

 }  //This line end the pipeline stages
  //post {   //This line start the post script when ready uncommit this line
       // always {   //when ready uncommit this line
          //junit 'target/surefire-reports/*.xml'
         // jacoco execPattern: 'target/jacoco.exec'
        // pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
         //dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
         //publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'owasp-zap-report', reportFiles: 'zap_report.html', reportName: 'OWASP ZAP HTML Report', reportTitles: 'OWASP ZAP HTML Report'])

         //Use sendNotifications.groovy from shared library and provide current build result as parameter
        // sendNotification currentBuild.result  //when ready uncommit this line
       // }  //when ready uncommit this line

    //success {
      //script {
        /* Use slackNotifier.groovy from shared library and provide current build result as parameter */
        //env.failedStage = "none"
        //env.emoji = ":white_check_mark: :tada: :thumbsup_all:"
        //sendNotification currentBuild.result
      //}
      //}

    // failure {
    //}
 // }  //this line close post script stage  /when ready uncommit this line
}    //This line close the jenkins pipeline
