#####################
# description: Overridding default command behaviors
#               - change the default option of frequently used commands
#               - make sensible feature as default behavior
#               - use "command " as prefix to execute the actual command
# author       : krishnam
# sh version   : works with both bash and zsh
#####################

# set color with LS_COLOR for tree
alias tree="tree -C"

#
alias ps="ps -ef"

# run in quite mode
#   - it ignores warning messages from nanorc file. it can happen If you are using older version of nano with new version options
# alias nano="nano -q"

# enable unicode (utf-8) char by default
#   - needed for powerline
alias tmux="tmux -u"

# create missing parents
alias mkdir="mkdir -p"

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
alias ls="ls --color=auto"
alias grep='grep --color=auto -i'
alias egrep='egrep --color=auto'
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