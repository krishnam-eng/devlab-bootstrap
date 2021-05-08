#!/usr/bin/env bash
################
#description  : bash functions to override or provide addtional details based on basic commands 
#bash_version : 5.1.4(1)-release
#author	      : krishnam
################

# Showing Where You Are - show working directory
function swd {
  echo $CS_bblue"Logical Path:$CS_reset $(command pwd -L )" # print working dir logical path
	echo $CS_bgreen"Physical Path:$CS_reset $(command pwd -P )" # physical location - useful for syslink
}

# P: Finding and Running Commands

# type command searches your environment (including aliases, keywords, functions, builtins, directories in $PATH, and the command hash table)
# which command is similar but only searches your $PATH
# apropos searches manpage names and descriptions for regular expressions supplied as arguments. This is incredibly useful when you don’t remember the name of the command you need.
#
# Option: -s search in manpages

function fcmd {
  echo $CS_bcyan"[whence]:$CS_byellow $(whence $1)"$CS_reset
  echo $CS_bcyan"[type]  :$CS_byellow $(type $1)"$CS_reset
  echo $CS_bcyan"[which] :$CS_byellow $(which $1)"$CS_reset
  while getopts "s" opt
  do
    case $opt in
      s) echo $CS_bcyan"[apropos]:$CS_reset $(apropos $1)";;
    esac
  done
}

# file info
function finfo {
  echo $CS_bcyan"[ls]$CS_reset $(ls -l $1)"
  echo $CS_byellow"[file]$CS_reset $(file $1)"
	echo $CS_bgreen"[stat]$CS_reset $(stat $1)"
}

# ubuntu update
function update {
  echo ${LOG_TS}$CS_bcyan"UPDATE: resynchronize the package index files from their sources....."$CS_reset
	sudo apt-get update --fix-missing

	echo ${LOG_TS}$CS_bgreen"UPGRADE: install the newest versions of all packages currently installed....."$CS_reset
	sudo apt-get dist-upgrade

  echo ${LOG_TS}$CS_bred"AUTO REMOVE: clean up unused dependencies....."$CS_reset
	sudo apt-get autoremove

  echo ${LOG_TS}$CS_bred"AUTO CLEAN: remove all strored archives in cache that can not be downloaded anymore....."$CS_reset
  sudo apt-get autoclean

  while getopts "ca" opt
  do
    case $opt in
      a)
        echo ${LOG_TS}$CS_bgreen"PIP: upgrade....."$CS_reset;
        sudo pip install --upgrade pip;;
      c)
        echo ${LOG_TS}$CS_bred"CLEAN: remove all strored archives in cache....."$CS_reset;
        sudo apt-get clean;;
    esac
  done
}

# source all envs, aliases, & functions
function sbash {

  if [ -d ~/.myenv ]; then
    for efile in ~/.myenv/*.bash
    do
      echo $LOG_TS"Sourcing ${efile} ..."
      source $efile
    done
    unset efile
  fi

  if [ -d ~/.myalias ]; then
    for afile in ~/.myalias/*.bash
    do
      echo $LOG_TS"Sourcing ${afile} ..."
      source $afile
    done
    unset afile
  fi

  if [ -d ~/.myfunc ]; then
    for ffile in ~/.myfunc/*.bash
    do
      echo $LOG_TS"Sourcing ${ffile} ..."
      source $ffile
    done
    unset ffile
  fi
 
}
