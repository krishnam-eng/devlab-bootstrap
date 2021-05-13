#!/usr/bin/env bash

########
# nginx
########

# nginx service
alias ngst="sudo systemctl start nginx"
alias ngsp="sudo systemctl stop nginx"
alias ngrl="sudo systemctl reload nginx"
alias ngia="sudo systemctl is-active nginx" # start & stop comd do not produce any stdout so use this to get the status 
alias ngss="sudo systemctl status nginx --no-pager" # systemctl uses pager by default, so you need to use q to end status; instead use no-pager switch to get around this

alias ngtcf="sudo nginx -t" # test config and show status
alias ngtd="sudo nginx -T | less" # test and dump the config
alias nghp="sudo nginx -h" # help

alias ngps="ps -ef | grep nginx"
alias ngusr="ps -ef | awk '/nginx.*worker.*process$/{print \$1}'"
alias ngport="netstat -plan | grep nginx"

# Files & Dirs
alias ngvelog="less /var/log/nginx/error.log"  # view error log
alias ngvalog="less /var/log/nginx/access.log" # view access log

alias ngmelog="tail -f /var/log/nginx/error.log"  # monitor error log
alias ngmalog="tail -f /var/log/nginx/access.log" # monitor access log


alias ngvse="la /etc/nginx/sites-enabled"      # view sites enabled
alias ngvcf="cat /etc/nginx/nginx.conf"      # view conf

alias ngecf="sudo $EDITOR /etc/nginx/nginx.conf"     # edit conf

alias ngcdetc="cd /etc/nginx"                # p\yetsee enginex\
alias ngcdlog="cd /var/log/nginx"            # web service log
alias ngcdsa="cd /etc/nginx/sites-available" # server conf of sites
alias ngcdse="cd /etc/nginx/sites-enabled"   # server conf of enabled sites
alias ngcdrt="cd /var/www"                   # default root folder for web server

# Back Up: to version control
ngbkpcf(){
  \cp /etc/nginx/nginx.conf ~/github/ohmy-linux/nginx/nginx.conf
}

# list open files - ls port listen
alias lspln="sudo lsof -i | grep LISTEN"
alias ngv


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

###################################################################
#   alias pattern:
#         who{1,2} 'ng'
#       + what{1,3} 'e -edit, v -view, cd, sp - stop'
#       + where{2,3} 'log, cf - config'
#
#       abbrev:
#         =^(.) + (.)$ if the word is ((last || middle) && length >4)
#        +=^(.) for word in compound-word
###################################################################
