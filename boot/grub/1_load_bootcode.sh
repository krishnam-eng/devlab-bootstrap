#!/usr/bin/env bash

# Load HomeLab source code into hrt to configure DevBox
function main(){
  if [ "$(uname)" = "Darwin" ]; then
    _install_dependencies_darwin_macos
  else
    _install_dependencies_ubuntu
  fi

  _checkout_bootcode
}
function _create_dir_structure() {
  mkdir -p /Users/$(whoami)/Paradigm \
            Projects/Academic/{Book,Course} \
            Projects/Experimental/{Prototype,Research} \
            Projects/Personal/{Passion,Portfolio} \
            Projects/Product/{Luminos,Olympus,Tachyon}

  mkdir -p /Users/$(whoami)/Paradigm/Development/{Root,Libraries,Tools,Vault}
}

function _checkout_bootcode() {
  # ! Manual Step: copy and add key to github ssh keys to access private repo
  ssh-keygen
  cat ~/.ssh/github.pub
  git clone --depth=1 git@github.com:krishnam-eng/homelab-devbox.git /Users/$(whoami)/Paradigm/Development/Root
}

function _install_dependencies_ubuntu(){
  sudo apt install -y git  # installed by default >= ubuntu 22.04
  sudo apt install -y tree
}

function _install_dependencies_darwin_macos() {
  brew install git
  brew install tree
}




