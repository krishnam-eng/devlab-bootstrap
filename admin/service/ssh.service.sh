# [Unit]
# Description=OpenBSD Secure Shell server
# After=firewall.service

# [Service]
# ExecStartPre=ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/authorized-keys.conf /etc/ssh/sshd_config.d/authorized-keys.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

# [Install]
# WantedBy=sftp.service

# Usage:
#     Add user public key to sshd_config.d/authorized-keys.conf to have access to the server
#
#     Step 1: From a machine where ssh access is required,
#             ssh-copy-id  -i {identity-file} -p 'ssh-sever-port' {username_in_ssh_server}@{ssh_server_hostname}
#           e.g.,
#             ssh-copy-id  -i ~/.ssh/server_access_key_chaos_ubuntuvm_vbox.pub -p 22 erebus@172.25.66.189
#
#         or
#               : Manually copy the key to the server out-of-band
function main(){
    _activate_dependencies

    _enable_ssh_server
    _allow_ssh_with_firewall

    _configure_ssh_client
}

function _enable_ssh_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    ln -s $HOME/hrt/boot/ctrls/unix/etc/sshd_config.d/authorized-keys.conf /etc/ssh/sshd_config.d/authorized-keys.conf
    sudo systemctl restart ssh.service
}

function _allow_ssh_with_firewall(){
    sudo ufw allow ssh
    sudo ufw status
}

function _configure_ssh_client() {
    ln -s $HOME/hrt/boot/settings/ssh/ssh_client.config ~/.ssh/config
}

function _activate_dependencies(){
  # install ssh client / server
  sudo apt install openssh-server
  sudo apt install openssh-client
}
