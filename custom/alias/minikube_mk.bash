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

# To access service from minikube k8s cluster...
# create ssh tunnel
alias mks='minikube service' # hello-svc --url
# get tunnel port - service tunnel and use that for curl
alias kst='ps -ef | grep docker@127.0.0.1'
# id_rsa -L 50262:10.101.125.63:8080, - 50262 is tunnel port
# more on - https://minikube.sigs.k8s.io/docs/handbook/accessing/