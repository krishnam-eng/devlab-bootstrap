############
# virtualenv
############

# create virtual env with py3
alias venv="virtualenv --python python3 " # --with-traceback true 

# activate venv
#   to ensure that commands from within the python virtual environment take priority over your system paths
#   this is not needed while using wrapper
srcvenv (){
  source ${1}/bin/activate
}

# save venv requirements & venv name
svenv (){
  mkdir -p venv
  echo "${LOG_TS} Writing package requirements to ${CS_bcyan}venv/requirements.txt${CS_reset}"
  pip freeze >| venv/requirements.txt
  lolcat venv/requirements.txt
  echo "${LOG_TS} Writing venv name to ${CS_bcyan}venv/name.venv${CS_reset}"
  echo $(basename $VIRTUAL_ENV) >| venv/name.venv
  lolcat venv/name.venv
}

# recreate venv from snapshot
alias rvenv="pip install -r venv/requirements.txt"

##############
# Venv Wrapper
##############

# make virtual env from requirement file if available
#   don’t create VCS ignore directive in the destination directory
#   activate the venv
#   create venv metadata if not exist
mkvenv (){
  if [ -f  "venv/requirements.txt" ]
  then
    echo "${LOG_TS} Creating venv from venv/requirements.txt ..."
    if [ -f "venv/name.venv" ]
    then
      echo "${LOG_TS} Fetching venv name from ${CS_bcyan}venv/name.venv ${CS_reset}..."
      vname=$(cat venv/name.venv)
      mkvirtualenv $vname -r venv/requirements.txt # --no-vcs-ignore
    else
      echo "${LOG_TS} ${CS_red} Found no venv name metadata ! ${CS_reset}"
      echo "${LOG_TS} Creating temp venv..."
      ctdir=$(pwd)
      mktmpenv -r venv/requirements.txt # --no-vcs-ignore
      $(cd $ctdir)
    fi
  # no venv metadata: maybe first time venv for this project, or no proj specific venv
  else
    if [ $# -eq 0 ]
    then
      ctdir_rpath=$(basename `pwd`)
      vname=$(genvname $ctdir_rpath)
      echo "${LOG_TS} Generated venv name ${CS_bcyan}${vname}${CS_reset} from ${CS_bcyan}${ctdir_rpath}${CS_reset}..."
    else
      vname=$1
    fi
    echo "${LOG_TS} Creating venv for ${CS_bcyan}${vname} ${CS_reset}..."
    echo "${LOG_TS} Activating venv ${CS_bcyan}${vname} ${CS_reset}..."
    mkvirtualenv $vname # --no-vcs-ignore
    workon $vname && svenv
  fi
}

alias cpvenv="cpvirtualenv"    # copy
alias rmvenv="rmvirtualenv"    # remove
alias lsvenv="lsvirtualenv -b" # ls venvs
alias shvenv="showvirtualenv"  # show current env details
alias rcvenv="allvirtualenv"   # run-cmds in all venvs

# todo: activate to auto pick venv name from name.venv file
alias avenv="workon"     # Activates the virtual environment or switch to venv
alias dvenv="deactivate" # Deactivates the virtual environment.

alias wvenv="wipeenv"    # remove all installs form venv
alias a2venv="add2virtualenv" # set dir to path contains site-packages which should not be installed in each venv
