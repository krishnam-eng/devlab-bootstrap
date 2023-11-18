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
if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
  for efile in ~/hrt/boot/ctrls/linux/env/*.(bash|zsh)
  do
   source $efile
  done
  unset efile
fi

# load from local vault - untracted files
# Load machine specific environment variables
if [[ -d ~/hrt/vault/env ]]; then
	for vfile in ~/hrt/vault/env/*sh
	do
		source $vfile
	done
	unset vfile
fi
