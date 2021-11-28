### Installation
```shell
brew install minikube
```

### Manage Cluster 
```shell
minikube start
minikube dashboard
minikube stop 

minikube pause   # Pause Kubernetes without impacting deployed applications
minikube unpause
```
```shell
minikube config list

minikube config get $key
minikube config set $key $value
```
default resource is not sufficient to release helm charts in k8s cluster like es chart

```shell
minikube config view vm-driver

minikube config set cpus 4       # 4 cores
minikube config set memory 8192  # 8 GiB, 16384 - 16GiB

minikube config view vm-driver

minikube delete 

minikube start
# Possible Error - Exiting due to MK_USAGE: Docker Desktop has only 1985MB memory but you specified 16384MB
# Docker Desktop -> Settings -> Resources -> Memory, CPUs, Disk Size (update as per need)
# Please note docker uses GB not GiB which means set more than what you require for k8s node

```

### Manage Addon
```shell
minikube addons list

# These two needed for elasticsearch chart release
minikube addons enable storage-provisioner
minikube addons enable default-storageclass
```

