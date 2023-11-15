
function main() {
  _build_file_hierarchy_structure
  _configure_zsh
  _extend_zsh_capabilities
}

function build_file_hierarchy_structure(){
    mkdir $HOME/hrt/ext        # Extensions to zsh like theme, plugins, fonts, auto completes

    mkdir $HOME/hrt/state      # For user-specific apps session data or history, which should be stored for future reuse;
    mkdir $HOME/hrt/states/shell

    mkdir $HOME/hrt/ver        # For taking backup version of config before overwriting

    mkdir $HOME/hrt/vol        # For persistence volume to attach to container
}

function _configure_zsh() {
    # back up existing config and replace with hrt config
    cp ~/.zshrc ~/hrt/ver/.zshrc_$(date +%y%m%d)-old
    rm -f  ~/.zshrc

    # Update ZDOTDIR env to ~/hrt/boot/conf/zsh
    ln -s ~/hrt/boot/conf/zsh/.zshenv ~/.zshenv
}

function _extend_zsh_capabilities() {
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/hrt/ext/zsh-syntax-highlighting

    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  $HOME/hrt/ext/zsh-autosuggestions

    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search  $HOME/hrt/ext/zsh-history-substring-search
}