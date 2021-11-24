#!/usr/bin/env zsh

# source all envs, aliases, & functions
function szsh {

  if [ -d ~/hrt/myws/env ]; then
    for efile in ~/hrt/myws/env/*sh
    do
      echo $LOG_TS"Sourcing ${efile} ..."
      source $efile
    done
    unset efile
  fi

  if [ -d ~/hrt/myws/alias ]; then
    for afile in ~/hrt/myws/alias/*sh
    do
      echo $LOG_TS"Sourcing ${afile} ..."
      source $afile
    done
    unset afile
  fi
  
 if [ -f ~/hrt/private/alias.zsh ]; then
  echo $LOG_TS"Sourcing aliases from private dir ..." 
  source ~/hrt/private/alias.zsh
 fi
  
 if [ -d ~/hrt/myws/func ]; then
    for ffile in ~/hrt/myws/func/*sh
    do
      echo $LOG_TS"Sourcing ${ffile} ..."
      source $ffile
    done
    unset ffile
  fi
}


function mkdircd {
  mkdir -p $1 && cd $1
}
