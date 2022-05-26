# This command is used a LOT both below and in daily life
alias k=kubectl

##################################### Kubernetes Cluster and Node Management ###########################################
##### 1.1
# Getting Information about a Cluster
#   - get information about a Kubernetes cluster, the available APIs, and the API resources in a cluster.
#
#####

# Info: Kubectl is the client and Kubernetes API Server of the Kubernetes Cluster is the server. Kubernetes Cluster can be installed on variety of operating systems on local machines or remote systems or edge devices. Regardless of where you install it kubectl is the client tool to interact with the Kubernetes API Server.
# Warning: The kubectl version can be a more recent one; it does not really have to match the server version, as the latest version is usually backward compatible. However, it is not recommended to use an older kubectl version with a more recent server version.
alias kV='kubectl version --short'

# Cluster: check the cluster server information
alias kci='kubectl cluster-info'

# Cluster: check the available cluster API versions because each new Kubernetes version usually brings with it new API versions and deprecates/removes some old ones.
alias kav='kubectl api-versions'

# Cluster: shows the available resources, their short names (to use with kubectl), the API group a resource belongs to, whether a resource is namespaced or not, and the KIND type
alias kar='kubectl api-resources'

##### 1.2
# Working with Nodes
#   - cluster workload runs in nodes, where all Kubernetes pods get scheduled, deployed, redeployed, and destroyed
#   - Kubernetes runs the workload by placing containers into pods and then schedules them to run on nodes
#   - Each node has the services necessary to run pods
#     - kubelet: An agent that registers/deregisters the node with the Kubernetes API
#     - Container runtime: This runs containers
#     - kube-proxy: Network proxy.
#   - Kubernetes cluster supports nodes autoscaling, then nodes can come and go as specified by the autoscaling rules: by setting min and max node counts
#####

# View the nodes in the cluster
alias kg='kubectl get'
alias kgn='kubectl get nodes'
alias kgnV='kubectl get nodes -o wide' #verbose

# Shows the assigned Labels (which can be used to organize and select subsets of objects) and Annotations (extra information about the node is stored there)
# Shows the assigned internal and external IPs, the internal DNS name, and the hostname
# Shows the running pods on the node
# Shows the allocated resources
alias kdn='kubectl describe no'

# Displaying node resource usage
alias ktn='kubectl top nodes'

# kubectl has a command called cordon/uncordon, which allows us to make a node unschedulable
# e.g, suppose we are going to run an app's load test and we want to keep a node away from the load test
# kubectl cordon -h

# Draining nodes: e.g, You might want to remove/evict all pods from a node that is going to be deleted, upgraded, or rebooted, for example
# --ignore-daemonsets and –force.
# kubectl drain –help

# Removing nodes after draining nodes
alias kdeln='kubectl delete node'

##################################### Application Management ###########################################

##### 2.1
# Creating and Deploying Applications
#   - Kubernetes supports a few container runtimes - Docker, containerd,..
#   - Pod: A pod is a collocated group of application containers with shared volumes.
#     - Pods are the smallest deployable units that can be created, scheduled, and managed with Kubernetes.
#     - pods do not have a managed life cycle, if they die, they will not be recreated. For that reason, it is recommended that you use a deployment even if you are creating a single pod
#     - Apps in a pod all use the same network namespace, IP address, and port space. They can find and communicate with each other using localhost
#   - Deployment: deployment provides updates for ReplicaSets - ReplicaSet will try to keep three pods running all the time.
#   - Service: services provide a single stable name and address for a set of pods.
#     - By setting the service, we get an internal Kubernetes DNS name
#     - service acts as an in-cluster load balancer when you have more than one ReplicaSet
#####

### Pod management.
alias kgp='kubectl get pods'
alias kgpA='kubectl get pods --all-namespaces'
alias kgpwW'kgp --watch'
alias kgpV='kgp -o wide'
alias kdp='kubectl describe pods'

alias kep='kubectl edit pods'
alias kdelp='kubectl delete pods'
alias kgpAV='kubectl get pods --all-namespaces -o wide'


## Deployment management.
# 2.1.1 Creating a deployment
alias kcd='kubectl create deployment'

alias kgd='kubectl get deployment'
alias kgdA='kubectl get deployment --all-namespaces'
alias kgdW='kgd --watch'
alias kgdV='kgd -o wide'

alias kdd='kubectl describe deployment'

alias ked='kubectl edit deployment'
alias kdeld='kubectl delete deployment'

alias krsd='kubectl rollout status deployment'

### Service management.
# 2.1.2 Creating a service
# kubectl expose deployment nginx --port=80 --targetport=80
alias kgs='kubectl get svc'
alias kgsA='kubectl get svc --all-namespaces'
alias kgsW='kgs --watch'
alias kgsV='kgs -o wide'
alias kds='kubectl describe svc'

alias kes='kubectl edit svc'
alias kdels='kubectl delete svc'

# 2.1.3 Scaling up an application
alias ksd='kubectl scale deployment' # –replicas=2

##### 2.2
# Updating and Deleting Applications
#####
# 2.2.1 Releasing a new application version
# update image version to deploy a new application version
alias ksi='kubectl set image deployment'

# Apply a YML file - e.g, deployment creation, service creation
alias kaf='kubectl apply -f'

alias krs='kubectl rollout status'
alias krsd='kubectl rollout status deployment'

# 2.2.2 Rolling back an application release
# Rollout management.
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'
alias krud='kubectl rollout undo deployment'

# 2.2.3 Assigning an application to a specific node (node affinity)
# affinity:
#   nodeAffinity:

# 2.2.4 Scheduling application replicas to different nodes (pod affinity)
# affinity:
#   podAntiAffinity:

# 2.2.5 Exposing an application to the internet
# update service.yaml with
# spec:
#   type: LoadBalancer
# The LoadBalancer capability is dependent on the vendor integration.
# So, If you run locally with Minikube or Kind, you will never really get an external IP.

# 2.2.6 Deleting an application
alias kdeld='kubectl delete deployment'
alias kdels='kubectl delete svc'

##### 2.3
# Debugging an Application
#####
# 2.3.1 Describing a pod & Look for Events
alias kdp='kubectl describe pods'

# When kubectl describe pod does not show any information about an error, we can use another kubectl command, that is, logs.
# 2.3.2 Checking pod logs
# Logs
alias kl='kubectl logs'
alias klp='kubectl logs -p'              # print the logs for the previous instance
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'              # follow the log realtime
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# 2.3.3 Executing a command in a running container
alias kexec='kubectl exec -it' # -- bash.

#####
# Kubectl context and configuration
#####
alias kc='kubectl config'
alias kcv='kubectl config view'

alias kcss='kubectl config set-cluster'     # Set cluster with server url & certificate-authority-data
alias kcsu='kubectl config set-credentials' #  add a new user to your kubeconf

alias kcsc='kubectl config set-context'     # Tip: you can permanently save the namespace for all subsequent kubectl commands in that context using --namespace=
alias kcgc='kubectl config get-contexts'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

alias kcuc='kubectl config use-context'    # Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc-local='kubectl config use-context docker-desktop'

#####
#  Others
#####

# Execute a kubectl command against all namespaces
alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kdelns='kubectl delete namespace' # delete all resources in a namespace

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'

# get pod by namespace: kgpn kube-system"
alias kgpn='kgp -n'

# Ingress management
alias kgi='kubectl get ingress'
alias kgiA='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context --current --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcmA='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgsecA='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssA='kubectl get statefulset --all-namespaces'
alias kgssW='kgss --watch'
alias kgssV='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kgA='kubectl get all'
alias kgAA='kubectl get all --all-namespaces'

# File copy
alias kcp='kubectl cp'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

# Service account management.
alias kdsa="kubectl describe sa"
alias kdelsa="kubectl delete sa"

# DaemonSet management.
alias kgds='kubectl get daemonset'
alias kgdsw='kgds --watch'
alias keds='kubectl edit daemonset'
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'

# CronJob management.
alias kgcj='kubectl get cronjob'
alias kecj='kubectl edit cronjob'
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'

# Only run if the user actually has kubectl installed
if (( ${+_comps[kubectl]} )); then
  kj() { kubectl "$@" -o json | jq; }
  kjx() { kubectl "$@" -o json | fx; }
  ky() { kubectl "$@" -o yaml | yh; }

  compdef kj=kubectl
  compdef kjx=kubectl
  compdef ky=kubectl
fi

kres(){
    kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

