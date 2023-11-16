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
hash -d exp=~/exp
hash -d log=~/log
hash -d tmp=~/tmp
hash -d bkp=~/hrt/ver
hash -d shared=~/shared

# quick access to core FHS dir @ L2
hash -d bin=~/hrt/bin
hash -d etc=~/hrt/etc
hash -d ext=~/hrt/ext
hash -d lib=~/hrt/lib
hash -d style=~/hrt/opt
hash -d hproj=~/hrt/proj
hash -d pvt=~/hrt/pvt
hash -d tmp=~/hrt/tmp
hash -d state=~/hrt/state
hash -d var=~/hrt/var
hash -d vault=~/hrt/vault
hash -d tools=~/hrt/vault
hash -d ver=~/hrt/ver
hash -d vol=~/hrt/vol

# quick access to config files or custom setting @L3
hash -d hrepo=~/hrt/repo/helm-repo

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