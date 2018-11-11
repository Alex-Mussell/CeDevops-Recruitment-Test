pipeline {
	
	git url: https://github.com/Alex-Mussell/CeDevops-Recruitment-Test.git

	options {
	  timestamps()
	}

	properties(
		[
			pipelineTriggers(
				[
					cron('*/5 * * * *')
				]
			)
		]
	)

    stages {
        stage('build') {
        	agent {
        		label 'building'
        	}
            steps {
            	gitHash = sh(returnStdout: true, script: 'git rev-parse HEAD')
                sh 'buildProject.sh $gitHash'
            }
        }
	    stage('sign') {
	    	agent {
	    		label 'generate-key'
	    	}
	    	steps {
	    		sh 'generateSigningKey.sh'.  <---- Every 5 minutes
	    	}
    }

    post {
        always {
            echo 'Sending email'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
    }

}