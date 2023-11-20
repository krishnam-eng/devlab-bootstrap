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
	# create group
	groupadd sftpusers

	adduser sftpclt # set sftpcltpwd
	usermod -a -G sftpusers sftpclt

	mkdir /sftpusers
	sudo chmod 755 /sftpusers
	chown root:root /sftpusers

    mkdir /sftpusers/sftpclt
    chown root:sftpusers -R /sftpusers/sftpclt

    mkdir /sftpusers/sftpclt/input
    mkdir /sftpusers/sftpclt/output
    mkdir /sftpusers/sftpclt/processing
    chown sftpclt:sftpusers -R /sftpusers/sftpclt/input
    chown sftpclt:sftpusers -R /sftpusers/sftpclt/output
    chown sftpclt:sftpusers -R /sftpusers/sftpclt/processing

	# verify user
	id sftpclt
}
