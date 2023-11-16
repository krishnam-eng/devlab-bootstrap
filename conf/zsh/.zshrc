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

# like macos launchd at shell session start
source $HOME/hrt/boot/conf/zsh/launchd/pre-shell-launch-cmds.zshrc

# customize zsh default behavior with units (like kernel units)
source $HOME/hrt/boot/conf/zsh/units/aliases-functions.zshrc
source $HOME/hrt/boot/conf/zsh/units/auto-completion.zshrc
source $HOME/hrt/boot/conf/zsh/units/expansions-globbing.zshrc
source $HOME/hrt/boot/conf/zsh/units/history.zshrc
source $HOME/hrt/boot/conf/zsh/units/zsh_line_editor.zshrc
source $HOME/hrt/boot/conf/zsh/units/prompt.zshrc

# Extend zsh behavior with fish shell capabilities
source $HOME/hrt/boot/conf/zsh/extensions/fish_shell.zsh

# optional powerlevel10k theme
[[ -f $HOME/hrt/etc/ctrflags/enablepowertheme ]] && source $HOME/hrt/boot/conf/zsh/extensions/.p10k.zsh && source $HOME/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme
