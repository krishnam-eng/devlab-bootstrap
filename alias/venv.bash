############
# virtualenv
############

# create virtual env with py3
alias venv="virtualenv --python python3 --with-traceback true"

# activate venv
#   to ensure that commands from within the python virtual environment take priority over your system paths
#   this is not needed while using wrapper
srcvenv (){
  source ${1}/bin/activate
}

# save venv requirements & venv name
svenv (){
  mkdir -p venv
  echo "${LOG_TS}Writing package requirements to ${CS_bcyan}venv/requirements.txt${CS_reset}"
  pip freeze >| venv/requirements.txt
  lolcat venv/requirements.txt
  echo "${LOG_TS}Writing venv name to ${CS_bcyan}venv/name.venv${CS_reset}"
  echo $(basename $VIRTUAL_ENV) >| venv/name.venv
}

# recreate venv from snapshot
alias rvenv="pip install -r venv/requirements.txt"

##############
# Venv Wrapper
##############

# make virtual env from requirement file if available
#   don’t create VCS ignore directive in the destination directory
mkvenv (){
  if [ -f  "venv/requirements.txt" ]
  then
    echo "${LOG_TS} Creating virtual environement from venv/requirements.txt ..."
    mkvirtualenv $1 -r venv/requirements.txt --no-vcs-ignore
  else
    mkvirtualenv $1 --no-vcs-ignore
    # -i install
    # -a associate an existing project
  fi

  # todo: add logic to create temp venv if no name provided or the name is tmp using `mktmpenv`
}
alias cpvenv="cpvirtualenv"    # copy
alias rmvenv="rmvirtualenv"    # remove
alias lsvenv="lsvirtualenv -b" # ls venvs
alias rcvenv="allvirtualenv"   # run-cmds in all venvs

alias avenv="workon"     # Activates the virtual environment or switch to venv
alias dvenv="deactivate" # Deactivates the virtual environment.

alias wvenv="wipeenv"    # remove all installs form venv
alias a2venv="add2virtualenv" # set dir to path contains site-packages which should not be installed in each venv
