#!/usr/bin/env bash
################
# description  : Boot Loader for devbox -  a convention based utility to make the dev related micro automations and configuration for productivity boost.
# author	        : Bala K
################

# Load HomeLab source code into hrt to configure DevBox
function load_boot_source(){
  _install_dependencies

  # Homelab RooT (HRT). ~/hrt will be the heart of the devbox. It contains all the files needed for successful booting process.
  mkdir $USER/hrt
  cd $USER/hrt

  # copy and add key to github ssh keys to access private repo
  ssh-keygen
  cat ~/.ssh/github.pub
  git clone --depth=1 git@github.com:krishnam-eng/homelab-devbox.git ~/hrt/boot
}

function _install_dependencies(){
    sudo apt install git
    sudo apt install tree
}



