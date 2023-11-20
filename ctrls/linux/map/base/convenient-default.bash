#########
## sudo -  do action as substitute user  / super user
#########
# alias redo="sudo !!" - bug

# Always run as super user  as substitute user do action
alias visudo='sudo visudo'

alias apt='sudo apt'
alias systemctl='sudo systemctl'

alias groupadd='sudo groupadd'
alias groupdel='sudo groupdel'

alias useradd='sudo useradd'
alias userdel='sudo userdel'

alias chown='sudo chown'

alias passwd='sudo passwd'


alias ufw='sudo ufw'

# Don't make it default, but provide short way to do it
alias srm='sudo rm'
alias srmd='sudo rmd'
alias smv='sudo mv'

# create missing parents
alias mkdir="mkdir -p"
alias  ls="ls -h --color=auto"

alias du="du -h"
alias df="df -h"

# set color with LS_COLOR for tree
alias tree="tree -C"