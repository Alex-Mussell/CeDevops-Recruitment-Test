pipeline {

	agent none

    parameters {
        string(name: 'PROJECT_HASH', defaultValue: '')
    }

	stages {
		stage('Preparing build environment') {




			agent {
				label 'build'
			}

			steps {
				sh 'apt-get install figlet'

				script {
					tmp_param = sh ( 
									script: 'git --git-dir /var/jenkins/workspace/q-go-pipeline/.git rev-parse HEAD',
									returnStdout: true
									).trim()

					env.PROJECT_HASH = tmp_param
				}
			}
		}

		stage('Execute buildProject and stash generateSigningKey') {

			agent {
				label 'build'
			}


			steps {
				sh './buildProject.sh ${env.PROJECT_HASH}'


			}
		}


	}
}
