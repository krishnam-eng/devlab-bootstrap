#!/usr/bin/env bash
#############################################################################################################
# name       : Make My Dev Environment
# description: Build powerful dev environment with numerous micro automation
# author     : krishnam
#
#  Bootstrap new Box:
#    Step 1: Build file structure which will be used in aliases, functions, run configuration to simplyfy micro dev tasks
#            `build_file_hierarchy_structure()``
#    Step 2: Install required system tools
#             `install_core_packages()`  (look at the mkdevenv-macos/linux script)
#    Step 3: Build workspace core with battle tested and fine tunned pre-configurations (runcommand configs for various dev tools)
#              `configure_mydevbox_with_homelabsetup()`
#    Step 4: Install packages requires for dev work
#               `install_dev_tools()` (look at the mkdevenv-macos/linux script)
#    Step 5: Any Misc Steps
#               `other_misc_steps()` (look at the mkdevenv-macos/linux script)
#############################################################################################################

################################## START: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
function build_file_hierarchy_structure(){
    #l1
    mkdir ~/kroot      # create _k_rishnam config _root_
    mkdir ~/proj
    mkdir ~/bkp        # long live
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
    mkdir ~/kroot/proj
    mkdir ~/kroot/private
    mkdir ~/kroot/history
    mkdir ~/kroot/resurrect
    mkdir ~/kroot/virtualenvs

    #l3
    mkdir ~/kroot/proj/github
    mkdir ~/kroot/plugins/tmux
    mkdir ~/kroot/history/shell
    mkdir ~/kroot/history/tmux
    mkdir ~/kroot/resurrect/tmux

    #l4
    mkdir ~/kroot/plugins/tmux/tpm
    
    # Check
    tree
}

function configure_mydevbox_with_homelab_source(){
    
    # Checkout HomeLab source to configure DevBox 
    #
    # * myws: intend is to make the config root name fixed irrespective of the github repo name. config root name will be refered in many micro automation
    git clone --depth=1 https://github.com/krishnam-eng/homelab-devbox ~/kroot/myws

    # Configure: Git Remote & Other Configs to stay connected with homelab-devbox
    #    
    # git remote set-url origin git@github.com:krishnam-eng/homelab-devbox
    # or, the below to set other git configs also
    cp ~/kroot/myws/git/.git_config ~/kroot/myws/.git/config

    # Configure: Shell - Bash & Zsh
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.bashrc ~/bkp/.bashrc_$(date +%y%m%d)-old
    cp ~/.zshenv ~/bkp/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/bkp/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc 
    
    ln -s ~/kroot/myws/bash/.bashrc  ~/.bashrc
    ln -s ~/kroot/myws/zsh/.zshenv ~/.zshenv
    
    # Configure: Tmux
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
    rm -f ~/.tmux.conf ~/.nanorc
    ln -s ~/kroot/myws/tmux/.tmux.conf ~/.tmux.conf

    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    rm -f ~/.nanorc
    ln -s ~/kroot/myws/nano/.nanorc  ~/.nanorc

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

################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
