#!/usr/bin/env bash

########
# nginx - prefix 'ng'
########

# nginx cli
alias ngst="sudo systemctl start nginx"
alias ngsp="sudo systemctl stop nginx"
alias ngrl="sudo systemctl reload nginx"
alias ngia="sudo systemctl is-active nginx" # start & stop comd do not produce any stdout so use this to get the status 
alias ngss="sudo systemctl status nginx --no-pager" # systemctl uses pager by default, so you need to use q to end status; instead use no-pager switch to get around this
alias ngtt="sudo nginx -t" # test config and show status
alias ngvconf="sudo nginx -T | less" # test and dump the config
alias nghp="sudo nginx -h" # help



# Files & Dirs
alias ngvelog="less /var/log/nginx/error.log"  # view error log
alias ngvalog="less /var/log/nginx/access.log" # view access log
alias ngvse="la /etc/nginx/sites-enabled"      # sites enabled

alias ngcdetc="cd /etc/nginx"                # p\yetsee enginex\
alias ngcdlog="cd /var/log/nginx"            # web service log
alias ngcdsa="cd /etc/nginx/sites-available" # server conf of sites
alias ngcdroot="cd /var/www"                 # default root folder for web server

# Back Up: to version control
ngbkconf(){
  \cp /etc/nginx/nginx.conf ~/github/ohmy-linux/nginx/nginx.conf
}

#########
# apache2
#########
# status
alias ast="sudo systemctl status apache2" # ubuntu
#alias ast="sudo systemctl status httpd" # centos

# config
alias aconf="nano /etc/apache2/apache2.conf" # ubuntu
# alias aconf="nano /etc/httpd/conf/httpd.conf" # centos

##
# todos:
#   [] create nameddir for these cd paths
##
