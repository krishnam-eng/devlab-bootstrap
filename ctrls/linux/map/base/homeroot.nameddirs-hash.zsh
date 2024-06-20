##################
# Named Directory
#
#   ~shortcutname: Creating Named Dir by adding  entry in "fil/dir names hash table."
#
#   Named dir can be called like ~shortcutname  similar to how ~ refers to home dir
#
###################

hash -d dev=$HOME/Paradigm/Development

hash -d droot=$HOME/Paradigm/Development/Root

hash -d zsh=$HOME/Paradigm/Development/Root/conf/zsh

hash -d alias=$HOME/Paradigm/Development/Root/custom/alias
hash -d env=$HOME/Paradigm/Development/Root/custom/env
hash -d func=$HOME/Paradigm/Development/Root/custom/func

hash -d ssh=$HOME/Paradigm/Development/Root/settings/ssh
hash -d vim=$HOME/Paradigm/Development/Root/settings/vim
hash -d nano=$HOME/Paradigm/Development/Root/settings/nano

# Projects
hash -d proj=$HOME/Paradigm/Projects

hash -d lab=$HOME/Paradigm/Projects/Experimental
hash -d edu=$HOME/Paradigm/Projects/Academic
hash -d pri=$HOME/Paradigm/Projects/Personal
hash -d pro=$HOME/Paradigm/Projects/Product

hash -d xdg=$HOME/Paradigm/Development/XDG

hash -d log=~/log
hash -d tmp=~/tmp
hash -d bkp=~/hrt/ver
hash -d shared=~/shared

# log dirs
hash -d lg-ct=~/hrt/var/log/crontab/

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d gh=~/hrt/proj/github
hash -d rp-ujl=~gh/useful-java-libraries
hash -d rp-cni=~gh/explore-cloud-native-infra
hash -d rp-ddd=~gh/domain-driven-design

# user home dirs
hash -d gd=~/Drives/  
hash -d dl=$HOME/Downloads

# workspace
hash -d vm=~/exp/cnl-observability-and-analysis/victoriametrics