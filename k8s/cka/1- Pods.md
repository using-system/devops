# Create a nginx pod

`kubectl run nginx --image=nginx`

# Get pods

`kubectl get pods`

# Get pods (detailed)

`kubectl get pods -o wide`

# Get details for a pod

`kubectl describe pod nginx`

# Get images used in a pod

`kubectl describe pod nginx | grep -i image`

# Delete a pod

`kubectl delete pod nginx`

# Create a yaml template

`kubectl run nginx --image=nginx --dry-run -o yaml > pod.yaml`

# Edit a pod

`kubectl edit pod nginx`