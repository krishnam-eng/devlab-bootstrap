# Contents within this block are created by 'conda init zsh' cmd
__conda_setup="$('/Users/balamurugan/hrt/tools/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/balamurugan/hrt/tools/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/balamurugan/hrt/tools/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/balamurugan/hrt/tools/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup