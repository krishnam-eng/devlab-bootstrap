#!/bin/sh

##########
# DOT DIR
#
# All zsh config will be read from here instead of ~ home
# It is easy to create one sym link to conf gitrepo instead of creating for all files
##########

export ZDOTDIR=/home/krishnam/.myzsh/

[ -z "$TMUX" ] && export TERM=xterm-256color

# use this for log prefix

if [ -d /home/krishnam/.myenv ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in /home/krishnam/.myenv/*sh
  do
    source $efile
  done
  unset efile
fi

if [ -d /home/krishnam/.myalias ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in /home/krishnam/.myalias/*sh
  do
    source $efile
  done
  unset efile
fi

if [ -d /home/krishnam/.myfunc ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in /home/krishnam/.myfunc/*sh
  do
    source $efile
  done
  unset efile
fi

export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"
