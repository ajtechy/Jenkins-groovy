job("devops-task6-pull-code"){
    description("This job will pull repo from Github as developer push ")
    scm{
        github('ajtechy/devops-task6-jenkins-groovy', 'master')
    }
    triggers{
        githubPush()
    }
    wrappers {
    preBuildCleanup()
  }
}