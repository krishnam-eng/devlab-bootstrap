#!/usr/bin/env zsh

# source all envs, aliases, & functions
function szsh {

  if [ -d ~/.myenv ]; then
    for efile in ~/.myenv/*sh
    do
      echo $LOG_TS"Sourcing ${efile} ..."
      source $efile
    done
    unset efile
  fi

  if [ -d ~/.myalias ]; then
    for afile in ~/.myalias/*sh
    do
      echo $LOG_TS"Sourcing ${afile} ..."
      source $afile
    done
    unset afile
  fi

  if [ -d ~/.myfunc ]; then
    for ffile in ~/.myfunc/*sh
    do
      echo $LOG_TS"Sourcing ${ffile} ..."
      source $ffile
    done
    unset ffile
  fi
}
