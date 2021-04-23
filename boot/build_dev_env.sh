#!/usr/bin/env bash

##############
#
#   Portable Dev Environment - Build anywhere
#
###############

#####
#  Install List
#####
sudo apt install git
sudo apt install zsh
sudo apt install tmux
sudo apt install nano

sudo apt install xclip

######
# checkout dev env github repo
######

mkdir -p ~/github

# Setup SSH pub key for secure interaction with github
ssh-keygen -t ed25519 -C "krishnam.balamurugan.eng@gmail.com" 

# Copy public key and add key in github with this.  github->"Setting" -> "SSH and GPG keys".
cat ~/.ssh/id_ed25519.pub | xclip -sel clip

if [[ ! -d ~/github/ohmy-linux ]]; then
    echo "cloning ohmy-linux repo..."
    git clone git@github.com:krishnam-eng/ohmy-linux ~/github/ohmy-linux
    
    # if it was cloned from http, use below to change to ssh
    # git remote set-url origin git@github.com:krishnam-eng/practice-python.git
fi

# TMUX plugin manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  mkdir -p  ~/.tmux/plugins/
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#####
# Setup zsh, bash, tmux, nano run command configs
#####

# take a backup
mkdir -p ~/.mybkp
mv .zshrc ~/.mybkp/.zshrc_$(date +%y%m%d)-old
mv .bashrc ~/.mybkp/.bashrc_$(date +%y%m%d)-old

# link from the home itself
ln -s ~/github/ohmy-linux/zsh  ~/.myzsh
ln -s ~/github/ohmy-linux/bash  ~/.mybash
ln -s ~/github/ohmy-linux/tmux  ~/.mytmux
ln -s ~/github/ohmy-linux/nano  ~/.mynano
ln -s ~/github/ohmy-linux/func  ~/.myfunc
ln -s ~/github/ohmy-linux/alias  ~/.myalias


# for zsh (env to start using ~/.myzsh as zdotdir)
ln -s ~/.myzsh/.zshenv ~/.zshenv

# for bash
ln -s ~/.mybash/.bashrc  ~/.bashrc

# for nano 
ln -s ~/.mynano/.nanorc  ~/.nanorc

# for tmux 
ln -s ~/.mytmux/.tmux.conf ~/.tmux.conf

# set default shell to zsh [echo $SHELL]
chsh -s $(which zsh)
