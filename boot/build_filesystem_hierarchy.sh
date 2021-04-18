#!/usr/bin/env bash


# checkout github repos
mkdir -p ~/github

if [[ ! -d ~/github/ohmy-linux ]]; then
    echo "cloning ohmy-linux repo"
    git clone https://github.com/krishnam-eng/ohmy-linux ~/github/ohmy-linux
fi

if [[ ! -d ~/github/practice-python ]]; then
    echo "cloning practice-python repo"
    git clone https://github.com/krishnam-eng/practice-python ~/github/practice-python
    git remote set-url origin git@github.com:krishnam-eng/practice-python.git
fi
