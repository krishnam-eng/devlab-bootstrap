#!/bin/sh

##########
# DOT DIR
#
# All zsh config will be read from here instead of ~ home
# It is easy to create one sym link to conf gitrepo instead of creating for all files
##########

export ZDOTDIR=~/.myzsh/

[ -z "$TMUX" ] && export TERM=xterm-256color

# use this for log prefix

if [ -d ~/.myenv ]; then
  for efile in ~/.myenv/*sh
  do
    source $efile
  done
  unset efile
fi

export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"
