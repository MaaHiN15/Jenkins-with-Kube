pipeline{
    agent any
    stages{
        stage("Python check"){
            steps{
                script{
                    sh "python --version"
                    sh "python app.py"
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