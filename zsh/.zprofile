#!/usr/bin/env zsh

# Runs only for login-interactive login-non-interactive shells. This won't get executed for scripts shell

[ -z "$TMUX" ] && export TERM=xterm-256color

if [ -d ~/.myenv ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in ~/.myenv/profile/*sh
  do
    source $efile
  done
  unset efile
fi

