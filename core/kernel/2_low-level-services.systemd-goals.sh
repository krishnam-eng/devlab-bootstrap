# Essential
function install_core_packages{
    # basic tools to start with
    sudo apt install vim             # open-source clone of vi text editor developed to be customizable and able to work with any type of text
    sudo apt install watch         #
    sudo apt install curl             #
    sudo apt install gawk          # GNU awk
    sudo apt install rar unrar    # archive utilities
    sudo apt install zip unzip    # [default in version > ubuntu21.04]
    sudo apt install xclip           # [default in version > ubuntu21.04] clipboard management
    sudo apt install rsync           # [default in version > ubuntu21.04] utility tool for performing swift incremental file transfers
    sudo apt install guake           # drop down terminal emulator - # ! use x (x11 or xarg) display server since keybinding doesn't work well in wyaland server
    # todo: Keymapping for F12 needs to be resolved manually for the below step
    # sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/

    # system utilities
    sudo apt install exa             # more user-friendly version of ls [Not in venv setup - error: RHEL8 version `GLIBC_2.18 not found]
    sudo apt install ranger          # console file manager with vi key bindings (npm error: Not compatible with your version of node/npm)
    sudo apt install fd-find         # fdfind: a program to find entries in your filesytem. It is a simple, fast and user-friendly alternative to find
    sudo apt install ncdu            # NCurses Disk Usage: to view and analyse disk space usage. It can drill down into directories and report space used by individual directories.
    sudo apt install htop            # interactive process viewer similar to top but that provides a nicer user experience out of the box
    sudo pip install glances         # system monitoring tool
    sudo apt install ctop            # top-like interface for container metrics
    sudo apt install sysstat         # iostat - cpu usage
    sudo apt install bridge-utils    # brctr - ethernet brdige admin cmd
}