pipeline {

	agent none

	stages {
		stage('Preparing build environment') {

			agent {
				label 'build'
			}

			steps {
				git branch: 'master',
					credentialsId: 'ad98a82a-3210-440e-abf5-d28bee6c6f93',
					url: 'git@github.com:Alex-Mussell/CeDevops-Recruitment-Test.git'

				sh 'ls -lat'

				sh 'apt-get install figlet'
			}
		}

		stage('Execute buildProject and stash generateSigningKey') {

			agent {
				label 'build'
			}

			environment {
				PROJECT_HASH = sh (
				script: 'git --git-dir /var/jenkins/workspace/q-go-pipeline/.git rev-parse HEAD',
				returnStdout: true
				)
			}

			steps {
				sh './buildProject.sh ${PROJECT_HASH}'

				
			}
		}



		stage('Unstash key generation script and assign a cron to is if they dont exist'){

			agent{
				label 'generate'
			}

			steps {
				script{
					
					def cronExists = fileExists 'myCron'

					if(!cronExists){
						node('build'){
							stash includes: '/var/jenkins/workspace/q-go-pipeline/generateSigningKey.sh', name: 'generate-key'
						}	
						unstash 'generate-key'
					

						sh 'echo "*/5 * * * * /root/generateSigningKey.sh" >> myCron'
						sh 'crontab myCron'
					}
				}
			}		
		}
	}
}
