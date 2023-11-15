#!/usr/bin/env bash

# Load HomeLab source code into hrt to configure DevBox
function main(){
  _install_dependencies

  _checkout_bootcode

  _make_zsh_default_shell
  _load_aliases
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


function _make_zsh_default_shell() {
    # current default shell
    echo $SHELL

    # list available shells
    cat /etc/shells

    # change default shell to zsh
    zsh --version
    sudo chsh -s $(which zsh)

  # ! Log out and log back in to see the change
}

# load named directories & list aliases
function _load_aliases() {
      source $HOME/hrt/boot/custom/alias/boot-list.zsh
      source $HOME/hrt/boot/custom/alias/boot-nameddirs.zsh
}

function _install_dependencies(){
    sudo apt install zsh

    sudo apt install git

    sudo apt install tree
}