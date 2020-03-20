import hudson.model.*;
import jenkins.model.*;

Thread.start {
      sleep 10000
      println "--> increase git timeout"
      System.setProperty("org.jenkinsci.plugins.gitclient.Git.timeOut", "120")
      System.setProperty("hudson.plugins.git.GitSCM.verbose", "true")
      //System.setProperty("org.jenkinsci.plugins.docker.workflow.client.DockerClient.CLIENT_TIMEOUT", "240")
      println "--> increase git timeout... done"
}
