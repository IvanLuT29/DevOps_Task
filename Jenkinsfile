pipeline {
  parameters {
      string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
      booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
  }
  environment {
      AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
      AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
  }


  agent any
      options {
              timestamps ()
              ansiColor('xterm')
            }

  stages {
    stage('checkout') {
      steps {
        script{
              dir("terraform")
              {
                git 'https://github.com/IvanLuT29/website_pipeline.git'
              }
        }       
      }
    }

    stage('Plan') {
      steps {
        sh 'pwd;cd infrastructure;terraform init -input=false infrastructure/'
        sh 'pwd;cd infrastructure;terraform apply -auto-approve -input=false infrastructure/'
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