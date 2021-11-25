#!/usr/bin/env bash

# NOTE: check the mkdevenv-base.sh script first and come back here

function install_core_packages(){
    # Install Package Manager - Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


    # core install (some packages might be already installed)
     brew install git             # might already be there 
     brew install nano            # feature-rich CLI text editor for power users 
     brew install tmux            # terminal multiplexer
     brew install zsh             # best shell to use (already there)

    # basic tools to start with
     brew install vim             # open-source clone of vi text editor developed to be customizable and able to work with any type of text
     brew install watch           # 
     brew install curl            #
     brew install wget            #
     brew install tree            # list dir in tree form
     brew install rar unrar       # archive utilities
     brew install zip unzip       # 
     brew install xclip           # clipboard management
     brew install rsync           # [default in version > ubuntu21.04] utility tool for performing swift incremental file transfers
    
    # system utilities
     brew install exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
     brew install ranger          # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)    
     brew install ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
     brew install htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
     brew install glances         # system monitoring tool
     brew install ctop            # top-like interface for container metrics

    # have a little fun
     brew install cowsay            # An ASCII cow in terminal that will say what ever you want
     brew install figlet            # utility for creating ASCII text banners or large letters out of ordinary text
     brew install cmatrix           # shows a scrolling ‘Matrix‘ like screen in a Linux terminal [Not in venv setup]
     brew install lolcat            # rainbow view of the cat 
}


function install_dev_tools(){
    brew install python
    brew install node
    brew install elasticsearch
}

function setup_container(){
    # Docker - install docker desktop
    # https://docs.docker.com/desktop/mac/install/

    # K8S
    brew install minikube

    # check out https://github.com/krishnam-eng/homelab-dkrapps
    # for setting up various tech stack needed for your R&D
}

# For testers and developers responsible for API testing, Postman is a popular and free solution
# Postman says: Automated API testing is far superior to automated UI testing
function setup_postman_api_testenv(){
    # node is needed for postman cli runner - newman
    node --version

    # if you have node and not have npm, it is a indication that node version is old. Action: Upgrade node.
    npm --version

    # install if not exist
    brew install node

    # Java SDK is required
    java -version

    # Install if not available
    # https://docs.oracle.com/en/java/javase/15/install/installation-jdk-macos.html

    # Install newman in global mode (it installs as a global package)
    npm install -g newman
    newman --version

    # Run collection tests
    newman run ${collection_name}.json -e ${env_name}

    # For Desktop, download postman (not the agent) app from https://www.postman.com/downloads/
    # Unzip and move it to $User-Home/Applications dir
}