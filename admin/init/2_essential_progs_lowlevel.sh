function load_essential(){
    # basic tools to start with
    sudo apt install -y vim            # [comes with latest ubuntu - 23.10]
    sudo apt install -y watch        # [comes with latest ubuntu - 23.10]
    sudo apt install -y zip unzip   # [comes with latest ubuntu - 23.10]
    sudo apt install -y xclip          # [comes with latest ubuntu - 23.10] clipboard management
    sudo apt install -y rsync         # [comes with latest ubuntu - 23.10] utility tool for performing swift incremental file transfers

    sudo apt install -y curl            #
    sudo apt install -y jq               # lightweight and flexible command-line JSON processor. It is like sed for JSON data. use it to slice and filter and map and transform structured data
    sudo apt install -y gawk         # GNU awk
    sudo apt install -y rar unrar    # archive utilities - unable to get form main & universe repo

    # better navigation
    sudo apt install -y exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install -y ranger        # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)

    # Needed for building guest addons for virtualbox during vboxadd.service auto start in boot
    sudo apt install -y build-essential  # gcc make perl dkms

    sudo apt update; sudo apt upgrade ; sudo apt autoremove;
}