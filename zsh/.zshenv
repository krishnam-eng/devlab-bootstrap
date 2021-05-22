#!/usr/bin/env bash

##########
# DOT DIR
#
# All zsh config will be read from here instead of ~ home
# It is easy to create one sym link to conf gitrepo instead of creating for all files
##########

export ZDOTDIR=~/.myzsh/

source $HOME/.myenv/path.bash

##### When to Use
# Note: This file is sourced on all invocations of the shell - for both interactive & non-interacttive
# Right place for setting command search path and other improtnat env variables
#####

if [ -d ~/.myenv ]; then
  for efile in ~/.myenv/*sh
  do
    source $efile
  done
  unset efile
fi

# use this for log prefix
export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"



. "$HOME/.cargo/env"
