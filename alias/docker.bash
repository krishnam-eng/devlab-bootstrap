# global
alias dk="docker"

alias dkc="docker container"
alias dki="docker image"

alias dkps="docker ps"

# container cmds
alias dkcc="docker container create"

alias dkcst="docker container start"
alias dkcsta="docker container start -a"

alias dkcr="docker container run"
alias dkcrd="docker container run -d"
alias dkca="docker container attach"
alias dkcri="docker container run -it"
alias dkcrr="docker container run --rm"

alias dkcexe="docker container exec -it"

alias dkclog="docker container logs"
alias dkci="docker container inspect"

alias dkcsp="docker container stop"
alias dkcspall="docker container stop $(docker ps -q)"

alias dkcrm="docker container rm"
alias dkcrmall="docker container prune -f"

alias dkcls="docker container ls"
alias dkclsl="docker container ls --latest"
alias dkclss="docker container ls --size"
alias dkclsq="docker container ls --quiet"

# image cmds
alias dkil="docker image pull"
alias dkils="docker image ls"


