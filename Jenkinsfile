pipeline{
	agent any
	stages{
	    stage("Git Checkout"){
		steps{
			git url:'https://github.com/Madhube1990/world-hello.git'
		     }
		}

	stage("terraform") {
            steps {
                sh 'sudo /home/ec2-user/terraform init ./jenkins'
		sh 'ls ./jenkins; sudo /home/ec2-user/terraform plan ./jenkins'
		sh 'ls ./jenkins; sudo /home/ec2-user/terraform apply ./jenkins'

            }
        }
        stage('Shell Script') {
            steps {
		sh 'ls ./jenkins; sudo /home/ubuntu/kube.sh ./jenkins'
            }
        }
	
    }
}
