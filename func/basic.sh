#!/usr/bin/env bash

source ~wsrepo/func/colorama.sh

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

