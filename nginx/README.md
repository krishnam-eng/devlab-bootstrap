# NGINX Notes

## nginx cli, files & dirs

check `../alias/webserver.bash` for more details

## Configuring vhost
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
sudo ln -s ~nginx/sites-available/perftestsite.local.conf /etc/nginx/sites-enabled/perftestsite.local.conf
```
### Common Issues I faced

```nginx: [warn] conflicting server name "" on 0.0.0.0:90, ignored````
 - Accidently defined the server_name directive in two places
  - check site-enabled `>ngcdsa`

