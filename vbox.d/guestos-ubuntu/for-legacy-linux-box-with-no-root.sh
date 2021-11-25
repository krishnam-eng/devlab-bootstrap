################################## START: ON DEMAND OR OPTIONAL SETUP #####################################
#### What Do I Already Have
function whatdoihave(){
    python3 --version
    virtualenv --version

    zsh --version
    tmux -V
    nano -V
    vim --version

    git --version
    kdiff3 -version

    curl --version
    tree --version
    gawk --version
    xclip -version
    rsync --version
    jq --version
    zip --version

    htop --version
    glances --version

    iostat -V
}

function on_demand_dev_env{
    # On-Demand Tools
    sudo apt install ruby            # need for ruby gems
    sudo apt install lm-sensors      # [optional] cpu temp (unable to use it in vbox)
    sudo apt install kdiff3          # [optional] compares and merges two or three input files or directories      
    sudo apt install fish            # [optional] firendly interactive shell - using it for default shell in guack
    ln -s ~/hrt/boot/fish/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
    sudo apt install gnome-tweaks    # [optional] useful to change capslock key binding    
    sudo npm install -g tldr         # TooLongDidntRead: tldr pages are a community effort to simplify the beloved man pages with practical examples
    
}

function on_old_machine{
    #git clone --depth=1 https://github.com/bhilburn/powerlevel9k.git ~/hrt/opt/powerlevel9k
    #cp ~/hrt/boot/zsh/powerlevel9k.zsh-theme ~/hrt/opt/powerlevel9k/  # fix for old zsh compatability issue
}

# install using venv if you are not the admin
function install_in_virtual_env(){

    python --version
    virtualenv --version

    virtualenv --python=python3 hrt
    cd hrt/
    source bin/activate

    pip install virtualenvwrapper

    # to redo
    pip freeze | xargs pip uninstall -y

    # lets use the power of node package manager
    install_node()
    node --version

    whatdoihave() # if anything throws cmd not found, install that too
    npm install -g fd-find
    npm install -g ncdu
    npm install -g cowsay
    npm install -g figlet-cli
    npm install -g lolcat
    npm install -g tar
    npm install -g untar

    # Other installs
    install_vscode()
    wget https://services.gradle.org/distributions/gradle-7.1.1-bin.zip
    unzip gradle-7.0.2-bin.zip
    export GRADLE_HOME=~/hrt/lib/gradle-7.1.1
    export PATH=${GRADLE_HOME}/bin:${PATH}
}

function install_node(){
    cd ~/hrt
    # download from https://nodejs.org/en/
    wget https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-x64.tar.xz
    tar -xf node-v14.17.0-linux-x64.tar.xz
    mv node-v14.17.0-linux-x64 node
    rm node-v14.17.0-linux-x64.tar.xz
    # make sure this is added to path via rc file
    PATH="$HOME/hrt/node/bin:$PATH"
    #todo: ~/.npmrc setup
}

function install_ides(){
    cd ~/hrt
    
    #### VS Code
    # download from firefox https://code.visualstudio.com/download
    tar -xvf code-stable-x64-1620838810.tar.gz
    mv VSCode-linux-x64 vscode
    rm code-stable-x64-1620838810.tar.gz
    # make sure this is added to path via rc file
    PATH="$HOME/hrt/vscode/bin:$PATH"

    cp ~olxrp/vscode/*.json ~/.config/Code/User
    
    #### IDEA 
    mkdir -p ~/hrt/ide
    wget https://download.jetbrains.com/idea/ideaIC-2021.1.3.tar.gz
    tar -xf ideaIC-2021.1.3.tar.gz
    mv ideaIC-2021.1.3 idea-2021
    
}

function install_rust(){
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/env
}

function install_pipx(){
    # pipx setup (https://pipxproject.github.io/pipx/)
    # pip install pipx
    # now use pipx to install needed tools for effective dev env
    # mkdir ~/hrt/local/bin
    # mkdir ~/hrt/local/pipx
    # export PIPX_BIN_DIR=~/hrt/local/bin
    # export PIPX_HOME=~/hrt/local/pipx
    # pipx install lolcat # install anything which will trigger shared libraries creation
    # watch -d -n 5 "du -ckh /u/krishnam/hrt/local/pipx/"
    # ERROR: maximum recursion depth exceeded while calling a Python object
}
################################## END: ON DEMAND OR OPTIONAL SETUP #####################################
