# [Unit]
# Description=OpenBSD Secure Shell server
# After=firewall.service

# [Service]
# ExecStartPre=ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/authorized-keys.conf /etc/ssh/sshd_config.d/authorized-keys.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

# [Install]
# WantedBy=sftp.service

function main(){
    _activate_dependencies

    _enable_ssh_server
    _allow_ssh_with_firewall
}

function _enable_ssh_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/authorized-keys.conf /etc/ssh/sshd_config.d/authorized-keys.conf
    sudo systemctl restart ssh.service
}

function _allow_ssh_with_firewall(){
    sudo ufw allow ssh
    sudo ufw status
#    To                         Action        From
#    --                          ------          ----
#    22/tcp                  ALLOW       Anywhere
}


function _activate_dependencies(){
  # install ssh client / server
  sudo apt install openssh-server
  sudo apt install openssh-client
}
