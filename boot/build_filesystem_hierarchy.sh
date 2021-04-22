#!/usr/bin/env bash

##############
#
#   Portable Dev Environment - Build anywhere
#
###############

######
# checkout github repos
######

mkdir -p ~/github

# Setup SSH pub key for secure interaction with github
ssh-keygen -t ed25519 -C "krishnam.balamurugan.eng@gmail.com" 

# Copy public key and add key in github with this.  github->"Setting" -> "SSH and GPG keys".
cat gh_id_ed25519.pub | xclip -sel clip

if [[ ! -d ~/github/ohmy-linux ]]; then
    echo "cloning ohmy-linux repo..."
    git clone git@github.com:krishnam-eng/ohmy-linux ~/github/ohmy-linux
fi

if [[ ! -d ~/github/practice-python ]]; then
    echo "cloning practice-python repo..."
    git clone git@github.com:krishnam-eng/practice-python.git ~/github/practice-python
fi

if [[ ! -d ~/github/practice-java-performance-tuning ]]; then
    echo "cloning practice-python repo..."
    git clone git@github.com:krishnam-eng/practice-java-performance-tuning.git ~/github/practice-java-performance-tuning
fi

#####
# Setup zsh & tmux configs
#####

# take a backup
mkdir -p ~/.mybkp
mv .zshrc ~/.mybkp/.zshrc_$(date +%y%m%d)

ln -s ~/github/ohmy-linux/zsh  ~/.myzsh
ln -s ~/github/ohmy-linux/tmux  ~/.mytmux
ln -s ~/github/ohmy-linux/nano  ~/.mynano
ln -s ~/github/ohmy-linux/alias  ~/.myalias

# this will change zdotdir value to start using ~/.myzsh as zdotdir
ln -s ~/.myzsh/.zshenv ~/.zshenv


