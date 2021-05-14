# NGINX Notes

## nginx cli, files & dirs

```
# Files & Dirs
alias ngcdcrt="cd /etc/nginx"                # configuration-root
alias ngcdlog="cd /var/log/nginx"            # default log location
alias ngcdsa="cd /etc/nginx/sites-available" # server conf of available sites
alias ngcdse="cd /etc/nginx/sites-enabled"   # server conf of enabled sites
alias ngcdhs="cd /etc/nginx/conf.d"          # default http-site configs
alias ngcdrt="cd /var/www"                   # default root folder for web server

alias ngvelog="less /var/log/nginx/error.log"  # view error log
alias ngvalog="less /var/log/nginx/access.log" # view access log

alias ngmelog="tail -f /var/log/nginx/error.log"  # monitor error log
alias ngmalog="tail -f /var/log/nginx/access.log" # monitor access log


alias ngvse="la /etc/nginx/sites-enabled"      # view sites enabled
alias ngvsa="la /etc/nginx/sites-available"    # view sites available
alias ngvhs="la /etc/nginx/conf.d"             # view default http-site configs
alias ngvcf="cat /etc/nginx/nginx.conf"        # view conf entry point

alias ngecf="sudo $EDITOR /etc/nginx/nginx.conf"     # edit conf

```

```
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
```
check `../alias/webserver.bash` for more details


## Structure
```
http {
    # Server content 
    server {
        listen ...;
        server_name
        
        location / {
            root ...;
            index ....;
        }
    }
    # or, include path to server / vhost config 
    include site-enabled/
}
```

## Configuring Server (vhost)
### Difference Between site-* & conf.d dirs

It boils down to two school of thoughts on how to mamange vhost configs
- conf.d: to store all your vhost config
- site-*: this abstraction makes things a little more organized and allows you to easily manage the all vs active vhost configs
  - The sites-available folder is for storing all of your vhost configurations, whether or not they're currently enabled.
  - The sites-enabled folder contains symlinks to files in the sites-available folder. This allows you to selectively disable vhosts by removing the symlink.

### Good Conventions
- Set the file name after the site so keep things organized `e.g. mysite.local.conf`
  - why
  -   single nginx can run multiple sites
  -   `.conf` helps nginx auto-identify the vhost config
- Set root path basedir as same as vhost config file name without file extention 
```bash
*.conf: server{... root ~/github/ohmy-linux/nginx/var-www/perftestsite.local}
mkdir ~nginx/var-www/perftestsite.local
echo '<h1>Under Construction</h1>' > ~nginx/var-www/perftestsite.local/index.html
```
- VC the config under nginx/site-available and symlink to enabled 

```bash
rm /etc/nginx/sites-enabled/default
sudo ln -s ~nginx/sites-available/perftestsite.lht.conf /etc/nginx/sites-enabled/default
```
### Common Issues I faced

`nginx: [warn] conflicting server name "" on 0.0.0.0:90, ignored`

- Accidently defined the server_name directive in two places
  - check site-enabled `>ngcdsa`

`403 Forbidden Error`
- Wrong root dir or File permission Issue
  - chmod 755 rootdir
  - chmod 644 files
  - change owner to nginx user 
```bash
>ngusr 
www-data
>sudo chown -R www-data:www-data  ~nginx/var-www/perftestsite.lht
sudo chmod 755 ~nginx/var-www/perftestsite.lht
cd ~nginx/var-www/perftestsite.lht
sudo chmod 644 *

test from cli
>curl localhost
<h1> under construction </h1>
```

```
find ~nginx/var-www/perftestsite.lht/ -type f -exec chmod 644 {} \;
find ~nginx/var-www/perftestsite.lht/ -type d -exec chmod 755 {} \;

```

### Troubleshoot NGINX

- nginx test config `` 
- nginx status ``
- nginx reload ``
- verify ports `lsof -P -n -i :80 -i :433 | grep LISTEN`
- follow the log `tail -f *.log`
- search engines
- stackoverflow

### Security with NGINX

- keep os patched & updated `update`

- limit access

```bash
location /sensitivedatadir  {
  allow 127.0.0.1;
  deny all;
  # get 403 forbidden
}
```

- setup username & password 

```bash
sudo htpasswd -c /etc/nginx/passwords admin
less /etc/nginx/passwords
sudo htpasswd  /etc/nginx/passwords guest
sudo chown www-data /etc/nginx/passwords
sudo chmod 600 /etc/nginx/passwords
ls -la /etc/nginx/passwords

location ...{
  auth_base ...
  auth_base_user_password ...
}


```

- Use SSL (secure sockets layer) to protect transmissions
  - HTTPS started using TLS (transport layer security) for encrypting web traffic
  - the term SSL still used in to describe certificates (can be public) and keys (for encrpt - keep it private)

```
# create certificate and key
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt

add ssl directives and set permanent redirect for http port. check perftextsite config

```

## Reverse Proxy 

- Client request comes to reverse-proxy and it communicate with **one** server (load balancer connects to multiple servers)
  - caching can be done

`upstream` directive comes in http context 

```
(global context)
http{
  upstream {

  }

}
```

## Load balancer 
- client request comes to load-balancer and it communicate with multiple servers
  - session persistence can be done
- Methods: Round Robin (--), Least Connections (least_ conn), IP Hash (ip_hash) - based on client ip addr, (weight) can use more weight for high resource server
