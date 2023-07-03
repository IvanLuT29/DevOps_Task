pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: [[name: 'main']],
          extensions: [
            [
              $class: 'CloneOption',
              depth: 50,
              noTags: true,
              shallow: true
            ]
          ],
          userRemoteConfigs: [
            [
              url: 'https://github.com/IvanLuT29/DevOps_Task.git'
            ]
          ]
        ])
      }
    }
    
    stage('Terraform Init') {
      steps {
        dir('infrastructure') {
          sh 'terraform init'
        }
      }
    }
    
    stage('Terraform Apply') {
      steps {
        dir('infrastructure') {
          sh 'terraform apply --auto-approve'
        }
      }
    }
    
    stage('Deploy Website') {
      steps {
        dir('scripts') {
        sh './scripts/deploy.sh'
      }
    }
  }

  post {
    always {
      // Удаление временных файлов Terraform
      sh 'rm -rf .terraform terraform.tfstate*'
    }
  }
}
}