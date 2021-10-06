#!/usr/bin/env bash
#############################################################################################################
# name       : Make My Dev Environment
# description: Build portable dev environment anywhere
# author     : krishnam
#
#  Bootstrap new Box:
#    Step 1: build_file_hierarchy_structure()
#    Step 2: Build workspace core with battle tested and fine tunned pre-configurations (runcommand configs for various dev tools)
#              `build_my_workspace_core()`
#    Step 3: Install required packages
#               install_in_ubuntu_env()
#    Step 4: Any Misc Steps
#               `other_misc_steps()`
#############################################################################################################

################################## START: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
function build_file_hierarchy_structure(){
    #l1
    mkdir ~/kroot      # create _k_rishnam config _root_
    mkdir ~/proj
    mkdir ~/bkp        # long live
    mkdir ~/.mybkp     # temp 
    mkdir ~/log
    mkdir ~/tmp

    #l2
    mkdir ~/kroot/myws
    mkdir ~/kroot/ctrflags/  # change tools (zsh) default behaviours by flags
    mkdir ~/kroot/style
    mkdir ~/kroot/bin
    mkdir ~/kroot/build
    mkdir ~/kroot/etc
    mkdir ~/kroot/lib
    mkdir ~/kroot/var
    mkdir ~/kroot/plugins
    mkdir ~/kroot/private
    mkdir ~/kroot/history
    mkdir ~/kroot/resurrect
    mkdir ~/kroot/virtualenvs

    mkdir ~/proj/gh  # github
    mkdir ~/proj/bb  # bitbucket

    #l3
    mkdir ~/kroot/plugins/tmux
    mkdir ~/kroot/history/shell
    mkdir ~/kroot/history/tmux
    mkdir ~/kroot/resurrect/tmux

    #l4
    mkdir ~/kroot/plugins/tmux/tpm

    # this is a workspace, remove all default desktop dirs and enter into zen mode
    \rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos
    
    # Check
    sudo apt install tree
    tree
}

function build_my_workspace_core(){
    # core install (might be already installed)
    sudo apt install git 
    sudo apt install nano            # feature-rich CLI text editor for power users 
    sudo apt install tmux            # terminal multiplexer
    sudo apt install zsh             # powerful sh
    
    # * myws: intend is to make the config root name fixed irrespective of the github repo name. config root name will be refered in many micro automation
    git clone --depth=1 https://github.com/krishnam-eng/ohmy-linux ~/kroot/myws

    # for home pc: git remote set-url origin git@github.com:krishnam-eng/ohmy-linux

    # create links to tools run configs (or copy and further customize if you want to be disconnected from repo)
    cp ~/.bashrc ~/.mybkp/.bashrc_$(date +%y%m%d)-old
    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
    cp ~/.zshenv ~/.mybkp/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/.mybkp/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc ~/.tmux.conf ~/.nanorc
    
    ln -s ~/kroot/myws/bash/.bashrc  ~/.bashrc
    ln -s ~/kroot/myws/nano/.nanorc  ~/.nanorc
    ln -s ~/kroot/myws/tmux/.tmux.conf ~/.tmux.conf
    ln -s ~/kroot/myws/zsh/.zshenv ~/.zshenv
    ln -s ~/kroot/myws/git/.gitconfig ~/.gitconfig

    # TMUX plugin manager
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/kroot/plugins/tmux/tpm
    # next: reload tmux conf , and press <prefix> Shift+R to install plugins

    # zsh style - theme & font to boost dev productivity
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/kroot/style/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  ~/kroot/style/zsh-autosuggestions
    
    # {atomic-op:start
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/kroot/style/powerlevel10k
        # install fonts for powerline 
        install_and_enable_for_powertheme()
        reboot
    # atomic-op:end}
    
    git clone --depth=1 https://github.com/erikw/tmux-powerline.git  ~/kroot/style/tmux-powerline
    cp ~/kroot/myws/tmux/tmux-powerline-theme.sh ~/kroot/style/tmux-powerline/themes/default.sh

    # nano editor
    sudo ln -s ~/kroot/myws/nano/syntax-highlight/yaml.nanorc /usr/share/nano/yaml.nanorc
}

function install_in_ubuntu_env(){
    # to get the latest version, it is preferable to use ppa - personal package archive repo over default ubuntu repo
    # Install Optional items later when needed

    # basic tools to start with
    sudo apt install vim             # open-source clone of vi text editor developed to be customizable and able to work with any type of text
    sudo apt install watch           # 
    sudo apt install curl            #
    sudo apt install tree            # list dir in tree form
    sudo apt install gawk            # GNU awk  
    sudo apt install rar unrar       # archive utilities
    sudo apt install zip unzip      # [default in version > ubuntu21.04]
    sudo apt install xclip           # [default in version > ubuntu21.04] clipboard management
    sudo apt install rsync           # [default in version > ubuntu21.04] utility tool for performing swift incremental file transfers
    sudo apt install guake           # drop down terminal emulator - # ! use x (x11 or xarg) display server since keybinding doesn't work well in wyaland server
    # todo: Keymapping for F12 needs to be resolved manually for the below step
    # sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/ 
    
    
    # system utilities
    sudo apt install exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install ranger          # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)    
    sudo apt install fd-find         # fdfind: a program to find entries in your filesytem. It is a simple, fast and user-friendly alternative to find
    sudo apt install ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
    sudo apt install htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
    sudo pip install glances         # system monitoring tool
    sudo apt install ctop            # top-like interface for container metrics
    sudo apt install sysstat         # iostat - cpu usage
    sudo apt install bridge-utils    # brctr - ethernet brdige admin cmd
    
    # Java Dev: Basic Development Tools & Others
    sudo apt install openjdk-11-jre-headless
    sudo apt install openjdk-8-jre-headless
    sudo add-apt-repository ppa:cwchien/gradle # use this repo to get latest gradle version
    sudo apt install gradle          # build tool & dependency manager
    sudo apt install httpie          # user-friendly command-line HTTP client for the API era
    sudo apt install jq              # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data    
    sudo apt install apache2         # [optional] web server
    sudo apt install nginx           # [optional] web server
    sudo apt install tomcat9         # [optional] servlet container
    sudo apt install nodejs          # [optional] servlet container
    sudo apt install npm             # [optional] package manager for the nodejs platform    
    sudo apt install apache2-utils   # [optional] ab: apache bench for cli single page load test, htpassword : create pwd
    sudo apt install openssl         # [optional] to create ssl certificates    
    sudo snap install intellij-idea-community --classic # [optional] IDE for JVM
    
    # Python Dev: Virtual Env & Others
    sudo apt install python3.9       # python latest (already installed)
    sudo apt install python3-pip     # package management - Pip Installs Packages
    pip install autopep8             # vscode needs this for auto formatting
    sudo apt install virtualenv      # provides virtual environment - has its own Python binary and independent set of Python packages
    pip install virtualenvwrapper    # provides a set of commands that extend Python virtual environments for more control and better manageability. It places all your virtual environments in one directory
    sudo apt install pipx            # [optional] help you install and run end-user applications written in Python into an isolated environment. It's roughly similar to apt-get.
    pip install locust               # [optional] open source load testing tool, define user behaviour with Python code
    pip install rope                 # [optional] python refactoring library - used in vscode
    sudo snap install --classic code # IDE for light weight project (python, scripts)
    
    # Container: Check latest instructions from
    # https://docs.docker.com/engine/install/ubuntu/
    # Step 1: Set up the repository
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-releasesudo apt install docker-ce
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # Step 2: Install Docker Engine
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    # Step3: Check
    sudo docker run hello-world
    # Docker Compose
    # https://docs.docker.com/compose/install/
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    # just for fun
    sudo apt install cowsay            # An ASCII cow in terminal that will say what ever you want
    sudo apt install figlet            # utility for creating ASCII text banners or large letters out of ordinary text
    sudo apt install cmatrix           # shows a scrolling ‘Matrix‘ like screen in a Linux terminal [Not in venv setup]
    sudo apt install lolcat            # [Not in venv setup]
    
    # clean if any package is no longer needed
    sudo apt update; sudo apt upgrade ; sudo apt autoremove
}

function install_and_enable_for_powertheme(){
    
    # zsh rc is updated to use this as a flag to enable or disable power theme
    touch ~/kroot/ctrflags/enablepowertheme

    # check https://powerline.readthedocs.io/en/latest/installation/linux.html#fonts-installation
    pip install --user powerline-status
    pip install --user git+git://github.com/powerline/powerline
    
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir -p ~/.local/share/fonts/
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
    
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    
    fc-list
    
    # If custom symbols cannot be seen then try closing all instances of the terminal emulator. X server may need to be restarted for the changes to take effect.
    # If custom symbols still can’t be seen then double-check that the font have been installed to a valid X font path.
    # OR, try the below approach
    
    git clone https://github.com/powerline/fonts.git --depth=1  ~/kroot/style/powerline-fonts
    cd ~/kroot/style/powerline-fonts
    ./install.sh    
    
    # Still not working, It is ok. Just Disable power theme for now
    rm ~/kroot/ctrflags/enablepowertheme
}

function other_misc_steps(){
    # Switching remote URLs from HTTPS to SSH
    ssh-keygen -t ed25519 -C "username@email.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    xclip -selection clipboard < ~/.ssh/id_ed25519.pub
    # Add the key to github account
    cd ~myws
    git remote set-url origin git@github.com:krishnam-eng/ohmy-linux.git
    git remote -v
    
    # set default shell to zsh [echo $SHELL]
    chsh -s $(which zsh)



    # mount shared folder from host os (for vbox)
    mkdir -p ~/shared
    sudo mount -t vboxsf  vbox_shared  ~/shared
}

function validate_kroot(){
    # todo
}
################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
