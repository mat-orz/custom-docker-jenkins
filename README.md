# custom-docker-jenkins

TODO:

def parallelTests = [:]

pipeline {
    agent any
    environment {
        AWS_REGION="eu-west-1"
    }
    stages {
        stage('Install Bundle') {
            steps {
                dir("terraform/tools/aws-tools/inventory") {
                    sh 'pwd'
                    sh 'ls -lathr'
                    sh 'env'
                    sh('bundle install --path .vendor/gems')
                    
                }
            }
        }

        stage('Build Dynamic Stages') {
            
                steps {
                    executeModuleScripts('test')
                }
            
        }
        
    }
}


void executeModuleScripts(String operation) {
        dir('terraform/tools/aws-tools/inventory'){
        
          def allModules = sh(returnStdout: true, script: 'bundle exec ./inventory.rb devint01 | cut -d\' \' -f2 | sort -u').trim().split("\\r?\\n")
          allModules.each { module ->  
          String action = "${operation}:${module}"  

          echo("---- ${action.toUpperCase()} ----")        
          String command = "echo ${action}"                   
          
            script {
                dir("terraform/tools/aws-tools/inventory") {
                    stage(module) {
                    sh(command)
              }
             }
            }
          }
        }
          
}
