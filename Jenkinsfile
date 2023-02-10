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
        stage("Docker login"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker-credential', usernameVariable: 'USER', passwordVariable: 'PASS')]){
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "echo Docker Login succeed"
                }
                }
            }
        stage('Auto Version Increment') {
            steps {
                script {
                    def versionFile = 'version.txt'
                    def currentVersion = readFile(versionFile).trim()
                    sh "echo ${currentVersion} > version.txt"
                    env.DOCKER_IMAGE_TAG = "${currentVersion}-${env.BUILD_ID}"
                }
            }
        }
        stage("Docker push"){
            steps {
                script {
                    sh "docker build -t maahin/maahin-app:${env.DOCKER_IMAGE_TAG} ."
                    sh "docker push maahin/maahin-app:${env.DOCKER_IMAGE_TAG}"
                    sh "echo Image build and Pushed to Repo"
                }
            } 
        }
    }
}
