pipeline {

	agent {
		label 'master'
	}

	environment {
		PROJECT_HASH = sh (
			script: 'git --git-dir /var/lib/jenkins/workspace/q-go-pipeline/.git rev-parse HEAD',
			returnStdout: true
		).trim()
	}

	stages {
		stage('Preparing build environment') {

			agent {
				label 'build'
			}

			steps {
				sh 'apt-get install figlet'
			}
		}

		stage('Execute buildProject.sh and stash generateSigningKey.sh') {

			agent {
				label 'build'
			}


			steps {
				sh './buildProject.sh ${PROJECT_HASH}'

				script {
					tmp_var = env.PROJECT_HASH + '-output.txt'
					stash includes: tmp_var, name: 'build-output'
				}

				sh 'cat ${PROJECT_HASH}-output.txt'
			}
		}



		stage('Unstash key generation script and run every 5 minutes. If this is already running, skip'){

			agent{
				label 'generate'
			}

			steps {
				script{
					
					def cronExists = fileExists 'myCron'

					if (!cronExists){
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
				unstash name: 'build-output'

				sh './signBuild.sh ${PROJECT_HASH}-output.txt'

				sh 'cat ${PROJECT_HASH}-output.txt-signed.txt'
			}
		}
	}

	post {  
        always {  
            emailext (
					    subject: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
					    body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
					        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
					    to: alexander.mussell@hotmail.co.uk
			)
    	}  
    }	
}
