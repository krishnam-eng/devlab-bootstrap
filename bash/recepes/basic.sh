#!/usr/bin/env bash

#########

#########

# P: Showing Where You Are 

pwd -L # print working dir logical path 
pwd -P # physical location - useful for syslink

alias pwdp="pwd -P"

# P: Finding and Running Commands

type    # type command searches your environment (including aliases, keywords, functions, builtins, directories in $PATH, and the command hash table)
which   # which command is similar but only searches your $PATH
apropos # apropos searches manpage names and descriptions for regular expressions supplied as arguments. This is incredibly useful when you don’t remember the name of the command you need.

fn fcmd(){
  echo "In Your Environment: $(type $1)"
  echo "In Your Path: $(which $1)"
  echo "In manpages: $(apropos $1)"
}

