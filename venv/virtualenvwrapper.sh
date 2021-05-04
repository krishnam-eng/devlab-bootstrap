#!/usr/bin/env bash

#* this file should be sourced as a part of Shell Startup File

# virtualenvwrapper extensions include wrappers for creating and deleting virtual environments
#   managing your development workflow, making it easier to work on more than one project at a time without introducing conflicts in their dependencies

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

# wrapper loads based on path, to be certain, let's define it
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv

# to ensure that all new environments are isolated from the system site-packages directory
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# location where the virtual environments should live
export WORKON_HOME=~/.virtualenvs

# location where the user-defined hooks should be placed
export VIRTUALENVWRAPPER_HOOK_DIR=~/.myvenv
export VIRTUALENVWRAPPER_LOG_FILE=${WORKON_HOME}/log/hook.log

# location of your development project directories
export PROJECT_HOME=~/github

mkdir -p $WORKON_HOME/log

# lazy loading
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

if [ -e /usr/local/bin/virtualenvwrapper_lazy.sh ]
then
  source /usr/local/bin/virtualenvwrapper_lazy.sh
fi
