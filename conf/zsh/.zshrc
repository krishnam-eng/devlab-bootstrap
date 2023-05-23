#!/usr/bin/env zsh
################
# description : This script (known as _startup file_) will be executed by zsh and all zsh preferences goes here
# zsh_version : 5.8 (zsh --version)
# author	    : krishnam
################

# initialize
[[ -f $HOME/hrt/etc/ctrflags/enablepowertheme ]] && source $HOME/hrt/boot/conf/zsh/extensions/p10k-instant-prompt.zsh

# Configure zsh core
source $HOME/hrt/boot/custom/env/interactice-shell/prompt.bash

source $HOME/hrt/boot/conf/zsh/elements/pre-launch-cmds.zshrc

source $HOME/hrt/boot/conf/zsh/elements/expansions-globbing.zshrc

source $HOME/hrt/boot/conf/zsh/elements/load-aliases-functions.zshrc

source $HOME/hrt/boot/conf/zsh/elements/history-configuration.zshrc

source $HOME/hrt/boot/conf/zsh/elements/auto-completion.zshrc

source $HOME/hrt/boot/conf/zsh/elements/set-opts-zle.zshrc

source $HOME/hrt/boot/conf/zsh/elements/prompt.zshrc

# Extensions
source $HOME/hrt/boot/conf/zsh/extensions/fish_shell.zsh
source $HOME/hrt/boot/conf/zsh/extensions/atuin.zshrc
source $HOME/hrt/boot/conf/zsh/extensions/direnv.zsh

[[ -f $HOME/hrt/etc/ctrflags/enablepowertheme ]] && source $HOME/hrt/boot/conf/zsh/extensions/.p10k.zsh && source $HOME/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme

source $HOME/.docker/init-zsh.sh || true # Added by Docker Desktop

# For Vim-style navigation in the Zsh terminal
bindkey -v
# For emacs-style navigation in the Zsh terminal
# bindkey -e for emacs