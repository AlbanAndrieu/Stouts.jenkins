import hudson.model.*

// For each slave
for (aSlave in hudson.model.Hudson.instance.nodes) {
  println("SLAVE DELETED: "+aSlave.name)
  hudson.model.Hudson.instance.removeNode(aSlave)
}