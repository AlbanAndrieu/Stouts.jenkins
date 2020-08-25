#!/usr/bin/groovy
import jenkins.model.*;

// Cancel quiet mode and allow normal activities.
Jenkins.getInstance().doCancelQuietDown()
