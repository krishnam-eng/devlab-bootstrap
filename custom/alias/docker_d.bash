#!/usr/bin/env bash

alias d="docker"

# list all alias in this context
alias dalias="alias | awk '/^d/{print}' | lolcat"

alias dc="docker container"
alias di="docker image"
alias ds="docker system"

alias dps="docker ps"

# list all alias in this context
alias dalias="alias | awk '/^d/{print}' | lolcat"
alias dcalias="alias | awk '/^dc/{print}' | lolcat"
alias dialias="alias | awk '/^di/{print}' | lolcat"

# container cmds
alias dcc="docker container create"

alias dcst="docker container start"
alias dcsta="docker container start -a"

alias dcr="docker container run"
alias dcrD="docker container run -d"
alias dca="docker container attach"
alias dcri="docker container run -it"
alias dcrr="docker container run --rm"

alias dcexe="docker container exec -it"

alias dclg="docker container logs"
alias dci="docker container inspect"

alias dcsp="docker container stop"
alias dcspA='docker container stop $(docker ps -q)'

alias dcrm="docker container rm"
alias dcrmA="docker container prune -f"

alias dcls="docker container ls"
alias dclsA="docker container ls --all"
alias dclsl="docker container ls --latest"
alias dclss="docker container ls --size"
alias dclsq="docker container ls --quiet"

# image cmds
alias dil="docker image pull"
alias dils="docker image ls"
alias dirmA="docker image prune -f"

# build with tag name; run maven build before building image
alias dib="mvn clean install -DskipTests; docker image build -t" 

# system utilities
alias dsrmA="docker system prune -a"
alias drmA="docker system prune && docker image prune && docker container prune && docker volume prune"
alias dlsA="docker image list && docker container list && docker volume list"
