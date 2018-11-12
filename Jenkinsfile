pipeline {

	stages {
		stage('Preparing build environment') {

			agent {
				label 'build'
			}

			steps {
				git branch: 'master',
					credentialsId: 'f6752bed-dfa8-4de8-9a89-b66d46c08d29',
					url: 'ssh://git@github.com:Alex-Mussell/CeDevops-Recruitment-Test.git'

				sh 'apt-get install figlet'
			}
		}
	}
}