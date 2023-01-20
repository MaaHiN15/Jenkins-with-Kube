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
                scirpt{
                    sh "docker --version"   
                }
            }
        }
    }
}