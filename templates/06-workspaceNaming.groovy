import hudson.model.*;
import jenkins.model.*;

Thread.start {
      sleep 10000
      println "--> workspace naming"
      System.setProperty("hudson.slaves.WorkspaceList", "_")
      println "--> workspace naming... done"
}
