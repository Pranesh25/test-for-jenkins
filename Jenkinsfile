pipeline{

agent {
        node{
            label 'amazon'
        }
    }

environment {
        registry = "354481699343.dkr.ecr.us-east-1.amazonaws.com/mydocker-test"
    }
// this is ec2 uri

 stages{
//   	stage('checkout'){
//   	    steps{
//   		checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/akannan1087/myPythonDockerRepo']]])
//   	    }
//   	}

    stage('checkout'){
        steps{
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Pranesh25/test-for-jenkins']]])
        }
    }
 	
  	stage('docker build'){
 	    
 	    steps{
	        
 	        script{
	            
 	            dockerImage = docker.build registry
	            
 	           }
 		}
  	}
 	
 	stage('docker push'){
 	    
 	    steps{
 	        script{
 	            sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 354481699343.dkr.ecr.us-east-1.amazonaws.com'
 	             sh 'docker push 354481699343.dkr.ecr.us-east-1.amazonaws.com/mydocker-test:latest'
 	        }
 	    }
 	}
 	
 	
 	stage('stop previous containers') {
         steps {
            sh 'docker ps -f name=mypythonContainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=mypythonContainer -q | xargs -r docker container rm'
         }
       }
       
       stage('Docker Run') {
     steps{
         script {
                sh 'docker run -d -p 8096:5000 --rm --name mypythonContainer acct_id.dkr.ecr.us-east-2.amazonaws.com/your_ecr_repo:latest'
            }
      }
    }
 	
 	
 }
}
