#!/bin/bash
set -e

printf "\n\033[0;44m---> Creating SSH master user.\033[0m\n"

useradd -m -d /home/${SSH_MASTER_USER} ${SSH_MASTER_USER} -s /bin/bash
echo "${SSH_MASTER_USER}:${SSH_MASTER_PASS}" | chpasswd
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/${SSH_MASTER_USER}/.profile
echo "${SSH_MASTER_USER} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# Root directory creation for sftp users
mkdir /sftp
chown root:root /sftp
chmod 755 /sftp

# Home directory creation for host login user (sftp via login user)
mkdir /sftp/data/
chown ${SSH_MASTER_USER}:${SSH_MASTER_USER} /sftp/data/

# add sftp users per tenants
useradd -m -d /home/tenanta tenanta -s /bin/bash
useradd -m -d /home/tenantb tenantb -s /bin/bash

echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/tenanta/.profile
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/tenantb/.profile

 # sftp data directory per tenant
 mkdir /sftp/data/${SSH_MASTER_USER}
 chown ${SSH_MASTER_USER}:${SSH_MASTER_USER} /sftp/data/${SSH_MASTER_USER}

 mkdir /sftp/data/tenanta
 chown tenanta:${SSH_MASTER_USER} /sftp/data/tenanta

 mkdir /sftp/data/tenantb
 chown tenantb:${SSH_MASTER_USER} /sftp/data/tenantb

 source /home/${SSH_MASTER_USER}/aliases.bashrc

exec "$@"