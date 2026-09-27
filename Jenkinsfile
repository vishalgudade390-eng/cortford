pipeline {
    agent any
    tools {
        nodejs 'npm'
    }
    environment {
        Name = "Vishal"
    }

    stages {
        stage('clone') {
            steps {
                echo 'Hello World'
                git branch: 'main', url: 'https://github.com/vishalgudade390-eng/cortford'
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
                sh 'npm run build'
            }
        }
    }
}
