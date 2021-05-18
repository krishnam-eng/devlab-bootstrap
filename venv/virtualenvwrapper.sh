#!/usr/bin/env bash

#* this file should be sourced as a part of Shell Startup File

# virtualenvwrapper extensions include wrappers for creating and deleting virtual environments
#   managing your development workflow, making it easier to work on more than one project at a time without introducing conflicts in their dependencies
# https://virtualenv.pypa.io/en/latest/index.html

# Features (Why Do I Use)
#   Organizes all of your virtual environments in one place.
#   Wrappers for managing your virtual environments (create, delete, copy).
#   Use a single command to switch between environments.(workon)
#   Tab completion for commands that take a virtual environment as argument.(workon alias svenv)
#   User-configurable hooks for all operations (just edit the files with prefix pre/post)

# mkvirtualenv my_venv
#   Creates the virtual environment in the folder ~/.virtualenvs/my_venv. Or on
# workon my_venv
#   Activates the virtual environment or switches from the current environment to the specified one
# deactivate
#   Deactivates the virtual environment.

#### Installing
# pip install virtualenvwrapper
# or
# pip install --user virtualenvwrapper
# or
# The below is the hack if the above two is not working due to permission issue
# vritualenv kdev
# export VIRTUALENVWRAPPER_PYTHON=~/kdev/bin/python3
# source kdev/bin/activate
# source kdev/bin/virtualenvwrapper.sh
# --now, all the wrapper commands will work in kdev venv :) 
# include this ~/kdev/bin to the PATH and install any tool you need using this hack

# wrapper loads bin based on path, to be certain which gets picked, let's define it here
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv

# to ensure that all new environments are isolated from the system site-packages directory
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# location where the virtual environments should live
export WORKON_HOME=~/.virtualenvs

# location where the user-defined hooks should be placed
export VIRTUALENVWRAPPER_HOOK_DIR=~/.myvenv # hooks are in VCS
export VIRTUALENVWRAPPER_LOG_FILE=~/log/venvwrapper.log
export VIRTUALENVWRAPPER_TMPDIR=~/tmp
export PROJECT_HOME=~/github

mkdir -p ~/log
mkdir -p ~/tmp

# lazy loading
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

if [ -e /usr/local/bin/virtualenvwrapper_lazy.sh ]
then
  source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# by default, venv  prefix the prompt with venv name, let's disable it since we are already personalized prompt zsh using venv variable.
export VIRTUAL_ENV_DISABLE_PROMPT=1
