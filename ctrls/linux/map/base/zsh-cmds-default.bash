#####################
# description: Overridding default command behaviors
#               - change the default option of frequently used commands
#               - make sensible feature as default behavior
#               - use "command " as prefix to execute the actual command
# author       : krishnam
# sh version   : works with both bash and zsh
#####################

#####################
# 1. Enable Color
#   - set color with LS_COLOR  for ls, grep, tree
# 2. Use GNU version instead BSD
#####################
alias ls="gls -h --color"
alias tree="tree -C"
alias grep='ggrep --color=auto'
alias egrep='egrep --color=auto'

#####################
# Select default version
#####################
alias python=python3

# create missing parents
alias mkdir="mkdir -p"

alias du="du -h"
alias df="df -h"


alias ps="ps -ef"

# run in quite mode
#   - it ignores warning messages from nanorc file. it can happen If you are using older version of nano with new version options
# alias nano="nano -q"

# enable unicode (utf-8) char by default
#   - needed for powerline
alias tmux="tmux -u"

# launch visual studio in bg
alias code="code . &"

#
# usual alias expansion will be suppressed with -U option and -z seems to be to avoid Ksh-isms
#
#   from Doc: A function can be marked as undefined using the autoload builtin (or functions -u or typeset -fu). Such a function has no body. When the function is first executed, the shell searches for its definition using the elements of the fpath variable. [...]
#
#   in Nutshell: autoload allows for functions to be specified without a body which then get automatically loaded when used. Source however takes as argument a script which is then executed in the environment of the current session. This feature is beneficial when having lots of utilities in functions. It allows for faster startup.
alias autoload="autoload -Uz"

#########
#     Set Default Options
#########

alias ack='ack -i'  # case insensitive search
alias watch="watch -d"
alias ping='ping -c 5'

alias df='df -H'
alias du='du -ch'
########
#      Lazy to Type
########
alias c="clear"
alias hist='history'
alias forget='history -d'
alias untar='tar -xvzf'

########
#      Lazy to Remeber
########
alias copy='pbcopy'

##########
#     Default App
##########
alias e='nano'


#########
## sudo -  do action as substitute user  / super user
#########
# alias redo="sudo !!" - bug
# Always run as super user  as substitute user do action
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

alias chsh='sudo chsh' # change shell for a user account e.g., chsh -s /bin/bash sftpclt

alias ufw='sudo ufw'

# Don't make it default, but provide short way to do it
alias scat='sudo cat'
alias srm='sudo rm'
alias srmd='sudo \rm -rf'
alias smv='sudo mv'
alias smkdir='sudo mkdir -p'
alias stouch='sudo touch'
alias svim='sudo vim'


