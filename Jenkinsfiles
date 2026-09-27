pipeline {
    agent { 
        label 'node'
    }
    tools {
        nodejs 'npm'
    }
    environment {
        Name = "Mantasha"
    }

    stages {
        stage('clone') {
            steps {
                echo 'Hello World'
                git branch: 'main', url: 'https://github.com/mantu0tech/weather_app_node_js.git'
            }
        }
         stage('build') {
            steps {
                echo 'Hello World'
                sh 'npm i'
            }
        }
         stage('deplyo') {
            steps {
                echo 'Hello World'
                sh 'npm start'
            }
        }
    }
}
