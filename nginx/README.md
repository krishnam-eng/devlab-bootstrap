# NGINX Notes

## nginx cli, files & dirs

check `../alias/webserver.bash` for more details

## Configuring Server (vhost)

```
http {
    server {
        # Server configuration
    }

    # or, include path to server / vhost config 

    include site-enabled/
}
```



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




