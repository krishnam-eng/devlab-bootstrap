##### python venv ########
# create virtual env with py3
alias venv="virtualenv --python python3"

# activate venv
srcvenv (){
  source ${1}/bin/activate
}

# snapshot venv requirements
ssvenv (){
  mkdir -p venv
  pip3 freeze >| venv/requirements.txt
  lolcat venv/requirements.txt
}

# recreate venv from snapshot
alias rcvenv="pip3 install -r venv/requirements.txt"

# make virtual env from requirement file if available
mkvenv (){
  if [ -f  "venv/requirements.txt" ]
  then
    echo "${LOG_TS} Creating virtual environement from venv/requirements.txt ..."
    mkvirtualenv $1 -r venv/requirements.txt
  else
    mkvirtualenv $1
    # -i install
    # -a associate an existing project
  fi
}
alias cpvenv="cpvirtualenv"    # copy
alias rmvenv="rmvirtualenv"    # remove
alias lsvenv="lsvirtualenv -b" #ls envs


# Activates the virtual environment or switches from the current environment to the specified one
alias avenv="workon" #switch or start workspace

# Deactivates the virtual environment.
alias dvenv="deactivate"

# run cmds in all venvs
alias cvenv="allvirtualenv"

# remove all installs form venv
alias wvenv="wipeenv"
