pipeline {
    agent any
    tools {
        nodejs 'demo'
    }
    environment {
        Name = "Vishal"
    }

    stages {
        stage('clone') {
            steps {
                echo 'Hello World'
                git branch: 'main', url: 'https://github.com/vishalgudade390-eng/pipeline-test'
            }
        }
         stage('build') {
            steps {
                echo 'Hello World'
                sh 'npm i'
            }
        }
         stage('builing the artifac') {
            steps {
                echo 'Hello World'
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: '', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
}
            }
        }
    }
}
