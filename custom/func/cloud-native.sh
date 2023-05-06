#!/usr/bin/env bash
################
#description    : Helper functions to work with container env
#author	        : krishnam
################

#
######################### < Minikube > #########################
#

function init_minikube() {
  # Start the timer
  local start_time=$(date +%s.%N)

  start_minikube
  enable_minikube_addons
  create_diagnostic_services
  inspect_minikube

  # End the timer
  local end_time=$(date +%s.%N)
  local time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $TRACE "Time taken for init_minikube: $time_taken seconds"
}

function start_minikube() {
  # Start the timer
  local start_time=$(date +%s.%N)

  if [ "$(uname)" != "Darwin" ]; then
    tlog $FATAL "This script is only for macOS"
    exit 1
  fi

  # Make sure Docker is up before starting minikube
  if ! pgrep "Docker Desktop" >/dev/null; then
    tlog $WARN "Docker Desktop is not running. Starting Docker Desktop and will wait at most 60 seconds..."
    open --hide -a Docker
    wait_until 60 5 "docker version --format - > /dev/null"
  else
    tlog $INFO "Docker Desktop is already running"
  fi

  tlog $INFO "Launching minikube..."
  minikube start --memory=8g --cpus=4

  # End the timer
  local end_time=$(date +%s.%N)
  local time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $TRACE "Time taken for start_minikube: $time_taken seconds"
}

function enable_minikube_addons() {
  # Start the timer
  lcoal start_time=$(date +%s.%N)

  # The default addons: dashboard, storage-provisioner, default-storageclass, ingress, and registry

  # for monitoring the resource usage of Kubernetes nodes and containers
  minikube addons enable metrics-server > /dev/null

  # The Portainer add-on provides a web-based graphical user interface (GUI)
  # to manage Docker containers, images, networks, and volumes running inside a Minikube cluster
  # to deploy and manage Kubernetes resources from the same UI, including managing namespaces, pods, services, and deployments
  minikube addons enable portainer > /dev/null

  # Container Storage Interface (CSI) driver that provides the ability to use hostPath as a persistent volume.
  # HostPath is a simple way to provide persistent storage for pods in a single node Kubernetes cluster or in a development or test environment
  minikube addons enable volumesnapshots > /dev/null
  minikube addons enable csi-hostpath-driver > /dev/null

  # The Kong addon for Minikube installs the Kong API Gateway in the Kubernetes cluster.
  # Kong is an open-source API gateway that allows developers to manage API requests, authentication, and traffic policies.
  # minikube addons enable kong > /dev/null

  # installs the Istio service mesh in the Kubernetes cluster.
  # The Minikube Istio add-on installs the Istio control plane components such as Pilot, Mixer, Citadel, and Galley, and the Istio data plane sidecar proxy (Envoy) in each pod of the service mesh
  # minikube addons enable istio > /dev/null

  # End the timer
  local end_time=$(date +%s.%N)
  local time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $TRACE "Time taken for enable_minikube_addons: $time_taken seconds"

}
function create_diagnostic_services(){
  # Start the timer
  local start_time=$(date +%s.%N)

  # default pods to setup handy utilities
  kubectl run kcurl --image=curlimages/curl

  # Start useful diagnostics tools
  tlog $INFO "Launching minikube dashboard in the background..."
  minikube dashboard & # --url=true

  if docker ps | grep portainer > /dev/null; then
    tlog $INFO "Portainer is already running"
  else
    tlog $INFO "Running portainer container..."
    docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce
    tlog $INFO "Portainer container port is published to the host in 9000"
  fi

  if pgrep "octant" >/dev/null; then
    tlog $INFO "Octant is already running"
  else
    tlog $WARN "Octant is not running. Starting the octant dashboard..."
    octant >/dev/null --disable-open-browser
  fi

  #Prometheus: To monitor the performance and health of your Kubernetes cluster.
  #Grafana: To create and display dashboards for monitoring Kubernetes and other systems.
  #Fluentd: To collect, parse, and forward logs from containers and applications running on Kubernetes.
  #Elasticsearch: To store and search logs and other data.
  #Kibana: To visualize and analyze data stored in Elasticsearch.

  # End the timer
  local end_time=$(date +%s.%N)
  local time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $TRACE "Time taken for create_diagnostic_services: $time_taken seconds"
}

function inspect_minikube() {
  tlog $DEBUG "minikube status"
  minikube status
  tlog $DEBUG "IP address of the Minikube VM"
  minikube ip
  tlog $DEBUG "Kubernetes Cluster Info"
  minikube kubectl cluster-info
}

function shutdown_minikube() {
  # Start the timer
  local start_time=$(date +%s.%N)

  tlog $INFO "Shutting down Minikube"
  minikube stop --keep-context-active=true

  if pgrep -f 'minikube dashboard' >/dev/null; then
    tlog $WARN "Killing Minikube dashboard..."
    # kill $(pgrep -f 'minikube dashboard')
    tlog $WARN "kill $(pgrep -f 'minikube dashboard')"
  fi

  # End the timer
  end_time=$(date +%s.%N)

  # Calculate the time taken in seconds
  time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $LOG "Time taken: $time_taken seconds"
}

function purge_minikube() {
  tlog $WARN "Purging resources created in Minikube VM"
  minikube delete
}

#
######################### < Docker > #########################
#

function init_docker_compose() {

  tlog $INFO "Starting portainer..."
  docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

}

function shutdown_docker(){
  echo "Stop all running containers"
  docker rm $(docker ps -a -q)
}

function purge_docker(){
  echo "Stop all running containers"
  docker rm $(docker ps -a -q)
  # docker ps -a | egrep 'gcr' | cut -f 1 -d ' '

  echo "Remove all Docker images"
  docker rmi $(docker images -q)

  echo "Remove all stopped containers"
  docker stop $(docker ps -a -q)

  echo "Remove all Docker volumes"
  docker volume rm $(docker volume ls -q)

  echo "Remove all Docker networks"
  docker network rm $(docker network ls -q)
}

alias kshell="kubectl attach kcurl -c kcurl -i -t"
# todo: create utility pod which has tools like curl wget

alias kports=" netstat -an | grep LISTEN"
# todo: find better / more accurate way