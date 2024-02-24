#!/usr/bin/env bash

# Load HomeLab source code into hrt to configure DevBox
function main(){
  _install_dependencies

  _checkout_bootcode
}

function _checkout_bootcode() {
    # Homelab RooT (HRT). ~/hrt will be the heart of the devbox. It contains all the files needed for successful booting process.
    mkdir $USER/hrt
    cd $USER/hrt

    # ! Manual Step: copy and add key to github ssh keys to access private repo
    ssh-keygen
    cat ~/.ssh/github.pub
    git clone --depth=1 git@github.com:krishnam-eng/homelab-devbox.git $HOME/hrt/boot
    tree -L 3 ~/hrt/boot
}

function _install_dependencies(){
    sudo apt install -y git  # installed by default >= ubuntu 22.04
    sudo apt install -y tree
}