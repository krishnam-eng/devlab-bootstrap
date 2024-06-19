# like systemd or initd starting point
function main() {
	_install_dependencies

	# File hierarchy
	_build_file_hierarchy_structure

	# Shell configuration
	_make_zsh_default_shell
	_configure_zsh
	_extend_zsh_capabilities

	# Unix kernel commands configuration
	_sudo_control
}

function _make_zsh_default_shell() {
    # current default shell
    echo $SHELL

    # list available shells
    cat /etc/shells

    # change default shell to zsh. Do it without sudo as it is user-specific
    zsh --version
    chsh -s $(which zsh)

  # ! Log out and log back in to see the change
}

function build_file_hierarchy_structure(){
    cd /Users/${USER}/Paradigm/Development/
    mkdir Extensions        # Extensions to zsh like theme, plugins, fonts, auto completes
    mkdir Flags             # For storing flags to control default behavior with feature toggle
    mkdir Version           # For taking backup version of config before overwriting
    mkdir Volume            # For persistence volume to attach to container
    mkdir Vault              # For storing sensitive alias
    mkdir States            # For user-specific apps session data or history, which should be stored for future reuse;

    mkdir States/shell
    mkdir -p /Users/${USER}/Paradigm/Development/Vault/alias
    touch /Users/${USER}/Paradigm/Development/Vault/alias/base.zsh  # For storing sensitive alias

    tree -L 3 /Users/${USER}/Paradigm/Development

	# Unclutter: remove default folders created by Ubuntu at $HOME
	cd $HOME
    \rm -rf -d Music Pictures Public Templates Videos
}

function _configure_zsh() {
    # back up existing config and replace with hrt config
    cp ~/.zshrc $HOME/Paradigm/Development/Version/.zshrc_$(date +%y%m%d)-old # Possible devout: No such file or directory
    rm -f  ~/.zshrc
    rm -f ~/.zshenv

    # Update ZDOTDIR env to /Users/${USER}/Paradigm/Development/Root/conf/zsh
    ln -s /Users/${USER}/Paradigm/Development/Root/conf/zsh/.zshenv ~/.zshenv
}
function _extend_zsh_capabilities() {
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  $HOME/Paradigm/Development/Extensions/zsh-autosuggestions
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search  $HOME/Paradigm/Development/Extensions/zsh-history-substring-search
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/Paradigm/Development/Extensions/zsh-syntax-highlighting

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/Paradigm/Development/Extensions/powerlevel10k

  touch $HOME/Paradigm/Development/etc/ctrflags/enablepowertheme # enable custom flag for sourcing p10k
  touch $HOME/Paradigm/Development/States/.zhistfile
  lzsh           # reload zsh run config
  p10k configure # install the suggested nerd font to get icons in prompt header line
}

function _sudo_control() {
	ln -s $HOME/Paradigm/Development/boot/ctrls/linux/etc/sudoer.d/timeout.conf /etc/sudoers.d/timout  # '.' in the file name is not allowed
	chown root:root /etc/sudoers.d/timout
}
function _install_dependencies(){
    # it comes with ubuntu 22.04
    # it comes with mac os
    sudo apt install -y zsh
}