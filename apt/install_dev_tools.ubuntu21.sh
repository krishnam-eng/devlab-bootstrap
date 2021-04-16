
# take a log of manually installed packages and its dependent packages
apt list --manual-installed >| ~/github/ohmy-linux/apt/useful_manually_installed-dev_apt-$(date +%Y%m).list 2>/dev/null

# take install cmds from histroy 
history  | grep -e "sudo apt-get install " | cut -c 8-  >> ~/github/ohmy-linux/apt/install_dev_tools.ubuntu21.sh 
history  | grep -e "sudo apt install " | cut -c 8-  >> ~/github/ohmy-linux/apt/install_dev_tools.ubuntu21.sh

sudo apt-get install chrome

sudo apt-get install zsh

sudo apt-get install unzip
sudo apt-get install tree

#  used in nano
sudo apt-get install spell
sudo apt-get install vim

sudo apt-get install git

sudo apt-get install gcc
sudo apt-get install perl
sudo apt-get install default-jdk

sudo apt-get install apache2
sudo apt-get install tomcat9
sudo apt-get install tomcat9-admin tomcat9-docs tomcat9-examples

sudo apt-get install libxml2-utils




