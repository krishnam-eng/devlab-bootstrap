# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a venv/name.venv file in the project root with a virtualenv name in it

gitvenv (){
    # Check that this is a Git repo
    gitdir_rpath=$(git rev-parse --git-dir 2> /dev/null)
    if [ $? -eq 0 ]; then

        # Find the repo root and check for virtualenv name override
        export GIT_DIR=$(\cd $gitdir_rpath; pwd)
        export GIT_PROJ_ROOT=`dirname "$GIT_DIR"`

        VENV_NAME=`basename "$GIT_PROJ_ROOT"`
        echo "${LOG_TS} Identified Git Project: ${CS_bcyan}$VENV_NAME${CS_reset}"
        if [ -f "$GIT_PROJ_ROOT/venv/name.venv" ]; then
            VENV_NAME=$(cat "$GIT_PROJ_ROOT/venv/name.venv")
        fi
        echo "${LOG_TS} Identified Virtual Environment: ${CS_bcyan}$VENV_NAME${CS_reset}"
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$VENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$VENV_NAME/bin/activate" ]; then
                echo "${LOG_TS} Activating virtualenv ${VENV_NAME} ..."
                workon "$VENV_NAME" && export CD_VIRTUAL_ENV="$VENV_NAME"
            fi
        fi
    elif [ -v $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# generate venv name from github proj name
function genvname (){
  # how: take first char of each words which are seperated by "-"
  echo "$1" | awk 'BEGIN{FS="-";OFS="\n"}{print $1, $2;}' | awk 'BEGIN{FIELDWIDTHS="1 1 1 1 1 1 1 1 1 1 1 1 1 1 "; ORS=""}{print $1 $NF}' | awk 'BEGIN{FIELDWIDTHS="1 1 2"}{print $1 $3}'
}
