#!/usr/bin/env bash
################
# description  : Boot Loader for devbox -  a convention based utility to make the dev related micro automations and configuration for productivity boost.
# author	        : Bala K
################

# Load HomeLab source code into hrt to configure DevBox
function load_boot_source(){
  _upgrade
  _configure_vm_guest_machine
  _install_boot_dependencies

  # Homelab RooT (HRT). ~/hrt will be the heart of the devbox. It contains all the files needed for successful booting process.
  mkdir $USER/hrt
  cd $USER/hrt

  # copy and add key to github ssh keys to access private repo
  ssh-keygen
  cat ~/.ssh/github.pub
  git clone --depth=1 git@github.com:krishnam-eng/homelab-devbox.git ~/hrt/boot
}

function _upgrade() {
  sudo apt update
  sudo apt list --upgradeable # list packages that can be upgraded
  sudo apt upgrade
}

function _install_boot_dependencies(){
    sudo apt install git
    sudo apt install tree
}

function _configure_vm_guest_machine(){
  echo "Install Guest Additions for Better Display & Configure Devices as below"
  echo  " # On Host Machine (VirtualBox VM Top Menu)
                # Devices > Network > Network Settings > Adapter 1 > Attached to: Bridged Adapter
                # Devices > Shared Clipboard > Bidirectional
                # Devices > Drag and Drop > Bidirectional
                # Devices > Insert Guest Additions CD image [insert Guest machine's Virtual Optical Drive]

              # On Guest Machine
                # /media/$USER/VBox_GAs_7.0.12 > RunSoftware
                # "
  echo "Set IconSize=Minimum, MenuBar=RightSide, SoftwareUpdate=DisableProprietaryDownloadSource"
  gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"
}

