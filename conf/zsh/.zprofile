#!/usr/bin/env zsh

# Runs only for login-interactive shells. This won't get executed for scripts shell or non-login shells

eval "$(/opt/homebrew/bin/brew shellenv)"

# Configure pyenv
export PYENV_ROOT="$HOME/sbrn/sys/local/share/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

