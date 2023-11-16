function load_essential(){
    # basic tools to start with
    sudo apt install vim             # [default in version > ubuntu]
    sudo apt install watch         # [default in version > ubuntu]
    sudo apt install curl             #
    sudo apt install gawk          # GNU awk
    sudo apt install rar unrar     # archive utilities - unable to get form main & universe repo
    sudo apt install zip unzip     # [default in version > ubuntu]
    sudo apt install xclip            # [default in version > ubuntu] clipboard management
    sudo apt install rsync          # [default in version > ubuntu] utility tool for performing swift incremental file transfers

    # better navigation
    sudo apt install exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install ranger          # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)

    sudo apt update; sudo apt upgrade ; sudo apt autoremove
}