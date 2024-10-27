
pipeline {
    agent any
    environment {
        // AWS Credentials
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    stages {
        stage('Code Git Repo') {
            steps {
                git(
                    url: "https://github.com/rav2rao/ec2-terra-jenkins.git",
                    branch: "main"
                 )   
                //git branch: 'main', url: 
            }
        }    
        stage ("Terraform Initialize") {
            steps {
                sh ('terraform init')
                // script {
                //     // Terraform initializes to get the plugins from provider
                //     sh '''
                //     terraform init
                //     '''
                // }
            }
        }
        
        stage ("Terraform Plan before deployment") {
            steps {
                sh ('terraform plan')
                // script {
                //     // Plan the Terraform deployment
                //     sh '''
                //     terraform plan -out=tfplan
                //     '''
                // }
            }
        }

        stage ("Terraform Apply to provision") {
            steps {
                sh ('terraform apply --auto-approve')
                // script {
                //     // Apply the Terraform plan
                //     sh '''
                //     terraform apply -auto-approve tfplan
                //     '''
                // }
            }
        }

        stage('Verify Resource Deployed') {
            steps {
                script {
                    // You can add commands to verify the EC2 instance or any resources
                    sh '''
                    echo "Deployment Successful. Checking EC2 instance..."
                    # Example command to list EC2 instances
                    aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name]" --output table
                    '''
                }
            }
        }
    }

    post {
        always {
            // Cleanup: Remove the Terraform plan file if it exists
            script {
                sh '''
                rm -f tfplan
                '''
            }
        }
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
