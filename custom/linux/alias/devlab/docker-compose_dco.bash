# main command
alias dco="docker-compose"

# list all alias in this context
alias dcoalias="alias | awk '/^dco/{print}' | lolcat"

alias dcoup="docker-compose up"	# Build, (re)create, start, and attach to containers for a service
alias dcoupb="docker-compose up --build"	# Same as dcup, but build images before starting containers
alias dcoupd="docker-compose up -d"	# Same as dcup, but starts as daemon
alias dcodn="docker-compose down"	# Stop and remove containers

alias dcor="docker-compose run"	# Run a command in container
alias dcob="docker-compose build"	# Build containers
alias dcost="docker-compose start"	# Start a container
alias dcors="docker-compose restart"	# Restart container
alias dcosp="docker-compose stop"	# Stop a container

alias dcoe="docker-compose exec"	# Execute command inside a container
alias dcok="docker-compose kill"	# Kills containers

alias dcorm="docker-compose rm"	# Remove container

alias dcops="docker-compose ps"	# List containers
alias dcolg="docker-compose logs"	# Show logs of container
alias dcolf="docker-compose logs -f"	# Show logs and follow output

alias dcol="docker-compose pull"	# Pull image of a service



