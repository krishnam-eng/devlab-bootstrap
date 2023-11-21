#########
## sudo -  do action as substitute user  / super user
#########
# alias redo="sudo !!" - bug

# Always run as super user  as substitute user do action
alias visudo='sudo visudo'

alias apt='sudo apt'
alias systemctl='sudo systemctl'

alias chown='sudo chown'       # change owner
alias chgrp='sudo chgrp'          # change group
alias chmod='sudo chmod'      # change permissions
alias passwd='sudo passwd'   # change password

alias groupadd='sudo groupadd'
alias groupdel='sudo groupdel'

alias useradd='sudo useradd'   # low level useradd
alias userdel='sudo userdel'     # delete user
alias adduser='sudo adduser'   # interactive useradd
alias usermod='sudo usermod' #

alias ufw='sudo ufw'

# Don't make it default, but provide short way to do it
alias scat='sudo cat'
alias srm='sudo rm'
alias srmd='sudo rmd'
alias smv='sudo mv'
alias smkdir='sudo mkdir'
alias stouch='sudo touch'

# create missing parents
alias mkdir="mkdir -p"
alias  ls="ls -h --color=auto"

alias du="du -h"
alias df="df -h"

# set color with LS_COLOR for tree
alias tree="tree -C"