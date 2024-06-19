#!/usr/bin/env bash

#####
# set env variables
#####
ZDOTDIR=$HOME/Paradigm/Development/Root/conf/zsh

if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
  for efile in $HOME/Paradigm/Development/Root/ctrls/linux/env/*.bash
  do
   source $efile
  done
  unset efile
fi

# load from local vault - untracted files
# Load machine specific environment variables
if [[ -d $HOME/hrt/vault/env ]]; then
	for vfile in $HOME/hrt/vault/env/*.bash
	do
		source $vfile
	done
	unset vfile
fi

export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"