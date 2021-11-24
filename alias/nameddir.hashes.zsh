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
hash -d bkp=~/bkp
hash -d shared=~/shared

# quick access to core FHS dir @ L2
hash -d kws=~/hrt/myws
hash -d kproj=~/hrt/proj

hash -d style=~/hrt/style
hash -d bin=~/hrt/bin
hash -d etc=~/hrt/etc
hash -d lib=~/hrt/lib
hash -d tools=~/hrt/tools
hash -d var=~/hrt/var
hash -d plugins=~/hrt/plugins
hash -d resurrect=~/hrt/resurrect
hash -d virtualenvs=~/hrt/virtualenvs

# quick access to config files or custom setting @L3
hash -d alias=~/hrt/myws/alias
hash -d awk=~/hrt/myws/awk
hash -d bash=~/hrt/myws/bash
hash -d env=~/hrt/myws/env
hash -d font=~/hrt/myws/font
hash -d func=~/hrt/myws/func
hash -d git=~/hrt/myws/git
hash -d nano=~/hrt/myws/nano
hash -d nginx=~/hrt/myws/nginx
hash -d ssh=~/hrt/myws/ssh
hash -d tmux=~/hrt/myws/tmux
hash -d vbox=~/hrt/myws/vbox
hash -d venv=~/hrt/myws/venv
hash -d vscode=~/hrt/myws/vscode
hash -d zsh=~/hrt/myws/zsh

hash -d nginx=~/hrt/myws/nginx  # ~nginx

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d gh=~/hrt/proj/github

hash -d rphda=~gh/homelab-dkrapps
hash -d rpddd=~gh/domain-driven-design

hash -d rphlt=~gh/howdoi-loadtest
hash -d rpppn=~gh/practice-python
hash -d rppfk=~gh/practice-flask

