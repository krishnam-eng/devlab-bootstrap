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
hash -d kws=~/hrt/hldr
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
hash -d alias=~/hrt/hldr/alias
hash -d awk=~/hrt/hldr/awk
hash -d bash=~/hrt/hldr/bash
hash -d env=~/hrt/hldr/env
hash -d font=~/hrt/hldr/font
hash -d func=~/hrt/hldr/func
hash -d git=~/hrt/hldr/git
hash -d nano=~/hrt/hldr/nano
hash -d nginx=~/hrt/hldr/nginx
hash -d ssh=~/hrt/hldr/ssh
hash -d tmux=~/hrt/hldr/tmux
hash -d vbox=~/hrt/hldr/vbox
hash -d venv=~/hrt/hldr/venv
hash -d vscode=~/hrt/hldr/vscode
hash -d zsh=~/hrt/hldr/zsh

hash -d nginx=~/hrt/hldr/nginx  # ~nginx

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d gh=~/hrt/proj/github

hash -d rphda=~gh/homelab-dkrapps
hash -d rpddd=~gh/domain-driven-design

hash -d rphlt=~gh/howdoi-loadtest
hash -d rpppn=~gh/practice-python
hash -d rppfk=~gh/practice-flask

