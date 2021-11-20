##################
# Named Dirctory
#
#   Creating Named Dir by adding ~shortcutname entry in "fil/dir names hash table."
#
#   Named dir can be called like ~shortcutname  similar to how ~ refers to home dir
#
###################

# alternate access to dir @ L1  e.g, ~/kroot -> ~kroot
hash -d kroot=~/kroot
hash -d proj=~/proj
hash -d log=~/log
hash -d tmp=~/tmp
hash -d bkp=~/bkp
hash -d shared=~/shared

# quick access to core FHS dir @ L2
hash -d kws=~/kroot/myws
hash -d kproj=~/kroot/proj

hash -d style=~/kroot/style
hash -d bin=~/kroot/bin
hash -d etc=~/kroot/etc
hash -d lib=~/kroot/lib
hash -d tools=~/kroot/tools
hash -d var=~/kroot/var
hash -d plugins=~/kroot/plugins
hash -d resurrect=~/kroot/resurrect
hash -d virtualenvs=~/kroot/virtualenvs

# quick access to config files or custom setting @L3
hash -d alias=~/kroot/myws/alias
hash -d awk=~/kroot/myws/awk
hash -d bash=~/kroot/myws/bash
hash -d env=~/kroot/myws/env
hash -d font=~/kroot/myws/font
hash -d func=~/kroot/myws/func
hash -d git=~/kroot/myws/git
hash -d nano=~/kroot/myws/nano
hash -d nginx=~/kroot/myws/nginx
hash -d ssh=~/kroot/myws/ssh
hash -d tmux=~/kroot/myws/tmux
hash -d vbox=~/kroot/myws/vbox
hash -d venv=~/kroot/myws/venv
hash -d vscode=~/kroot/myws/vscode
hash -d zsh=~/kroot/myws/zsh

hash -d nginx=~/kroot/myws/nginx  # ~nginx

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d gh=~/kroot/proj/github

hash -d rphda=~gh/homelab-dkrapps
hash -d rpddd=~gh/domain-driven-design

hash -d rphlt=~gh/howdoi-loadtest
hash -d rpppn=~gh/practice-python
hash -d rppfk=~gh/practice-flask

