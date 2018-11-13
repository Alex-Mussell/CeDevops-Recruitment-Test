pipeline {
	
	environment {
		projectHash = sh 'git --git-dir /var/jenkins/workspace/q-go-pipeline/.git rev-parse HEAD'
	}

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

			steps {
				script {
					def PROJECT_HASH = sh (
						script: 'git --git-dir /var/jenkins/workspace/q-go-pipeline/.git rev-parse HEAD',
						returnStdout: true
					)

					sh './buildProject.sh ${PROJECT_HASH}'
				}


			}
		}
	}
}