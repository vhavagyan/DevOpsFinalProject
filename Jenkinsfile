pipeline {
    
    agent any
    
    environment {
        imageName = "MyAcaDjangoImage"
        registryCredentials = "nexus"
        registry = "my nexus server ec2 dns+8085 port"
        IMAGE_TAG= "latest"
        dockerImage = ''
    }

    
    stages {
        stage('Code checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'archiveArtifacts artifacts: \'https://github.com/vhavagyan/DevOpsFinalProject\', followSymlinks: false']]])
            }
        }
    }
    

    stage('Building image') {
        steps{
            script {
                dockerImage = "docker.build -t ${imageName}:${IMAGE_TAG}"
            }
        }
    }
    
    

    stage('Uploading to Nexus') {
        steps{  
            script {
                docker.withRegistry( 'http://'+${registry}, ${registryCredentials} ) {
                    "dockerImage.push('latest')"
                }
            }
        }
    }
    
    

    stage('stop previous containers for better run') {
        steps {
            sh "docker ps -f name=${imageName} -q | xargs --no-run-if-empty docker container stop"
            sh "docker container ls -a -fname=${imageName} -q | xargs -r docker container rm"
        }
    }
    
    
      
    stage('Docker Run') {
        steps{
            script {
                sh "docker run -d -p 80:80 --rm --name ${imageName} " + ${registry} + ${imageName}
            }
        }
    }    
}
