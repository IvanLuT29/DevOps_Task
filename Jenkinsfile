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
      steps {
        withCredentials([
          string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          withEnv(['AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY']) {
            withTerraformTool('Terraform') {
              sh 'terraform apply -auto-approve -input=false infrastructure/'
            }
          }
        }
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
