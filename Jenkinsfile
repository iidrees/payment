#!groovy
pipeline {
  environment {
    BUILD_SCRIPTS_GIT="https://github.com/iidrees/payment.git"
    BUILD_HOME='/var/lib/jenkins/workspace'
  }

  agent any
  

  tools { go 'Go 1.11'}

  stages {
    stage('Checkout: Code') {
      steps {
        sh "mkdir -p $WORKSPACE/repo;\
        git config --global user.email 'idreesibraheem@gmail.com';\
        git config --global user.name 'iidrees';\
        git config --global push.default simple;\
        git clone $BUILD_SCRIPTS_GIT "
      }
    }
   
    stage('test: run test ') {
      steps {
      sh 'sudo COMMIT=test make test'
      }
    }

    stage('Docker: create image') {
      steps {
        sh 'sudo docker login -u idreeskun -p ${DOCKER_HUB}'
        sh 'sudo docker-compose build'
        sh 'sudo docker-compose push'
        sh ''
        sh 'sudo chmod +x /var/lib/jenkins/workspace/../*.sh'
        sh 'cd /var/lib/jenkins/workspace/../*.sh'
        sh 'ls -a'
        sh 'sudo bash ./jenkinsk8s.sh'

      }
    }
  }
  
  
  post {
    always {
      cleanWs()
    }
  }
}