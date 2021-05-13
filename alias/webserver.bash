#!/usr/bin/env bash

# default root folder for web server
alias cdwsroot="cd /var/www"

########
# nginx - prefix 'ng'
########
alias ngst="sudo systemctl status nginx"

# view error log
alias ngvelog="less /var/log/nginx/error.log"

# view access log
alias ngvalog="less /var/log/nginx/access.log"

alias ngcdetc="cd /etc/nginx"
alias ngcdlog="cd /var/log/nginx"

# back up to version control
ngbk2vcs(){
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
