#!/usr/bin/env bash

#########
# pwd()
# fcmd()
# fcmdall()
# finfo()
#########

# terminal color style format string
cs_black="\033[30m"
cs_red="\033[31m"
cs_green="\033[32m"
cs_yellow="\033[33m"
cs_blue="\033[34m"
cs_magenta="\033[35m"
cs_cyan="\033[36m"
cs_white="\033[37m"

cs_bblack="\033[90m"
cs_bred="\033[91m"
cs_bgreen="\033[92m"
cs_byellow="\033[93m"
cs_bblue="\033[94m"
cs_bmagenta="\033[95m"
cs_bcyan="\033[96m"
cs_bwhite="\033[97m"

cs_reset="\033[0m"


# P: Showing Where You Are - show working directory 

fn swd(){
	echo $cs_bblue"Logical Path:$cs_reset $(command pwd -L )" # print working dir logical path
	echo $cs_bgreen"Physical Path:$cs_reset $(command pwd -P )" # physical location - useful for syslink
}

# P: Finding and Running Commands

# type command searches your environment (including aliases, keywords, functions, builtins, directories in $PATH, and the command hash table)
# which command is similar but only searches your $PATH
# apropos searches manpage names and descriptions for regular expressions supplied as arguments. This is incredibly useful when you don’t remember the name of the command you need.

fn fcmd(){
  echo $cs_yellow"[type]:$cs_reset $(type $1)"
  echo $cs_byellow"[which]:$cs_reset $(which $1)"
  echo $cs_yellow"[whence]:$cs_reset $(whence $1)"
}

fn fcmdall(){
  echo $cs_yellow"[type]:$cs_reset $(type $1)"
  echo $cs_byellow"[which]:$cs_reset $(which $1)"
  echo $cs_yellow"[whence]:$cs_reset $(whence $1)"
  echo $cs_byellow"[apropos]:$cs_reset $(apropos $1)"
  echo "\n"
}

# file info 
fn finfo(){
	echo $cs_bgreen"[stat]$cs_reset $(stat $1)"
	echo $cs_byellow"[file]$cs_reset $(file $1)"
	echo $cs_bcyan"[ls]$cs_reset $(ls -l $1)"
}

# show only dot files
alias ld="ls -d"
