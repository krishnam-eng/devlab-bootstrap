# [Unit]
# Description=SFTP Server
# After=ssh.service

# [Service]
# ExecStartPre=ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

# Troubleshooting: Run with verbose mode
#     sftp -v -P 22 erebus@hostname

function main(){
    _enable_sftp_server
    _create_sftp_users
}

function _enable_sftp_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    ln -s $HOME/hrt/boot/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
    sudo systemctl restart ssh.service
}

# todo: sftp login failure for new users. it works only with existing main user
function _create_sftp_users() {
	# create group
	groupadd sftpusers

	adduser sftpclt # set sftpcltpwd
	usermod -a -G sftpusers sftpclt

	mkdir /sftpusers
	sudo chmod 755 /sftpusers
	chown root:root /sftpusers

    mkdir /sftpusers/sftpclt
    chown root:sftpusers -R /sftpusers/shared

    mkdir /sftpusers/sftpclt/incoming
    chown sftpclt:sftpusers -R /sftpusers/sftpclt/incoming/

	# verify groups
	id sftpusers
	id sftpclt
}
