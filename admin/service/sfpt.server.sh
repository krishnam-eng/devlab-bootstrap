# [Unit]
# Description=SFTP Server
# After=ssh.service

# [Service]
# ExecStartPre=ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

# Troubleshooting: Run with verbose mode
#     sftp -v -P 22 erebus@hostname

function main(){
    _create_sftp_users
    _enable_sftp_server
}

function _enable_sftp_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    sudo ln -s $HOME/hrt/boot/ctrls/linux/etc/sshd_config.d/sftpusers.conf /etc/ssh/sshd_config.d/sftpusers.conf

    sudo systemctl restart ssh
}

function _create_sftp_users() {
	# create group & user
	groupadd sftpusers

	adduser sftpclt # set sftp pwd
	usermod -a -G sftpusers sftpclt
	sudo chsh -s /bin/bash sftpclt    # set shell to bash, to override /bin/false

	adduser sftpadmin # set sftp pwd
	usermod -a -G sudo sftpadmin   # add to sudo group

    mkdir /sftp
    chown root:root /sftp
    chmod 755 /sftp

    mkdir /sftp/sftpclt
    chown sftpclt:sftpclt /sftp/sftpclt
    chmod 700 /sftp/sftpclt

    mkdir /sftp/sftpclt/.ssh
    chown sftpclt:sftpclt /sftp/sftpclt/.ssh
    chmod 700 /sftp/sftpclt/.ssh                                              # ! To avoid, Could not open user 'sftpclt' authorized keys

	touch /sftp/sftpclt/.ssh/authorized_keys
    chown sftpclt:sftpclt /sftp/sftpclt/.ssh/authorized_keys
    chmod 600 /sftp/sftpclt/.ssh/authorized_keys                  # ! To avoid, Authentication refused: bad ownership or modes for file

	# setup public keys authentication (change root is setup by match group policy, so setup keys in that root)
	# paste in /sftp/sftpclt/.ssh/authorized_keys & /home/sftpclt/.ssh/authorized_keys (just in case)
	cat $HOME/.ssh/id_rsa.pub
	cat $HOME/.ssh/server_access_key_chaos_ubuntuvm_vbox.pub # pub key from client server

	# verify user
	id sftpadmin # not used
	id sftpclt
	su - sftpadmin
	su - sftpclt
}
