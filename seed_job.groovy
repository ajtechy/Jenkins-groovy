job("devops-task6-pull-code"){
    description("This job will pull repo from Github as developer push ")
    
    scm{
        github('ajtechy/devops-task6-git-kubernetes-jenkins-groovy', 'master')
    }
    triggers{
        upstream("devops-task6-seed-job")
    }
    wrappers {
    preBuildCleanup()
    }
    steps {
        shell(readFileFromWorkspace("copy-code.sh"))
    }
}

job("devops-task6-check-code"){
    description("This job will check code and deploy environment accordingly")
  
    triggers {
        upstream("devops-task6-pull-code")
    }
    steps {
        shell(readFileFromWorkspace("check-code.sh"))
    }
    
}

job("devops-task6-test-code") {
    description("This job will test whether our webserver is working or not and also tigger to notify job")
  
    triggers {
         upstream("devops-task6-check-code")
    }

    steps {
        shell(readFileFromWorkspace("test-webserver.sh"))
    }
}

job("devops-task6-notify-mail") {
    description("This job will  Send Mail to Developer if webserver is not working properly ")
  
    triggers {
        upstream("devops-task6-test-code") 
    }
    steps {
        shell('cp /root/.jenkins/workspace/devops-task3-pull-code/web.html .')
    }
    publishers {
        extendedEmail {
            contentType('text/html')
            attachmentPatterns('web.html')
            triggers {
                success{
                    attachBuildLog(true)
                    subject('Build successfull')
                    content('The build was successful and deployment was done. Webserver is working properly.')
                    recipientList('anshujhalani1998@gmail.com')
                }
                failure{
                    attachBuildLog(true)
                    subject('Failed build')
                    content('The build was failed. Webserver is not working properly. update code and again push')
                    recipientList('anshujhalani1998@gmail.com')
                }
            }
        }
    }
}

buildPipelineView("devops-task6-deployment-on-K8S") {
    title("Task-6")
    selectedJob("devops-task6-pull-code")
    alwaysAllowManualTrigger(true)
    refreshFrequency(3)
    displayedBuilds(1)
    showPipelineParameters(true)
    filterBuildQueue(true)
    filterExecutors(false)
}