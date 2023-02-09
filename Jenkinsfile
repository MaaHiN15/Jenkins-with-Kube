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
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                }
                }
            }
        stage('Auto Version Increment') {
            steps {
                script {
                    def currentVersion = sh(returnStdout: true, script: 'cat version.txt').trim()
                    def newVersion = currentVersion.split('.').collect { it as int }
                    newVersion[newVersion.size() - 1] = newVersion[newVersion.size() - 1] + 1
                    newVersion = newVersion.join('.')
                    sh "echo $newVersion > version.txt"
                }
            }
        }
        stage("Docker push"){
            steps {
                script {
                    sh "docker build -t maahin/maahin-app:$newVersion ."
                    sh "docker push maahin/maahin-app:$newVersion"
                }
            } 
        }
    }
}