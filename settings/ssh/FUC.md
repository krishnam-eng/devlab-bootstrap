## Frequently Used Commands

### SSH Basics 

Generate Key Pairs
```
ssh-keygen -t ed25519 -b 256
cat ~/.ssh/id_rsa.pub | pbcopy
```

SSH Client
```
vim ~/.ssh/known_hosts

vim ~/.ssh/config

vim /etc/ssh/ssh_config
```

SSH Server 
```
vim ~/.ssh/authorized_keys

vim /etc/ssh/sshd_config
```

```
$(ssh-agent)
ssh-add -l
ssh-add ~/.ssh/{private-key}
ssh -T $testpath
```

### Practical Tasks with SSH
#### SFTP
```
sftp 
    put
    get
```

#### SCP
```
scp
```
#### Multi-Step SSH Connection
 - Jump Host / Bastion Host (all will connect here,then go to actual host)

Enable Jump host
```
ssh -J user@host1 user@host2
```
#### Port Forwarding

Local, remote, dynamic port forwarding
```
ssh -L port:host_in_the_remote_host_pov:port # Local Access to the Remote
ssh -R
ssh -D
```
##### Local Port Forwarding
 -> access local web page from the remote machine as if it is running in the remote machine e.g., in remote machine, localhost:8080 will point to local machine 8080 

```
ssh -L 8080:localhost:80 user@remotehost
```

##### Remote Port Forwarding
 a.k.a reverse tunneling (from remote pov)
 -> Send traffic to local port, it will 

##### Security 

Get server fingerprint and share with client upfront 
```
ssh-keyscan 
```
