#!/usr/bin/env bash

########
# nginx
########

# list all ng alias
alias ngalias="alias | awk '/^ng/{print}' | lolcat"

# Files & Dirs
#-------------

alias ngcdcr="cd /etc/nginx"                 # configuration-root
alias ngcdlog="cd /var/log/nginx"            # default log location
alias ngcdsa="cd /etc/nginx/sites-available" # server conf of available sites
alias ngcdse="cd /etc/nginx/sites-enabled"   # server conf of enabled sites
alias ngcdcd="cd /etc/nginx/conf.d"          # default http-site config-dropins dir
alias ngcdrt="cd /var/www"                   # default root folder for web server

alias ngvel="less /var/log/nginx/error.log"    # view error-log
alias ngval="less /var/log/nginx/access.log"   # view access-log
alias ngvse="la /etc/nginx/sites-enabled"      # view sites enabled
alias ngvsa="la /etc/nginx/sites-available"    # view sites available
alias ngvcd="la /etc/nginx/conf.d"             # view default http-site configs
alias ngvcf="cat /etc/nginx/nginx.conf"        # view conf entry point

alias ngmel="tail -f /var/log/nginx/error.log"   # monitor error-log using tail flow
alias ngmal="tail -f /var/log/nginx/access.log"  # monitor access-log using tail flow

alias ngecf="sudo $EDITOR /etc/nginx/nginx.conf" # edit conf

# nginx service commands
#-----------------------

# let's make start and stop cmd to be more verbose
ngst(){
  sudo systemctl start nginx;
  sudo systemctl status nginx --no-pager -l;
}

ngsp(){
  sudo systemctl stop nginx; # or nginx -s stop
  sudo systemctl status nginx --no-pager -l;
}

# reload after testing config - makes it easy to stop issues
ngrl(){
  sudo nginx -t;
  sudo systemctl reload nginx;
  sudo systemctl status nginx --no-pager -l;
}

# stop after it finishes processing inflight requests
alias ngqt="sudo nginx -s quit"

# start & stop cmd do not produce any stdout so use this to get the status
alias ngia="sudo systemctl is-active nginx"

# test config and show status
alias ngtcf="sudo nginx -t"

# test-dump config
alias ngtdcf="sudo nginx -T | less"

# help
alias nghp="sudo nginx -h"

# systemctl uses pager by default, so you need to use q to end status; instead use no-pager switch to get around this
alias ngss="sudo systemctl status nginx --no-pager -l"

# show process, usr, port
alias ngsps="ps -ef | grep nginx"
alias ngsusr="ps -ef | awk '/nginx.*worker.*process$/{print \$1}'"
alias ngspt="netstat -plan | grep nginx"

# Back Up: to version control
ngbkpcf(){
  \cp /etc/nginx/nginx.conf ~/github/ohmy-linux/nginx/nginx.conf
}

# list listen prots using of:open-files
alias lslp="sudo lsof -i | grep LISTEN"
