# [Unit]
# Description=SFTP Server
# After=ssh.service

# [Service]
# ExecStartPre=ln -s $HOME/Paradigm/Development/Root/settings/ssh/sshd_config.d/sftp-server.conf /etc/ssh/sshd_config.d/sftp-server.conf
# ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd_config

# Troubleshooting: Run with verbose mode
#     sftp -v -P 22 erebus@hostname

function main(){
    _activate_dependencies

    _create_sftp_users
    _enable_sftp_server
}

function _enable_sftp_server(){
    sudo systemctl status ssh
    sudo systemctl enable ssh
    sudo systemctl start  ssh

    # Enable authkey based login
    sudo ln -s $HOME/Paradigm/Development/Root/ctrls/linux/etc/sshd_config.d/sftpusers.conf /etc/ssh/sshd_config.d/sftpusers.conf

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

	# Root directory creation for sftp users
    mkdir /sftp
    chown root:root /sftp
    chmod 755 /sftp

	# Home directory creation for host login user (sftp via login user)
	mkdir /sftp/data/
	chown erebus:erebus /sftp/data/

	# Home directory creation for sftpclt user
	# sftp via sftpclt user will not allow to execute commands due to /bin/false shell; so use login user for that purpose
    mkdir /sftp/sftpclt
    chown sftpclt:sftpclt /sftp/sftpclt
    chmod 700 /sftp/sftpclt

    mkdir /sftp/sftpclt/.ssh
    chown sftpclt:sftpclt /sftp/sftpclt/.ssh
    chmod 700 /sftp/sftpclt/.ssh                                              # ! To avoid, Could not open user 'sftpclt' authorized keys

	touch /sftp/sftpclt/.ssh/authorized_keys
    chown sftpclt:sftpclt /sftp/sftpclt/.ssh/authorized_keys
    chmod 600 /sftp/sftpclt/.ssh/authorized_keys                  # ! To avoid, Authentication refused: bad ownership or modes for file

	# test directory creation for sftpclt user
	mkdir /sftp/sftpclt/test
	chown sftpclt:sftpclt /sftp/sftpclt/test

	# test directory creation for sftpclt user
	mkdir /sftp/erebus/test
	chown erebus:erebus /sftp/erebus/test

	# setup public keys authentication (change root is setup by match group policy, so setup keys in that root)
	# paste in /sftp/sftpclt/.ssh/authorized_keys & /home/sftpclt/.ssh/authorized_keys (just in case)
	cat $HOME/.ssh/id_rsa.pub
	cat $HOME/.ssh/server_access_key_chaos_ubuntuvm_vbox.pub # pub key from client server

	# verify user
	id sftpadmin # not used
	id sftpclt
	su - sftpadmin
	su - sftpclt

	# add sftp users per tenants
	adduser tenanta # set password username+pwd
	adduser tenantb # set password username+pwd

	 id tenanta tenantb # verify user

	 # sftp data directory per tenant
	 mkdir /sftp/data/erebus
	 chown erebus:erebus /sftp/data/erebus

	 mkdir /sftp/data/tenanta
	 chown tenanta:erebus /sftp/data/tenanta

	 mkdir /sftp/data/tenantb
	 chown tenantb:erebus /sftp/data/tenantb
}

function _enable_audit_on_sftp_dir()
{
	systemctl enable auditd

	auditctl -w /sftp -p wa -k sftp-action
    auditctl -w /sftp/data -p wa -k sftp-action
    auditctl -w /sftp/data/erebus -p wa -k sftp-action
	auditctl -w /sftp/data/tenanta -p wa -k sftp-action
	auditctl -w /sftp/data/tenantb -p wa -k sftp-action

    # tail -f /var/log/audit/audit.log | grep sftp-action
}

function _activate_dependencies(){
  # install ssh client / server
  sudo apt install auditd
}
