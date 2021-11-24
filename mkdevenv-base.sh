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
    mkdir ~/hrt      # create Homelab RooT (HRT). ~/hrt will be the heart of the devbox
    mkdir ~/proj
    mkdir ~/bkp        # long live
    mkdir ~/log
    mkdir ~/tmp

    #l2
    mkdir ~/hrt/myws
    mkdir ~/hrt/ctrflags/  # change tools (zsh) default behaviours by flags
    mkdir ~/hrt/style
    mkdir ~/hrt/bin
    mkdir ~/hrt/build
    mkdir ~/hrt/etc
    mkdir ~/hrt/lib
    mkdir ~/hrt/var
    mkdir ~/hrt/plugins
    mkdir ~/hrt/proj
    mkdir ~/hrt/private
    mkdir ~/hrt/history
    mkdir ~/hrt/resurrect
    mkdir ~/hrt/virtualenvs

    #l3
    mkdir ~/hrt/proj/github
    mkdir ~/hrt/plugins/tmux
    mkdir ~/hrt/history/shell
    mkdir ~/hrt/history/tmux
    mkdir ~/hrt/resurrect/tmux

    #l4
    mkdir ~/hrt/plugins/tmux/tpm
    
    # Check
    tree
}

function configure_mydevbox_with_homelab_source(){
    
    # Checkout HomeLab source to configure DevBox 
    #
    # * myws: intend is to make the config root name fixed irrespective of the github repo name. config root name will be refered in many micro automation
    git clone --depth=1 https://github.com/krishnam-eng/homelab-devbox ~/hrt/myws

    # Configure: Git Remote & Other Configs to stay connected with homelab-devbox
    #    
    # git remote set-url origin git@github.com:krishnam-eng/homelab-devbox
    # or, the below to set other git configs also
    cp ~/hrt/myws/git/.git_config ~/hrt/myws/.git/config

    # Configure: Shell - Bash & Zsh
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.bashrc ~/bkp/.bashrc_$(date +%y%m%d)-old
    cp ~/.zshenv ~/bkp/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/bkp/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc 
    
    ln -s ~/hrt/myws/bash/.bashrc  ~/.bashrc
    ln -s ~/hrt/myws/zsh/.zshenv ~/.zshenv
    
    # Configure: Tmux
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
    rm -f ~/.tmux.conf ~/.nanorc
    ln -s ~/hrt/myws/tmux/.tmux.conf ~/.tmux.conf

    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    rm -f ~/.nanorc
    ln -s ~/hrt/myws/nano/.nanorc  ~/.nanorc

    # TMUX plugin manager
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/hrt/plugins/tmux/tpm
    # next: reload tmux conf , and press <prefix> Shift+R to install plugins

    # zsh style - theme & font to boost dev productivity
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/hrt/style/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  ~/hrt/style/zsh-autosuggestions
    
    # {atomic-op:start
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/hrt/style/powerlevel10k
        # install fonts for powerline 
        install_and_enable_for_powertheme()
        reboot
    # atomic-op:end}
    
    git clone --depth=1 https://github.com/erikw/tmux-powerline.git  ~/hrt/style/tmux-powerline
    cp ~/hrt/myws/tmux/tmux-powerline-theme.sh ~/hrt/style/tmux-powerline/themes/default.sh

    # nano editor
    sudo ln -s ~/hrt/myws/nano/syntax-highlight/yaml.nanorc /usr/share/nano/yaml.nanorc
}

################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
