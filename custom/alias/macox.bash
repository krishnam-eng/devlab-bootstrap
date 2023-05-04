
# Open finder with current dir
alias of='open_command $PWD'
alias idea='open -na "IntelliJ IDEA.app"'

# Change the power management settings on your MacBook Pro
# to keep the network connection active even when the system is locked
#   - workaround for minikube loosing the network connections with kube resources
alias macpon="sudo pmset -a tcpkeepalive 1"
alias macpoff="sudo pmset -a tcpkeepalive 0"