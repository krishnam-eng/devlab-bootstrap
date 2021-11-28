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
### Manage Addon
```shell
minikube addons list

# These two needed for elasticsearch chart release
minikube addons enable storage-provisioner
minikube addons enable default-storageclass
```

