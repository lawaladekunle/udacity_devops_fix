pipeline {
    environment {
    registry = "mimiobi/udacity-capstone"
    registryCredential = 'docker-hub'
    }
    
    agent any
    stages {
        
        stage ('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html' 
                sh 'pylint --disable=R,C,W1203 app.py'

                
                
            }
        }

        stage ('Cloning Git') {
            steps {
                git 'https://github.com/mimiobi/udacity-capstone-project.git'
            }
        }

        stage('Building image') {
            steps {
                script {
                    sh 'docker build --tag=lawaladekunle/udacity-capstone .'
                }
            }
        }

        stage('Deploy Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: "docker_login", url: "" ]) {
                    sh 'docker push lawaladekunle/udacity-capstone'
                    }
                }
            }
        }

        stage ('Upload latest green deployment to AWS Loadbalancer') {
            steps {
               script {
                   // Latest
                   sh 'sudo /usr/sbin/kubectl apply -f Deployment/green-webapp-deploy.yml --kubeconfig /home/ec2-user/.kube/config' 
               }
            }
        }

        stage ('Remove old blue deployment from AWS Loadbalancer') {
            steps {
               script {
                   sh 'sudo /usr/sbin/kubectl delete deploy/web-deployment-blue --kubeconfig /home/ec2-user/.kube/config'
               }
            }
        }

        stage ('Add latest blue deployment to AWS Loadbalancer') {
            steps {
               script {
                   sh 'sudo /usr/sbin/kubectl apply -f Deployment/blue-webapp-deploy.yml --kubeconfig /home/ec2-user/.kube/config'
               }
            }
        }

        stage ('Remove old green deployment from AWS Loadbalancer') {
            steps {
               script {
                   sh 'sudo /usr/sbin/kubectl delete deploy/web-deployment-green --kubeconfig /home/ec2-user/.kube/config'
               }
            }
        }
    }
}
