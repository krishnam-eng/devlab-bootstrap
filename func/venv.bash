# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a venv/name.venv file in the project root with a virtualenv name in it
# todo: fix the error
wipcd (){
    builtin cd "$@"
    echo "${CS_yellow}$OLDPWD${CS_reset} --> ${CS_bcyan}$PWD${CS_reset}"

    # Check that this is a Git repo
    gitdir_rpath=$(git rev-parse --git-dir 2> /dev/null)
    if [ $? -eq 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=$(\cd $gitdir_rpath; pwd)
        GIT_PROJ_ROOT=`dirname "$GIT_DIR"`
        VENV_NAME=`basename "$GIT_PROJ_ROOT"`
        if [ -f "$GIT_PROJ_ROOT/venv/name.venv" ]; then
            VENV_NAME=$(cat "$GIT_PROJ_ROOT/venv/name.venv")
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$VENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$VENV_NAME/bin/activate" ]; then
                workon "$VENV_NAME" && export CD_VIRTUAL_ENV="$VENV_NAME"
            fi
        fi
    elif [ -v $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

