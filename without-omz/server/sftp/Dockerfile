FROM ubuntu:23.10

ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS

RUN apt update && apt upgrade -y
RUN apt install openssh-server -y
RUN apt install sudo -y
RUN apt install tree -y

# ssh server and client configuration
COPY ssh/ssh_config /etc/ssh/ssh_config
COPY ssh/sshd_config /etc/ssh/sshd_config

# custom bashrc
COPY scripts/aliases.bashrc /home/${SSH_MASTER_USER}/aliases.bashrc

# Create users and sftp directories for each user
COPY scripts/user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
RUN rm /usr/local/bin/user.sh


RUN mkdir /home/${SSH_MASTER_USER}/.ssh
COPY ssh/authorized_keys /home/${SSH_MASTER_USER}/.ssh/authorized_keys

# added the -e option to the CMD, which makes the SSH server run in the foreground and log messages to the standard error stream
CMD ["/usr/sbin/sshd", "-D", "-e"]
