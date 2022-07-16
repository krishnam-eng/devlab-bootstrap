#!/usr/bin/env bash

# NOTE: check the mkdevenv-base.sh script

function install_core_packages{
    # core install (might be already installed)
    sudo apt install tree
    sudo apt install git 
    sudo apt install nano            # feature-rich CLI text editor for power users 
    sudo apt install tmux            # terminal multiplexer
    sudo apt install zsh             # powerful sh

    # to get the latest version, it is preferable to use ppa - personal package archive repo over default ubuntu repo
    # Install Optional items later when needed

    # basic tools to start with
    sudo apt install vim             # open-source clone of vi text editor developed to be customizable and able to work with any type of text
    sudo apt install watch           # 
    sudo apt install curl            #
    sudo apt install tree            # list dir in tree form
    sudo apt install gawk            # GNU awk  
    sudo apt install rar unrar       # archive utilities
    sudo apt install zip unzip      # [default in version > ubuntu21.04]
    sudo apt install xclip           # [default in version > ubuntu21.04] clipboard management
    sudo apt install rsync           # [default in version > ubuntu21.04] utility tool for performing swift incremental file transfers
    sudo apt install guake           # drop down terminal emulator - # ! use x (x11 or xarg) display server since keybinding doesn't work well in wyaland server
    # todo: Keymapping for F12 needs to be resolved manually for the below step
    # sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/ 
    
    # system utilities
    sudo apt install exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install ranger          # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)    
    sudo apt install fd-find         # fdfind: a program to find entries in your filesytem. It is a simple, fast and user-friendly alternative to find
    sudo apt install ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
    sudo apt install htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
    sudo pip install glances         # system monitoring tool
    sudo apt install ctop            # top-like interface for container metrics
    sudo apt install sysstat         # iostat - cpu usage
    sudo apt install bridge-utils    # brctr - ethernet brdige admin cmd
}


function install_dev_tools(){
    # Java Dev: Basic Development Tools & Others
    sudo apt install openjdk-11-jre-headless
    sudo apt install openjdk-8-jre-headless
    sudo add-apt-repository ppa:cwchien/gradle # use this repo to get latest gradle version
    sudo apt install gradle          # build tool & dependency manager
    sudo apt install httpie          # user-friendly command-line HTTP client for the API era
    sudo apt install jq              # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data    
    sudo apt install apache2         # [optional] web server
    sudo apt install nginx           # [optional] web server
    sudo apt install tomcat9         # [optional] servlet container
    sudo apt install nodejs          # [optional] servlet container
    sudo apt install npm             # [optional] package manager for the nodejs platform    
    sudo apt install apache2-utils   # [optional] ab: apache bench for cli single page load test, htpassword : create pwd
    sudo apt install openssl         # [optional] to create ssl certificates    
    sudo snap install intellij-idea-community --classic # [optional] IDE for JVM
    
    # Python Dev: Virtual Env & Others
    sudo apt install python3.9       # python latest (already installed)
    sudo apt install python3-pip     # package management - Pip Installs Packages
    pip install autopep8             # vscode needs this for auto formatting
    sudo apt install virtualenv      # provides virtual environment - has its own Python binary and independent set of Python packages
    pip install virtualenvwrapper    # provides a set of commands that extend Python virtual environments for more control and better manageability. It places all your virtual environments in one directory
    sudo apt install pipx            # [optional] help you install and run end-user applications written in Python into an isolated environment. It's roughly similar to apt-get.
    pip install locust               # [optional] open source load testing tool, define user behaviour with Python code
    pip install rope                 # [optional] python refactoring library - used in vscode
    sudo snap install --classic code # IDE for light weight project (python, scripts)
    
    # Container: Check latest instructions from
    # https://docs.docker.com/engine/install/ubuntu/
    # Step 1: Set up the repository
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-releasesudo apt install docker-ce
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Step 2: Install Docker Engine
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    # Step3: Check
    sudo docker run hello-world
    # Docker Compose
    # https://docs.docker.com/compose/install/
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    # just for fun
    sudo apt install cowsay            # An ASCII cow in terminal that will say what ever you want
    sudo apt install figlet            # utility for creating ASCII text banners or large letters out of ordinary text
    sudo apt install cmatrix           # shows a scrolling ‘Matrix‘ like screen in a Linux terminal [Not in venv setup]
    sudo apt install lolcat            # [Not in venv setup]
    
    # clean if any package is no longer needed
    sudo apt update; sudo apt upgrade ; sudo apt autoremove
}
