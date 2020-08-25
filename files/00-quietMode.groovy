#!/usr/bin/groovy
import jenkins.model.*;

// Starts in the state that doesn't do any build.
Jenkins.getInstance().doQuietDown()
