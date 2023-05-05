#!/usr/bin/env bash
################
#description    : Helper functions to work with container env
#author	        : krishnam
################
function init_docker_compose() {

  tlog $INFO "Starting portainer..."
  docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

}

function init_minikube() {
  minikube start

  minikube addons enable metrics-server
  minikube addons list
  minikube dashboard &

  minikube status
  # default pods to setup handy utilities
  kubectl run kcurl --image=curlimages/curl
}
function purge_minikube() {
  tlog $WARN "Purging resources created in Minikube VM"
  minikube delete
}

function start_minikube() {
  # Start the timer
  start_time=$(date +%s.%N)

  if [ "$(uname)" != "Darwin" ]; then
    tlog $FATAL "This script is only for macOS"
    exit 1
  fi

  if ! pgrep "Docker Desktop" >/dev/null; then
    tlog $WARN "Docker Desktop is not running. Starting Docker Desktop and will take around 40 seconds"
    open --hide -a Docker
    sleep 45
  else
    tlog $INFO "Docker Desktop is already running"
  fi

  tlog $INFO "Launching minikube..."
  minikube start --memory=8g --cpus=4

  tlog $DEBUG "minikube status"
  minikube status

  tlog $DEBUG "IP address of the Minikube VM"
  minikube ip

  tlog $DEBUG "Kubernetes Cluster Info"
  minikube kubectl cluster-info

  tlog
  minikube dashboard & # --url=true

  if ! pgrep -f 'minikube dashboard' >/dev/null; then
    tlog $INFO "Launching minikube dashboard in background..."
    octant >/dev/null & # --disable-open-browser
  else
    tlog $WARN "Minikube dashboard is already running in the background. Kill the process before starting new"
  fi

  if ! pgrep "octant" >/dev/null; then
    tlog $WARN "Octant is not running. Starting the octant dashboard..."
    octant >/dev/null & # --disable-open-browser
  else
    tlog $INFO "Octant is already running"
  fi

  # End the timer
  end_time=$(date +%s.%N)

  # Calculate the time taken in seconds
  time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $LOG "Time taken: $time_taken seconds"

}

function shutdown_minikube() {
  # Start the timer
  start_time=$(date +%s.%N)

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

function status_minikube() {
  minikube service list
  minikube status
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