try {

  environment {
    AWS_ID = credentials("AWS_ID")
    AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
    AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
  }

  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  stage('init') {
    node {
      ansiColor('xterm') {
        sh 'terraform init'
      }
    }
  }

  stage('plan') {
    node {
      ansiColor('xterm') {
        sh 'terraform plan'
      }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    stage('apply') {
      node {
        ansiColor('xterm') {
          sh 'terraform apply -auto-approve'
        }
      }
    }

    
    stage('show') {
      node {
        ansiColor('xterm') {
          sh 'terraform show'
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
