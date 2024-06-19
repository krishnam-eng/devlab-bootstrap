function load_system_utility_darwin_macos() {
    brew install htop                # interactive process viewer similar to top but that provides a nicer user experience out of the box
    brew install ctop                # top-like interface for container metrics

    brew install ncdu
}

function load_system_utility_ubuntu() {
    sudo apt install -y htop           # Pre-Installed in ubuntu 22.04: interactive process viewer similar to top but that provides a nicer user experience out of the box
    sudo apt install -y ctop           # top-like interface for container metrics
    sudo apt install sysstat           # iostat - cpu usage. It comes with macos

    sudo apt install ncdu              # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
    sudo apt install bluez             # for hcitool - devices
    sudo apt install net-tools         # for ifconfig cmd - interface config
    sudo apt install network-manager   # for nmcli
    sudo apt install bridge-utils      # brctl - ethernet bridge admin
    sudo apt install ufw               # Pre-Installed in ubuntu 22.04: uncomplicated firewall

    sudo apt install -y vsftpd         # very secure ftp daemon
    sudo apt install -y openssh-server # ssh server with sftp subsystem
    sudo apt install -y openssh-client # Pre-Installed in ubuntu 22.04: ssh client
}