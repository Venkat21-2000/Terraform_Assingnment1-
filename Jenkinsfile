pipeline {
    agent any

    parameters {
        choice(
            choices: ['Destroy', 'Plan and Apply'],
            description: 'Select an action',
            name: 'Destroy_Or_Apply'
        )
    }

    environment {
        AWS_REGION = 'us-east-1'
    }
  stages {
  stage('Init') {
    steps {
      script {
        sh 'terraform init'
      }
    }
  }
  stage('Destroy') {
      when {
                expression { params.Destroy_Or_Apply == 'Destroy' }
            }
    steps {
      script {
        withAWS(region: AWS_REGION, credentials: 'AWS') {
          sh 'terraform destroy -auto-approve'
        }
      }
    }
  }

stage('Other Steps') {
            when {
                expression { params.Destroy_Or_Apply == 'Plan and Apply' }
            }
            
        
  stage('Plan') {
    steps {
      script {
        withAWS(region: AWS_REGION, credentials: 'AWS') {
          sh 'terraform plan'
        }
      }
    }
  }
        stage('Apply') {
            steps {
                script {
                    withAWS(region: AWS_REGION, credentials: 'AWS') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        stage('Get private key') {
           steps {
              script {
                    sh "sudo chmod 400 /var/lib/jenkins/workspace/Terraform_pipeline/private_key.pem"
                    sh "sudo cp /var/lib/jenkins/workspace/Terraform_pipeline/private_key.pem /home/sigmoid/"
                }
            }
         }
    }
    }
}
