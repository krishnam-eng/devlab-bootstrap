#### SSH setup
mkdir -p ~/.ssh         # dir  is auto created when the user runs the ssh cmd for the first time
chmod 700 ~/.ssh

touch ~/.ssh/config     # by default, the SSH configuration file may not exist
chmod 600 ~/.ssh/config # file must be readable and writable only by the user



#### github ssh access

# 1. keygen with ed25519 algo
ssh-keygen -t ed25519 -C "krishnam.balamurugan.eng@gmail.com"

# 2. add private to ssh agent 
ssh-add ~/.ssh/id_ed25519

# 3. add pub key to github->settings->ssh 

# 4. switch it to ssh from https [if the old remote was https]
git remote -v
git remote set-url origin  git@github.com:krishnam-eng/ohmy-linux.git

#Out: Warning: Permanently added 'github.com,13.234.176.102' (RSA) to the list of known hosts.


#### setup permissons right 

chmod -R u+x ~/.mytmux/session_scripts/
