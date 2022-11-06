# Pod

 - Yaml structure of a pod
 - Command to create a pod with nginx image
 - Command to get all pods from current namespace
 - Command to get all pods from current namespace (detailed version)
 - Command to get details for the pod nammed "nginx".
 - Command to get images used for the pod nammed "nginx"
 - Command to delete the pod nginx
 - Command to create a yaml template for a pod use image nginx
 - Command to edit pod nginx

# Replicaset

 - Command to get all replicaset from current namespace
 - Command to create a yaml template of a replicaset
 - Command to edit a replicaset
 - Api version for replicaset

# Deployment

 - Command to create a deployment with nginx image and 5 replicaset
 - Command to scale the depoyment "deploy1" to 5 instances
 - Api version for Deployment

# Namespace

 - Command to get all pods from the namespace "ns1"
 - Specify namespace in the yaml structure of a pod
 - Command to switch namespace to "myns"

# Service

 - Command to create yaml template for : 
   -  Service = myService, Deployment = mydeploy, targetPort = 8080, port = 8080 (node port type)
   -  A pod "mypod" with service associated for port 8080

# Monitoring

 - Command to get monitoring stats for node
 - Command to get monitoring stats for pod

# Logging

 - Command to get log for a pod (without or with container name specified)

# VI editor

 - Shortcut to insert text
 - Shortcut to save and quit
 - Shorcut to force quit without save