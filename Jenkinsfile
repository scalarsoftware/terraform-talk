String terraformCredentialsId = ''

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  stage('init') {
    node {
      withCredentials([file(credentialsId: terraformCredentialsId, variable: '')]) {
        ansiColor('xterm') {
          sh 'terraform init'
        }
      }
    }
  }

  stage('plan') {
    node {
      withCredentials([file(credentialsId: terraformCredentialsId, variable: '')]) {
        ansiColor('xterm') {
          sh 'terraform plan'
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    stage('apply') {
      node {
        withCredentials([file(credentialsId: terraformCredentialsId, variable: '')]) {
          ansiColor('xterm') {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    
    stage('show') {
      node {
        withCredentials([file(credentialsId: terraformCredentialsId, variable: '')]) {
          ansiColor('xterm') {
            sh 'terraform show'
          }
        }
      }
    }
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}

