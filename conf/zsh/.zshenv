#!/usr/bin/env zsh

##########
# DOT DIR
#
# All zsh config will be read from here instead of ~ home
# It is easy to create one sym link to conf gitrepo instead of creating for all files
##########

export ZDOTDIR=~/hrt/boot/conf/zsh

##### When to Use
# Note: This file is sourced on all invocations of the shell - for both interactive & non-interacttive
# Right place for setting command search path and other improtnat env variables
#####

if [ -d ~/hrt/boot/custom/env ]; then
  for efile in ~/hrt/boot/custom/env/*.(bash|zsh)
  do
   source $efile
  done
  unset efile
fi

# use this for log prefix
# (bug: breaks in mac) export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"
export LOG_TS="${CS_byellow}[${CS_yellow}$(date -u)${CS_byellow}] ${CS_reset}"
