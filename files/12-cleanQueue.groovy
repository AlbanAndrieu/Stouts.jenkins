import jenkins.model.*

Jenkins.getInstance().queue.items.each { Jenkins.instance.queue.cancel(it.task) }
