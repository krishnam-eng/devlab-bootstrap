#!/usr/bin/env zsh

# source all envs, aliases, & functions
function szsh {

  if [ -d ~/kroot/myws/env ]; then
    for efile in ~/kroot/myws/env/*sh
    do
      echo $LOG_TS"Sourcing ${efile} ..."
      source $efile
    done
    unset efile
  fi

  if [ -d ~/kroot/myws/alias ]; then
    for afile in ~/kroot/myws/alias/*sh
    do
      echo $LOG_TS"Sourcing ${afile} ..."
      source $afile
    done
    unset afile
  fi

  if [ -d ~/kroot/myws/func ]; then
    for ffile in ~/kroot/myws/func/*sh
    do
      echo $LOG_TS"Sourcing ${ffile} ..."
      source $ffile
    done
    unset ffile
  fi
}
