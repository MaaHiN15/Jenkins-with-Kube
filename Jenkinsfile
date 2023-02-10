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
                    // Read the current version number from version.txt
                    def versionFile = 'version.txt'
                    def currentVersion = readFile(versionFile).trim()

                    // Increment the patch version number
                    def versionParts = currentVersion.split('.')
                    
                    if (versionParts.length != 3) {
                        error("Invalid version format: ${currentVersion}. Version should be in the format MAJOR.MINOR.PATCH.")
                    }
                    def patchVersion = versionParts[2].toInteger() + 1
                    def newVersion = "${versionParts[0]}.${versionParts[1]}.${patchVersion}"

                    // Write the new version number to version.txt
                    writeFile file: versionFile, text: "${newVersion}\n"

                    // Set an environment variable with the new version number
                    env.DOCKER_IMAGE_TAG = newVersion
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
