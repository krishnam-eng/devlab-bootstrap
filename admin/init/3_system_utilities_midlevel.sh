function load_system_utility() {
    sudo apt install -y htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
    sudo apt install -y sysstat        # iostat - cpu usage
    sudo apt install -y ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
    sudo apt install -y net-tools     # ifconfig - interface config
    sudo apt install -y bridge-utils # brctr - ethernet brdige admin
    sudo apt install -y ufw              # uncomplicated firewall

    sudo apt install -y ctop             # top-like interface for container metrics

    sudo apt install -y vsftpd                 # very secure ftp daemon
    sudo apt install -y openssh-server # ssh server with sftp subsystem
    sudo apt install -y openssh-client   # ssh client
}
