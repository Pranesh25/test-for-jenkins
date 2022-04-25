pipeline{
    agent {
        label 'amazon'
    }
    
    environment {
        registry = "104247799220.dkr.ecr.us-east-1.amazonaws.com/mydocker-test"
    }
    
    stages {
        
        stage('requirements'){
 	    
 	    steps{
 	        
 	        script{
 	            
 	             sh 'yum install aws-cli -y'
 	             sh 'yum install docker -y'
 	             sh 'yum install httpd -y'
 	             sh 'yum install git'
 	             sh 'systemctl start docker'
	            
 	            dockerImage = docker.build registry
	            
 	           }
 		}
  	}
  	
  	
  	
 	
 	stage('build') {
 	    steps {
 	        script {
 	            sh 'aws ecr create-repository --repository-name mydocker-test'
 	            sh 'aws ecs register-task-definition --cli-input-json file://./root/test-for-jenkins/task.json'
 	            sh 'aws ecs list-task-definitions'
 	            sh 'aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition sample-fargate:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={[subnet-02d7be78add1c719e],securityGroups=[sg-03f74e79aa2990424],assignPublicIp=ENABLED}"'
 	            
 	        }
 	    }
 	}
 	
 	
 	stage('test'){
 	    
 	    steps{
 	        script{
 	            sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 104247799220.dkr.ecr.us-east-1.amazonaws.com'
 	             sh 'docker push 104247799220.dkr.ecr.us-east-1.amazonaws.com/mydocker-test:latest'
 	        }
 	    }
 	}
 	
 	
 	stage('deploy') {
     steps{
         script {
                sh 'docker run -d -p 8096:5000 --rm --name mypythonContainer 104247799220.dkr.ecr.us-east-1.amazonaws.com/mydocker-test:latest'
            }
      }
    }
    
    
    
    
    }
}
