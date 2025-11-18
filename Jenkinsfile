pipeline {
    agent any

    stages {
        stage('Build') { 
            steps {
                dir('client') {
                    bat 'npm install'
                    bat 'npm run build'
                }
            }
        }
        stage('Deploy') {
            steps {
                dir('client') {
                    bat 'xcopy build\\* C:\\PROD\\adenrel\\client\\build /S /I /Y'
                }
            }
        }
    }
}
