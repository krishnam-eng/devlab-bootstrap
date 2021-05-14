#!/usr/bin/env bash

########
# nginx
########

# Files & Dirs
#-------------

alias ngcdcrt="cd /etc/nginx"                # configuration-root
alias ngcdlog="cd /var/log/nginx"            # default log location
alias ngcdsa="cd /etc/nginx/sites-available" # server conf of available sites
alias ngcdse="cd /etc/nginx/sites-enabled"   # server conf of enabled sites
alias ngcdcd="cd /etc/nginx/conf.d"          # default http-site configs
alias ngcdrt="cd /var/www"                   # default root folder for web server

alias ngvelog="less /var/log/nginx/error.log"  # view error log
alias ngvalog="less /var/log/nginx/access.log" # view access log

alias ngmelog="tail -f /var/log/nginx/error.log"  # monitor error log
alias ngmalog="tail -f /var/log/nginx/access.log" # monitor access log

alias ngvse="la /etc/nginx/sites-enabled"      # view sites enabled
alias ngvsa="la /etc/nginx/sites-available"    # view sites available
alias ngvcd="la /etc/nginx/conf.d"             # view default http-site configs
alias ngvcf="cat /etc/nginx/nginx.conf"        # view conf entry point

alias ngecf="sudo $EDITOR /etc/nginx/nginx.conf"     # edit conf

# nginx service commands
#-----------------------

# let_s make start and stop cmd to be more verbose
ngst(){
  sudo systemctl start nginx
  sudo systemctl status nginx --no-pager
}

ngsp(){
  sudo systemctl stop nginx"; # or nginx -s stop
