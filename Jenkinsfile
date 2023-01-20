pipeline{
    agent any
    stages{
        stage("Python check"){
            steps{
                script{
                    sh "python3 --version"
                    sh "python3 app.py"
                }
            }
        }
        stage("Docker check"){
            steps{
                sh "docker --version"   
                sh "docker ps"
                }
            }
        }
    }
