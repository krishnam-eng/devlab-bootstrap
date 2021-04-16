sudo apt update
sudo apt upgrade

# install ssh client / server
sudo apt install openssh-server
sudo apt install openssh-client # pre-installed


# server start ...
sudo systemctl status ssh
sudo systemctl enable ssh
sudo systemctl start  ssh

# config ubuntu firewall
sudo ufw allow ssh
sudo ufw enable
sudo ufw status

# server/client config goes here - control default port, banner, auth setup, host alias...
# fileneme: sshd_config , config

ln -s ~/github/ohmy-linux/ssh ~/.myssh
ln -s ~/myssh/config ~/.ssh/config
ln -s ~/myssh/sshd_config ~/.ssh/sshd_config




# https://ubuntu.com/server/docs/service-openssh

