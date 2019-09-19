#!groovy
@Library('mrp-ops-jenkins-lib') _

def dockerArgs          = getDockerAwsArgs()

def call() {

}

try {
    stage("checkout") {
        checkout scm
    }

    stage("build") {
        withDockerEnv imageName: imageName, dockerArgs: dockerArgs, 
            codeBlock: { ->
            sh "docker build -t aws-amicleaner ."
            sh "docker run -it -d aws-amicleaner"
            }
    }
}