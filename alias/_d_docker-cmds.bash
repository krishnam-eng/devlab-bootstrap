#!/usr/bin/env bash

alias d="docker"

#--------------------------------------------------
# docker Aliases
# (grouped by usage and then sorted alphabetically)
#--------------------------------------------------

alias dc="docker container"
alias di="docker image"

alias dps="docker ps"

# container cmds
alias dcc="docker container create"

alias dcst="docker container start"
alias dcsta="docker container start -a"

alias dcr="docker container run"
alias dcrd="docker container run -d"
alias dca="docker container attach"
alias dcri="docker container run -it"
alias dcrr="docker container run --rm"

alias dcexe="docker container exec -it"

alias dclog="docker container logs"
alias dci="docker container inspect"

alias dcsp="docker container stop"
alias dcspall='docker container stop $(docker ps -q)'

alias dcrm="docker container rm"
alias dcrmall="docker container prune -f"

alias dcls="docker container ls"
alias dclsl="docker container ls --latest"
alias dclss="docker container ls --size"
alias dclsq="docker container ls --quiet"

# image cmds
alias dil="docker image pull"
alias dib="docker image build"
alias dils="docker image ls"


