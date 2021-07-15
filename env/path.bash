#!/usr/bin/env bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$PATH:$HOME/.local/bin"
fi

# executable awk programs
if [ -d "$HOME/.myawk" ]
then
  PATH="$PATH:$HOME/.myawk"
fi

# executable tmux session
if [ -d "$HOME/.mytmux/sessions" ]
then
  PATH="$PATH:$HOME/.mytmux/sessions"
fi

# krishnam-root venv path
if [ -d "$HOME/kroot/bin" ]
then
  PATH="$PATH:$HOME/kroot/bin"
fi
# build tools
if [ -d "$HOME/kroot/build/gradle-7.1.1" ]
then
  export GRADLE_HOME=~/kroot/build/gradle-7.1.1
  PATH=${GRADLE_HOME}/bin:${PATH}
fi
    
    
# IDE Path
if [ -d "$HOME/kroot/vscode/bin" ]
then
  PATH="$PATH:$HOME/kroot/vscode/bin"
fi

if [ -d "$HOME/kroot/ide/idea-2021/bin" ]
then
  PATH="$PATH:$HOME/kroot/ide/idea-2021/bin"
fi


if [ -d "$HOME/kroot/node/bin" ]
then
  PATH="$PATH:$HOME/kroot/node/bin"
fi

# vim config path
#* neovim uses different dir for config and data
export VIMCONFIG=~/.myvim
export VIMDATA=~/.myvim

# pipx
export PIPX_BIN_DIR=$HOME/kroot/local/bin
export PIPX_HOME=$HOME/kroot/local/pipx
