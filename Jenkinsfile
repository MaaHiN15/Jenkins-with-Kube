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
                withCredentials([usernamePassword(credentialsId: 'docker-credential', usernameVariable: 'USER', passwordVariable: 'PASS')]){
                    sh "docker build -t maahin/maahin-app:1.0 ."
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push maahin/maahin-app:1.0"
                }
                }
            }
        }
    }
