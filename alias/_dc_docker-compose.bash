alias dco="docker-compose" #docker-compose main command

alias dcup="docker-compose up"	# Build, (re)create, start, and attach to containers for a service
alias dcupb="docker-compose up --build"	# Same as dcup, but build images before starting containers
alias dcupd="docker-compose up -d"	# Same as dcup, but starts as daemon
alias dcdn="docker-compose down"	# Stop and remove containers

alias dcps="docker-compose ps"	# List containers

alias dcr="docker-compose run"	# Run a command in container
alias dcb="docker-compose build"	# Build containers
alias dcstart="docker-compose start"	# Start a container
alias dcrs="docker-compose restart"	# Restart container
alias dce="docker-compose exec"	# Execute command inside a container
alias dcstop="docker-compose stop"	# Stop a container
alias dck="docker-compose kill"	# Kills containers

alias dcrm="docker-compose rm"	# Remove container

alias dcl="docker-compose logs"	# Show logs of container
alias dclf="docker-compose logs -f"	# Show logs and follow output

alias dcpull="docker-compose pull"	# Pull image of a service

