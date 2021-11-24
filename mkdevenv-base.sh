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
    mkdir ~/hrt       # create Homelab RooT (HRT). ~/hrt will be the heart of the devbox
    mkdir ~/proj
    mkdir ~/bkp
    mkdir ~/log
    mkdir ~/tmp

    #l2
    mkdir ~/hrt/hldr       # HomeLab-Devbox Repo (HLDR) is the dir for local copy of this repo and (this HLDR holds the heart HRT functioning like SA Node)
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
    mkdir ~/hrt/style/fonts
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
    # * hldr: intend is to make the config root name fixed irrespective of the github repo name. config root name will be refered in many micro automation
    git clone --depth=1 https://github.com/krishnam-eng/homelab-devbox ~/hrt/hldr
    git remote -v
    git remote set-url origin git@github.com:krishnam-eng/homelab-devbox.git

    # Configure: Shell - Bash & Zsh
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.bashrc ~/bkp/.bashrc_$(date +%y%m%d)-old
    cp ~/.zshenv ~/bkp/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/bkp/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc 
    
    ln -s ~/hrt/hldr/bash/.bashrc  ~/.bashrc
    ln -s ~/hrt/hldr/zsh/.zshenv ~/.zshenv
    

    # zsh style - theme & font to boost dev productivity
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/hrt/style/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  ~/hrt/style/zsh-autosuggestions
    
    # Font to support more nerdy icons
    git clone --depth=1  git@github.com:ryanoasis/nerd-fonts ~/hrt/style/nerd-fonts
    sh ~/hrt/style/nerd-fonts/install.sh 'JetBrainsMono'

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/hrt/style/powerlevel10k
    p10k configure
    touch ~/hrt/ctrflags/enablepowertheme
    # reboot

    # nano editor
    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    rm -f ~/.nanorc
    ln -s ~/hrt/hldr/nano/.nanorc  ~/.nanorc
    sudo ln -s ~/hrt/hldr/nano/syntax-highlight/yaml.nanorc /usr/share/nano/yaml.nanorc

    # Configure: Tmux
    #
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
    rm -f ~/.tmux.conf ~/.nanorc
    ln -s ~/hrt/hldr/tmux/.tmux.conf ~/.tmux.conf

    # TMUX plugin manager
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/hrt/plugins/tmux/tpm
    # next: reload tmux conf , and press <prefix> Shift+R to install plugins
    git clone --depth=1 https://github.com/erikw/tmux-powerline.git  ~/hrt/style/tmux-powerline
    cp ~/hrt/hldr/tmux/tmux-powerline-theme.sh ~/hrt/style/tmux-powerline/themes/default.sh

}
################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
