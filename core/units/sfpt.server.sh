# [Unit]
# Description=SFTP Server
# After=ssh.service

# [Service]
# ExecStartPre=ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

function main(){
    _activate_dependencies

    _create_sftp_users
    _enable_sftp_server
}

function _create_sftp_users() {
  # create group
  sudo groupadd sftpusr

  # create users
  sudo useradd -m -d /home/sftpclt -s /bin/false -G sftpusr sftpclt
  sudo useradd -m -d /home/gaia -s /bin/false -G sftpusr gaia

  # verify groups
  id sftpclt
  id gaia

  # create password
  sudo passwd sftpclt
  sudo passwd gaia
}

function _enable_sftp_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
    sudo systemctl restart ssh.service
}

function _activate_dependencies(){
  sudo apt install ufw
}

