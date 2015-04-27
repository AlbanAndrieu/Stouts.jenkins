import hudson.model.*

// For each project
for(item in Hudson.instance.items) {
  println("JOB DISABLED: "+item.name)
  item.disabled=true
  item.save()
  println("\n=======")
}