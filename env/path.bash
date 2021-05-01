#!/usr/bin/env bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$PATH:$HOME/.local/bin"
fi

# vim config path
#* neovim uses different dir for config and data
export VIMCONFIG=~/.myvim
export VIMDATA=~/.myvim
