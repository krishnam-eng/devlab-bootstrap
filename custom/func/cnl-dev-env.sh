#!/usr/bin/env bash
################
#description    : Helper functions to work with container env
#author	        : krishnam
################

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
  minikube delete
}

function start_minikube() {
  if [ "$(uname)" != "Darwin" ]; then
    tlog $FATAL "This script is only for macOS"
    exit 1
  fi

  if ! pgrep "Docker Desktop" >/dev/null; then
    tlog $WARN "Docker Desktop is not running"
    open --hide -a Docker
    sleep 45
  else
    tlog $INFO "Docker Desktop is already running"
  fi

  tlog $INFO "Launching minikube..."
  minikube start --memory=8g --cpus=4

  tlog $INFO "Launching minikube dashboard in background..."
  minikube dashboard &

  tlog $TRACE "minikube status"
  minikube status
}

function shutdown_minikube() {
  minikube stop
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