# [Unit]
# Description=Enable Firewall

function main(){
    _activate_dependencies

    _enable_firewall
}

function _enable_firewall(){
    sudo ufw status
    sudo ufw enable
}

function _activate_dependencies(){
  sudo apt install ufw
}