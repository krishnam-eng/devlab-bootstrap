# virtualenvwrapper extensions include wrappers for creating and deleting virtual environments
#   managing your development workflow, making it easier to work on more than one project at a time without introducing conflicts in their dependencies

# mkvirtualenv my_venv
#   Creates the virtual environment in the folder ~/.virtualenvs/my_venv. Or on
# workon my_venv
#   Activates the virtual environment or switches from the current environment to the specified one
# deactivate
#   Deactivates the virtual environment.


export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

export WORKON_HOME=~/.myvenv
mkdir -p $WORKON_HOME

if [ -e /usr/local/bin/virtualenvwrapper.sh ]
then
  source /usr/local/bin/virtualenvwrapper.sh
fi
