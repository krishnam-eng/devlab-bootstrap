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
#
# Option: -s search in manpages

fn fcmd(){
    echo $cs_bcyan"[whence]:$cs_byellow $(whence $1)"$cs_reset
    echo $cs_bcyan"[type]  :$cs_byellow $(type $1)"$cs_reset
    echo $cs_bcyan"[which] :$cs_byellow $(which $1)"$cs_reset

    while getopts "s" opt
    do
        case $opt in
            s) echo $cs_bcyan"[apropos]:$cs_reset $(apropos $1)";;
        esac
    done
}

# file info
fn finfo(){
    echo $cs_bcyan"[ls]$cs_reset $(ls -l $1)"
    echo $cs_byellow"[file]$cs_reset $(file $1)"
	echo $cs_bgreen"[stat]$cs_reset $(stat $1)"
}

# show only dot files
alias ld="ls -d"

# ubuntu update
fn upkg(){
    echo $cs_bcyan"UPDATE....."$cs_reset
	sudo apt-get update

	echo $cs_bgreen"UPGRADE....."$cs_reset
	sudo apt-get upgrade

	if [[ $1 == 'c' ]] ; then
	    echo $cs_bred"REMOVE....."$cs_reset
		sudo apt-get autoremove
	fi
}

