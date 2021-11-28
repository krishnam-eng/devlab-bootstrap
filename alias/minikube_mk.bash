alias mk='minikube'

alias mkst='minikube start'
alias mksp='minikube stop'
alias mkdel='minikube delete'

alias mkdb='minikube dashboard'

alias mkcf='minikube config'
alias mkcfls='minikube config list'
alias mkcfvw='minikube config view'
alias mkcfg='minikube config get'
alias mkcfs='minikube config set'

alias mkao='minikube addons'
alias mkaols='minikube addons list'
alias mkaoE='minikube addons enable'
alias mkaoD='minikube addons disable'

# list all alias in this context
alias mkalias="alias | awk '/^mk/{print}' | lolcat"