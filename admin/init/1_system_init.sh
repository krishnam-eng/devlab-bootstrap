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

    # change default shell to zsh
    zsh --version
    sudo chsh -s $(which zsh)

  # ! Log out and log back in to see the change
}

function build_file_hierarchy_structure(){
    mkdir $HOME/hrt/ext        # Extensions to zsh like theme, plugins, fonts, auto completes

    mkdir $HOME/hrt/etc/ctrflags/  # For storing flags to control default behavior with feature toggle

    mkdir $HOME/hrt/state              # For user-specific apps session data or history, which should be stored for future reuse;
    mkdir $HOME/hrt/states/shell

    mkdir $HOME/hrt/ver        # For taking backup version of config before overwriting

    mkdir $HOME/hrt/vol        # For persistence volume to attach to container

    mkdir $HOME/hrt/vault
    mkdir $HOME/hrt/vault/alias          # For storing sensitive alias

    tree -L 3 $HOME/hrt
}

function _configure_zsh() {
    # back up existing config and replace with hrt config
    cp ~/.zshrc ~/hrt/ver/.zshrc_$(date +%y%m%d)-old
    rm -f  ~/.zshrc

    # Update ZDOTDIR env to ~/hrt/boot/conf/zsh
    ln -s ~/hrt/boot/conf/zsh/.zshenv ~/.zshenv
}

function _extend_zsh_capabilities() {
	# order matters
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  $HOME/hrt/ext/zsh-autosuggestions
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search  $HOME/hrt/ext/zsh-history-substring-search
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/hrt/ext/zsh-syntax-highlighting
}

function _sudo_control() {
	sudo ln -s $HOME/hrt/boot/custom/unix/drop-in/sudoers.conf /etc/sudoers.d/hrt-sudoers.conf
}
function _install_dependencies(){
    sudo apt install zsh
    sudo apt install git
    sudo apt install tree
}