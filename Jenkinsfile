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

				stash includes: '/var/jenkins/workspace/q-go-pipeline/${PROJECT_HASH}-output.txt', name: 'hash-out'
				stash includes: '/var/jenkins/workspace/q-go-pipeline/generateSigningKey.sh', name: 'generate-key'
			}
		}

		stage('Generate key every 5 minutes on seperate slave') {

			agent {
				label 'generate'
			}

			script {
				stages {
					def cronExists = fileExists '/root/myCron'
					def generateExists = fileExists '/root/generateSigningKey.sh'

					if(cronExists && generateExists) {
						stage('Sign our project and output contents to console') {

							unstash hash-out

							sh 'signBuild.sh'
						}
					} else {
						stage('Unstash and create cron job') {

							unstash 'generate-key'

							sh 'echo "*/5 * * * * generateSigningKey.sh" >> /root/myCron'
							sh 'crontab myCron'

							sh 'echo myCron'
						}
					}
				}
			}
		}
	}
}
