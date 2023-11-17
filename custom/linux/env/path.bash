#!/usr/bin/env bash

if [ -d "$HOME/bin" ] ; 
then
  PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.rd/bin" ] ; 
then
  PATH="$PATH:$HOME/.rd/bin"
fi

if [ -d "$HOME/.local/bin" ] ; 
then
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
if [ -d "$HOME/hrt/bin" ]
then
  PATH="$PATH:$HOME/hrt/bin"
fi

# vim config path
#* neovim uses different dir for config and data
export VIMCONFIG=~/.myvim
export VIMDATA=~/.myvim

# pipx
export PIPX_BIN_DIR=$HOME/hrt/local/bin
export PIPX_HOME=$HOME/hrt/local/pipx
