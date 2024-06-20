# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/Paradigm/Development/Tools/Anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/Paradigm/Development/Tools/Anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/Paradigm/Development/Tools/Anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/Paradigm/Development/Tools/Anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<