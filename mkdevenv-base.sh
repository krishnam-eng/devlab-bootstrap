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
    mkdir ~/hrt/bin        #
    mkdir ~/hrt/boot       # HomeLab-Devbox Repo is the dir for local copy of this repo and it boots the hrt.
    mkdir ~/hrt/lib
    mkdir ~/hrt/opt
    mkdir ~/hrt/etc

    mkdir ~/hrt/history
    mkdir ~/hrt/etc/ctrflags/  # change tools (zsh) default behaviours by flags

    mkdir ~/hrt/var
    mkdir ~/hrt/plugins
    mkdir ~/hrt/proj
    mkdir ~/hrt/private
    mkdir ~/hrt/resurrect
    mkdir ~/hrt/virtualenvs

    #l3
    mkdir ~/hrt/opt/fonts
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
    # * boot: intend is to make the config root name fixed irrespective of the github repo name. config root name will be refered in many micro automation
    git clone --depth=1 https://github.com/krishnam-eng/homelab-devbox ~/hrt/boot
    git remote -v
    git remote set-url origin git@github.com:krishnam-eng/homelab-devbox.git

    # Configure: Shell - Bash & Zsh
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.bashrc ~/bkp/.bashrc_$(date +%y%m%d)-old
    cp ~/.zshenv ~/bkp/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/bkp/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc 
    
    ln -s ~/hrt/boot/bash/.bashrc  ~/.bashrc
    ln -s ~/hrt/boot/zsh/.zshenv ~/.zshenv
    

    # zsh style - theme & font to boost dev productivity
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/hrt/opt/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  ~/hrt/opt/zsh-autosuggestions
    
    # Font to support more nerdy icons
    git clone --depth=1  git@github.com:ryanoasis/nerd-fonts ~/hrt/opt/nerd-fonts
    sh ~/hrt/opt/nerd-fonts/install.sh 'JetBrainsMono'

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/hrt/opt/powerlevel10k
    p10k configure
    touch ~/hrt/etc/ctrflags/enablepowertheme
    # reboot

    # nano editor
    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    rm -f ~/.nanorc
    ln -s ~/hrt/boot/nano/.nanorc  ~/.nanorc
    sudo ln -s ~/hrt/boot/nano/syntax-highlight/yaml.nanorc /usr/share/nano/yaml.nanorc

    # Configure: Tmux
    #
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.tmux.conf ~/.mybkp/.tmux.conf_$(date +%y%m%d)-old
    rm -f ~/.tmux.conf ~/.nanorc
    ln -s ~/hrt/boot/tmux/.tmux.conf ~/.tmux.conf

    # TMUX plugin manager
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/hrt/plugins/tmux/tpm
    # next: reload tmux conf , and press <prefix> Shift+R to install plugins
    git clone --depth=1 https://github.com/erikw/tmux-powerline.git  ~/hrt/opt/tmux-powerline
    cp ~/hrt/boot/tmux/tmux-powerline-theme.sh ~/hrt/opt/tmux-powerline/themes/default.sh

}
################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
