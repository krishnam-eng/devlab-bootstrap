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
    #l2
    mkdir ~/hrt/bin        # Essential command binaries that need to be available in single-user mode for dev tools
    mkdir ~/hrt/boot       # HomeLab-Devbox Repo is the dir for local copy of this repo and it boots the hrt. Contains all the files needed for successful booting process.

    mkdir ~/hrt/etc            # Contains system-wide configuration files. backronym - "Editable Text Configuration"
    mkdir ~/hrt/etc/ctrflags/  # change tools (zsh) default behaviours by flags

    mkdir ~/hrt/ext        # Extensions to zsh like theme, plugins, fonts, auto completes
    mkdir ~/hrt/ext/completion

    mkdir ~/hrt/lib        # Libraries essential for the binaries in /bin.

    mkdir ~/hrt/opt        # Contains locally installed software or add-on application software packages
    mkdir ~/hrt/opt/tmux/plugins/tpm

    mkdir ~/hrt/proj       # Personal / Open-Source Projects
    mkdir ~/hrt/proj/github

    mkdir ~/hrt/pvt        # Alias, functions, envs files to be directly sourced in zsh run config, at the same time, they should remain private (not part of boot)
    mkdir ~/hrt/srv        # Server data (data for services provided by system).
    mkdir ~/hrt/ssh        # todo: reuse .ssh and follow naming convention for keys

    mkdir ~/hrt/state      # For user-specific apps session data or history, which should be stored for future reuse;
    mkdir ~/hrt/state/shell
    mkdir ~/hrt/state/tmux
    mkdir ~/hrt/state/tmux/resurrect

    mkdir ~/hrt/ver        # For taking backup version of config before overwriting
    mkdir ~/hrt/vol        # For persistence volume to attach to container

    mkdir ~/hrt/var        # var canonical with complete user access
    mkdir ~/hrt/var/pgsql  # pgdata env base

    mkdir ~/hrt/virtualenvs

    # Check
    tree

    # Others
    mkdir ~/proj      # work proj root dir
}

function configure_mydevbox_with_homelab_source(){

    # Configure: Shell - Bash & Zsh
    # 
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.bashrc ~/hrt/ver/.bashrc_$(date +%y%m%d)-old
    cp ~/.zshenv ~/hrt/ver/.zshenv_$(date +%y%m%d)-old
    cp ~/.zshrc ~/hrt/ver/.zshrc_$(date +%y%m%d)-old

    rm -f  ~/.zshenv ~/.zshrc ~/.bashrc 
    
    ln -s ~/hrt/boot/bash/.bashrc  ~/.bashrc
    ln -s ~/hrt/boot/zsh/.zshenv ~/.zshenv
    # for updating use 'ln -sfn'
    ln -sfn ~/hrt/boot/conf/bash/.bashrc  ~/.bashrc
    ln -sfn ~/hrt/boot/conf/zsh/.zshenv ~/.zshenv

    # Extending zsh
    #
    # Install Font and Configure Font before p10k configuration
    # Update Terminal font from terminal Profile edit
    git clone --depth=1  git@github.com:ryanoasis/nerd-fonts ~/hrt/ext/nerd-fonts #! repo clone takes more than a min (took 4m with ~8Mibs download speed)
    sh ~/hrt/ext/nerd-fonts/install.sh 'JetBrainsMono' # do not give name if you want to install all nerdy fonts

    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ~/hrt/ext/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  ~/hrt/ext/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search  ~/hrt/ext/zsh-history-substring-search

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/hrt/ext/powerlevel10k
    p10k configure
    touch ~/hrt/etc/ctrflags/enablepowertheme # delete this file if you want to switch off the powertheme

    # nano editor
    cp ~/.nanorc ~/.mybkp/.nanorc_$(date +%y%m%d)-old
    rm -f ~/.nanorc
    ln -s ~/hrt/boot/settings/nano/.nanorc  ~/.nanorc # first time
    ln -sfn ~/hrt/boot/settings/nano/.nanorc ~/.nanorc # for update
    sudo ln -s ~/hrt/boot/settings/nano/syntax-highlight/yaml.nanorc /usr/share/nano/yaml.nanorc

    # Configure: Tmux
    #
    # [copy and further customize if you want to be disconnected from repo]
    cp ~/.tmux.conf ~/hrt/ver/.tmux.conf_$(date +%y%m%d)-old > /dev/null
    rm -f ~/.tmux.conf
    ln -s ~/hrt/boot/tmux/.tmux.conf ~/.tmux.conf

    # TMUX plugin manager
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/hrt/opt/tmux/plugins/tpm
    # next: reload tmux conf , and press <prefix> Shift+R to install plugins
    git clone --depth=1 https://github.com/erikw/tmux-powerline.git  ~/hrt/opt/tmux/tmux-powerline
    cp ~/hrt/boot/tmux/tmux-powerline-theme.sh ~/hrt/opt/tmux/tmux-powerline/themes/default.sh

}
################################## END: BOOTSTRAPPING DEV ENV IN NEW BOX ##################################
