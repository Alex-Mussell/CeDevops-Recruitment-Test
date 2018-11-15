pipeline {

	agent none

	stages {
		stage('Preparing build environment') {

			agent {
				label 'build'
			}

			steps {
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

				stash includes: 'generateSigningKey.sh', name: 'generate-key',
				stash includes: '${PROJECT_HASH}-output.txt', name: 'script-to-sign'

				sh 'cat ${PROJECT_HASH}-output.txt'	
			}
		}



		stage('Unstash key generation script and assign a cron to is if they dont exist'){

			agent{
				label 'generate'
			}

			steps {
				script{
					
					def cronExists = fileExists 'myCron'

					if (!cronExists){
						unstash name: 'generate-key'
				

						sh 'echo "*/5 * * * * /var/jenkins/workspace/q-go-pipeline/generateSigningKey.sh" >> myCron'
						sh 'crontab myCron'
					}
				}
			}		
		}

		stage('Sign the build'){

			agent{
				label 'generate'
			}

			steps {
				unstash name: 'script-to-sign'
				sh './signBuild.sh ${PROJECT_HASH}-output.txt'

				sh 'echo ${PROJECT_HASH}-signed.txt'
			}
		}
	}
}
