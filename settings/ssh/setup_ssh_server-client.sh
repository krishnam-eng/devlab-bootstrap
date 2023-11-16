# server/client config goes here - control default port, banner, auth setup, host alias...
# fileneme: sshd_config , config
mkdir -p ~/.ssh         # dir  is auto created when the user runs the ssh cmd for the first time
chmod 700 ~/.ssh

ln -s ~/github/ohmy-linux/ssh ~/.myssh
ln -s ~/.myssh/config ~/.ssh/config
chmod 600 ~/.ssh/config # file must be readable and writable only by the user

cp /etc/ssh/sshd_config ~/.myssh/sshd_config.original
sudo ln -s ~/.myssh/sshd_config /etc/ssh/sshd_config




# https://ubuntu.com/server/docs/service-openssh

#### SSH setup

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

##### useful cmds

# from local to add pub key to remote
ssh-copy-id username@hostname -p 'portnumber in sshd'

# or append pub keys to ~/.ssh/authorized_keys

# connect to remote from terminal
ssh -p 'portnumber' 'username@hostname'

# connect to remote from windows Putty
# 1. use brdige network adaptor
# 2. use NAT for port forwarding
Hostname : username@hostname Post: port as per sshd
% ps -ef | grep sshd



