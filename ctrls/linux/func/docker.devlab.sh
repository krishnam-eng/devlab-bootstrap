function init_docker_environment() {
  # Start the timer
  local start_time=$(date +%s.%N)

  start_docker
  docker_dashboard
  # End the timer
  end_time=$(date +%s.%N)
  time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $LOG "Time taken in init_docker_environment: $time_taken seconds"
}

function start_docker() {
  # Start the timer
  local start_time=$(date +%s.%N)

  if [ "$(uname)" != "Darwin" ]; then
    tlog $FATAL "This script is only for macOS"
    exit 1
  fi

# Make sure Docker is up before starting minikube
  if ! pgrep -f 'rancher-desktop'>/dev/null;then
	tlog $WARN "Rancher Desktop is not running. Starting Rancher Desktop and will wait at most 120 seconds..."
	open --hide -a Rancher\ Desktop
	wait_until 120 5 "docker version --format - > /dev/null"
  else
	tlog $INFO "Rancher Desktop is already running"
  fi

#   if ! pgrep "Docker Desktop" >/dev/null; then
#     open --hide -a Docker

  # End the timer
  end_time=$(date +%s.%N)
  time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $LOG "Time taken in start_docker: $time_taken seconds"
}

function docker_dashboard() {

  # https://docs.portainer.io/start/install/server/docker/linux
  if docker ps | grep portainer > /dev/null; then
    tlog $INFO "Portainer is already running"
    docker ps --format ' {{.Image}} {{.Ports}}' | grep portainer
  else
    tlog $INFO "Running portainer container..."
    # limit resource usage like t2.micro
    docker container rm portainer-ce
    docker run -d -p 9000:9000 --name portainer-ce --cpus=1 --memory=1g --restart always -v /var/run/docker.sock:/var/run/docker.sock  portainer/portainer-ce
    # -v $HOME/.../Volume/portainer_data:/data - works with only business license

    tlog $INFO "Portainer container port is published to the host in 9000"
  fi
}

function inspect_docker() {
  tlog $INFO "docker version"
  docker version
  tlog $INFO "Docker Info"
  docker info
  tlog $INFO "Docker processes "
  docker ps
}

function shutdown_docker() {
  # Start the time
  local start_time=$(date +%s.%N)

  if [[ "$1" == "-A" || "$1" == "-all" ]]; then
    tlog $WARN "Stop ALL running containers including minikube"
    docker stop $(docker ps -a -q)
  else
    tlog $WARN "Stop all running containers except minikube"
    # todo: bug
    # set docker_ids = echo $(docker ps -a -q | grep -v $(docker ps -q -f "name=minikube"))
    echo "Run with -A to stop all containers due to known bug"
    if [ -n "$docker_ids" ]; then
      docker stop $docker_ids
    else
        tlog $INFO "No running containers to stop"
    fi
  fi

  # todo: kill docker desktop
  # End the timer
  end_time=$(date +%s.%N)
  time_taken=$(echo "$end_time - $start_time" | bc)
  tlog $LOG "Time taken in shutdown_docker: $time_taken seconds"
}

# By default, purge everything but minikube resources
function purge_docker(){
  if [[ "$1" == "-A" || "$1" == "-all" ]]; then
    shutdown_docker -A

    tlog $WARN "Remove all stopped containers"
    docker rm $(docker ps -q -a)

    tlog $WARN "Remove all Docker images"
    docker rmi $(docker image ls -q -a)

    tlog $WARN "Remove all Docker volumes"
    docker volume rm $(docker volume ls -q -a)

    tlog $WARN "Remove all Docker networks"
    docker network rm $(docker network ls -q -a)

  else
    shutdown_docker

    tlog $WARN "Remove all stopped containers"
    set docker_ids = echo $(docker ps -a -q \
      | grep -v $(docker ps -q -f "name=minikube")
      )
    docker container ls
    if [ -n "$docker_ids" ]; then
      docker rm $docker_ids
    else
        tlog $INFO "No stopped containers to remove."
    fi

    tlog $WARN "Remove all Docker volumes"
    set volumes_id = echo $(docker volume ls -q \
      | grep -v $(docker volume ls -q -f "name=minikube"))
    docker volume ls
    if [ -n "$volumes_id" ]; then
      docker rm $volumes_id
    else
        tlog $INFO "No applicable volumes to remove"
    fi

    tlog $WARN "Remove all Docker images"
    docker image ls
    docker rmi $(docker image ls -q)
#    set image_ids = echo $(docker image ls -q)
#    # todo: bug fix - condition fails with valid images list too
#    if [ -n "$image_ids" ]; then
#      docker rmi $image_ids --force
#    else
#        tlog $INFO "No applicable images to remove"
#    fi
  fi

  tlog $WARN "Remove all Docker networks but pre-defined networks & minikube"
  set network_ids = echo $(docker network ls -q  \
    | grep -v $(docker network ls -q -f "name=minikube") \
    | grep -v $(docker network ls -q -f "name=bridge") \
    | grep -v $(docker network ls -q -f "name=host") \
    | grep -v $(docker network ls -q -f "name=none") \
    | grep -v $(docker network ls -q -f "name=docker_volumes-backup-extension-desktop-extension_default") \
    )
  docker network ls
  if [ -n "$network_ids" ]; then
    docker network rm $network_ids
  else
      tlog $INFO "No applicable network to remove"
  fi
}
