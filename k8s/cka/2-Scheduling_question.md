# Manual Scheduling

 - How to force node in the yaml pod definition

# Selectors

 - Command to get all pods with selector filetering (app=myapp)
 - Command to get all pods with labels

# Taints and tolerations
 
 - List of the taint effect
 - Command to add taint on a node
 - Command to remove a taint on a node
 - Yaml definition to add a toleration on a pod
 - Command to have the toleration definition for a pod

# Node affinity

 - Command to add label color with value blue on node "mynode"
 - Command to have yaml definition of node affinity for a pod

# Resources

 - Command to have yaml definition of resources request of a pod
 - Command to have yaml definition of resources limits

# Daemon Sets

 - What is a daemon set ?
 - Command to get daemonsets from the current namespace
 - How to create a daemonset yaml template (with image nginx) ?

# Statics pods

 - What is a static pod ?
 - Where are the static pod defintion by default ?
 - How to check the directory configured for the static pod definition
 - How to connect to a another node ?


# Multiple scheduler

 - Why multiple scheduler ?
 - Procedure to create a custom scheduler
 - How to specify the scheduler name on the yaml pod definition
 - Command to get event from scheduler
 - Command to get logs from scheduler