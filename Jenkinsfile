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

    stage('Terraform Apply') {
      environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
      }
      steps {
        sh 'terraform init -input=false infrastructure/'
        sh 'terraform apply -auto-approve -input=false infrastructure/'
      }
    }

    stage('Deploy Website') {
      steps {
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
