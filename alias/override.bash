#!/usr/bin/env bash
#####################
# description: Overridding default command behaviors
#               - change the default option of frequently used commands
#               - make sensible feature as default behavior
#               - use "command " as prefix to execute the actual command
# author       : krishnam
# sh version   : works with both bash and zsh
#####################

# ls - set color option
alias ls="ls --color=always --width=120"

# set colro to grep
alias grep="grep --color"

# set color with LS_COLOR for tree
alias tree="tree -C"

# 
alias ps="ps -ef"

# run in quite mode
#   - it ignores warning messages from nanorc file. it can happen If you are using older version of nano with new version options
alias nano="nano -q"

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
