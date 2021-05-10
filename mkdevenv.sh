#!/usr/bin/env bash
##############
#
#   Portable Dev Environment - Build anywhere
#
###############

# workspace
sudo apt install zsh             # powerful sh 
sudo apt install tmux            # terminal multiplexer
sudo apt install nano            # feature-rich CLI text editor for power users
sudo apt install spell           # used in nano for spell check
sudo apt install vim             # open-source clone of vi text editor developed to be customizable and able to work with any type of text

# coder
sudo apt install git             # version control
sudo apt install kdiff3          # compares and merges two or three input files or directories
sudo apt install code            # VS Code IDE

sudo apt install apache2         # web server 
sudo apt install apache2-utils   # apache bench for cli single page load test

sudo apt install python3.9       # python latest
sudo apt install python3-pip     # package management - Pip Installs Packages
sudo apt install pipx            # help you install and run end-user applications written in Python into an isolated environment. It's roughly similar to apt-get.
sudo apt install virtualenv      # provides virtual environment - has its own Python binary and independent set of Python packages
pipx install autopep8            # vscode needs this for auto formatting 
pipx install virtualenvwrapper   # provides a set of commands that extend Python virtual environments for more control and better manageability. It places all your virtual environments in one directory
pipx install locust              # open source load testing tool, define user behaviour with Python code
pipx install rope                # python refactoring library - used in vscode 


sudo apt install ruby            # need for ruby gems 
sudo apt install default-jdk     # open jdk
sudo apt install tomcat9         # servlet container
sudo apt install nodejs          # servlet container
sudo apt install npm             # package manager for the nodejs platform
sudo apt install httpie          # user-friendly command-line HTTP client for the API era


# general tools
sudo apt install tree            # list dir in tree form
sudo apt install ranger          # console file manager with vi key bindings
sudo apt install xclip           # clipboard management
sudo npm install -g tldr         # TooLongDidntRead: tldr pages are a community effort to simplify the beloved man pages with practical examples
sudo apt install rsync           # utility tool for performing swift incremental file transfers 
sudo apt install jq              # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data
sudo apt install zip             # default in > ubuntu21.04 
sudo apt install unzip           # default in > ubuntu21.04 
sudo apt install rar             # archive utilities 
sudo apt install unrar           # archive utilities 
sudo apt install gnome-tweaks    # useful to change capslock key binding

# alternatice utilities
sudo apt install exa             # more user-friendly version of ls
sudo apt install fd-find         # fdfind: a program to find entries in your filesytem. It is a simple, fast and user-friendly alternative to find
sudo apt install ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories. 
sudo apt install htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
sudo pip install glances         # system monitoring tool 
sudo apt install htop            # top-like interface for container metrics


sudo apt install sysstat         # iostat - cpu usage
sudo apt install lm-sensors      # cpu temp

# just for fun
sudo apt install cowsay          # An ASCII cow in terminal that will say what ever you want
sudo apt install figlet          # utility for creating ASCII text banners or large letters out of ordinary text
sudo apt install cmatrix         # shows a scrolling ‘Matrix‘ like screen in a Linux terminal

######
# checkout dev env github repo
######
if [[ ! -d ~/github/ohmy-linux ]]; then
    mkdir -p ~/github
    git clone https://github.com/krishnam-eng/ohmy-linux ~/github/ohmy-linux
    # if it was cloned from http, use below to change to ssh once ssh pub key added to githubsetup
    # git remote set-url origin git@github.com:krishnam-eng/practice-python.git
fi

# TMUX plugin manager
mkdir -p ~/github/ohmy-linux/tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/github/ohmy-linux/tmux/plugins/tpm

#####
# Setup zsh, bash, tmux, nano run command configs
#####

# link from the home itself
ln -s ~/github/ohmy-linux/alias  ~/.myalias
ln -s ~/github/ohmy-linux/bash   ~/.mybash
ln -s ~/github/ohmy-linux/env    ~/.myenv
ln -s ~/github/ohmy-linux/func   ~/.myfunc
ln -s ~/github/ohmy-linux/nano   ~/.mynano
ln -s ~/github/ohmy-linux/tmux   ~/.mytmux
ln -s ~/github/ohmy-linux/venv   ~/.myvenv
ln -s ~/github/ohmy-linux/zsh    ~/.myzsh


# Verify the list 
la ~/.my*

# take a backup of old configs
mkdir -p ~/.mybkp

cp ~/.bashrc ~/.mybkp/.bashrc_$(date +%y%m%d)-old
cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
cp ~/.zshenv ~/.mybkp/.zshenv_$(date +%y%m%d)-old
cp ~/.zshrc ~/.mybkp/.zshrc_$(date +%y%m%d)-old
cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old

rm -f  ~/.zshenv ~/.zshrc ~/.bashrc ~/.tmux.conf ~/.nanorc

# create links to tools configs
ln -s ~/.myzsh/.zshenv ~/.zshenv
ln -s ~/.mybash/.bashrc  ~/.bashrc
ln -s ~/.mynano/.nanorc  ~/.nanorc
ln -s ~/.mytmux/.tmux.conf ~/.tmux.conf

# set default shell to zsh [echo $SHELL]
chsh -s $(which zsh)

# mount shared folder from host os (for vbox)
mkdir -p ~/shared
sudo mount -t vboxsf  vbox_shared  ~/shared

# this is a workspace, remove all default desktop dirs and enter into zen mode
\rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos

# keep things updated. the below steps is available as a signle custom function in func/* files -- $ update
sudo apt-get update --fix-missing
sudo apt-get dist-upgrade
sudo apt-get autoremove
sudo apt-get autoclean
sudo pip install --upgrade pip
sudo apt-get clean
