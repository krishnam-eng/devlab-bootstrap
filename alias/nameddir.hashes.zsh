##################
# Named Dirctory
#
#   Creating Named Dir by adding ~shortcutname entry in "fil/dir names hash table."
#
#   Named dir can be called like ~shortcutname  similar to how ~ refers to home dir
#
###################

# alternate access to dir @ L1  e.g, ~/hrt -> ~hrt
hash -d hrt=~/hrt
hash -d proj=~/proj
hash -d log=~/log
hash -d tmp=~/tmp
hash -d bkp=~/hrt/ver
hash -d shared=~/shared

# quick access to core FHS dir @ L2
hash -d boot=~/hrt/boot
hash -d bin=~/hrt/bin
hash -d lib=~/hrt/lib
hash -d var=~/hrt/var
hash -d etc=~/hrt/etc
hash -d src=~/hrt/src

hash -d style=~/hrt/opt
hash -d tools=~/hrt/tools

hash -d plugins=~/hrt/plugins
hash -d resurrect=~/hrt/resurrect
hash -d virtualenvs=~/hrt/virtualenvs

# quick access to config files or custom setting @L3
hash -d alias=~/hrt/boot/alias
hash -d awk=~/hrt/boot/awk
hash -d bash=~/hrt/boot/bash
hash -d env=~/hrt/boot/env
hash -d font=~/hrt/boot/font
hash -d func=~/hrt/boot/func
hash -d git=~/hrt/boot/git
hash -d nano=~/hrt/boot/nano
hash -d nginx=~/hrt/boot/nginx
hash -d ssh=~/hrt/boot/ssh
hash -d tmux=~/hrt/boot/tmux
hash -d vbox=~/hrt/boot/vbox
hash -d venv=~/hrt/boot/venv
hash -d vscode=~/hrt/boot/vscode
hash -d zsh=~/hrt/boot/zsh

hash -d nginx=~/hrt/boot/nginx  # ~nginx

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d gh=~/hrt/proj/github

hash -d rphda=~gh/homelab-dkrapps
hash -d rpddd=~gh/domain-driven-design

hash -d rphlt=~gh/howdoi-loadtest
hash -d rpppn=~gh/practice-python
hash -d rppfk=~gh/practice-flask

