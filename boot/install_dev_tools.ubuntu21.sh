
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

######## python

sudo apt install python3.9

sudo update-alternatives --config python3

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
sudo apt install python3.9


sudo ln -s /usr/bin/python3 /usr/bin/python
sudo ln -s /usr/bin/python3.9 /usr/bin/python3

ls -lh /usr/bin/python*
#lrwxrwxrwx 1 root root   16 Apr 18 11:21 /usr/bin/python -> /usr/bin/python3*
#lrwxrwxrwx 1 root root   18 Apr 18 11:22 /usr/bin/python3 -> /usr/bin/python3.9*
#-rwxr-xr-x 1 root root 5.1M Jan 27 21:12 /usr/bin/python3.8*
#-rwxr-xr-x 1 root root 5.3M Oct 19 15:21 /usr/bin/python3.9*

##### IDE
firefox https://code.visualstudio.com/Download
sudo dpkg -i ~/dwnlds/code_1.55.2-16183│07277_amd64.deb


