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
        stage('Kubernetes Login') {
            steps {
                sh 'microk8s kubectl get nodes'
            }
        }
        stage("Helm Check"){
            steps{
                script{
                    sh "helm version"
                }
            }
        }
        stage("Prometheus Installation"){
            steps{
                script{
                    sh "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts"
                    sh "helm repo update"
                    sh "microk8s kubectl create namespace monitoring"
                    sh "helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring"
                }
            }
        }
    }
}
