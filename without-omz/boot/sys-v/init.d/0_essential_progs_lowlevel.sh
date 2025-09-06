# default bundled basic tools versions are outdated, so install latest version with brew
function load_essential_darwin_macos(){
    # While macOS does include many essential Unix-like utilities out of the box, this is install additional utilities (default is BSD version)
    # Some utilities commonly found on Linux may not be installed by default on macOS.
    # export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    brew install coreutils

    # macOS already provides this software and installing another version in
    # ! parallel can cause all kinds of trouble. So, it installs keg-only version for some of the software
    brew install vim
    brew install curl

    # Use GNU grep instead of BSD grep to get the more advanced features like Perl-compatible regular expressions
    # TODO: more of the BSD version can be replaced with GNU version
    brew install grep


    # installing because not available in default macos
    brew install watch # execute a program periodically, showing output fullscreen
    brew install xclip # clipboard management

    brew info jq
    brew install jq  # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data

    # should have better navigation
    # ! exa has been disabled because it is not maintained upstream! Use `lsd` instead.
    brew install lsd                # The next gen ls command: Clone of ls with colorful output, file type icons, and more
    brew install vivid              # A LS_COLORS generator with a rich interactive user interface
    brew install ranger             # File browser with VI key bindings
}

function load_essential_ubuntu(){
    # basic tools to start with
    sudo apt install -y vim            # [comes with latest ubuntu - 23.10]
    sudo apt install -y watch        # [comes with latest ubuntu - 23.10]
    sudo apt install -y zip unzip   # [comes with latest ubuntu - 23.10]
    sudo apt install -y xclip          # [comes with latest ubuntu - 23.10] clipboard management
    sudo apt install -y rsync         # [comes with latest ubuntu - 23.10] utility tool for performing swift incremental file transfers
    sudo apt install -y curl            # [comes with latest ubuntu - 23.10]

    # must have
    sudo apt install -y jq               # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data

    # should have better navigation
    sudo apt install -y exa           # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install -y ranger      # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)

    # nice to have
    sudo apt install -y gawk         # GNU awk
    sudo apt install -y rar unrar    # archive utilities - unable to get form main & universe repo

    # Needed for building guest addons for virtualbox during vboxadd.service auto start in boot
    sudo apt install -y build-essential  # gcc make perl dkms

    sudo apt update; sudo apt upgrade ; sudo apt autoremove;
}
