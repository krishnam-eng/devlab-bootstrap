#!/usr/bin/env zsh

# source all envs, aliases, & functions
function szsh {

  if [ -d ~/hrt/boot/env ]; then
    for efile in ~/hrt/boot/env/*sh
    do
      echo $LOG_TS"Sourcing ${efile} ..."
      source $efile
    done
    unset efile
  fi

  if [ -d ~/hrt/boot/alias ]; then
    for afile in ~/hrt/boot/alias/*sh
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
  
 if [ -d ~/hrt/boot/func ]; then
    for ffile in ~/hrt/boot/func/*sh
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
