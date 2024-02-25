function main() {
    _configure_vm_guest_machine
}

function _configure_vm_guest_machine(){
  echo "[0] SoftwareUpdate=DisableProprietaryDownloadSource, Multiverse"
  echo "-------------------------------------------------------------------------"

  echo "[1] Install Guest Additions for Better Display & Configure Devices as below"
  echo "-------------------------------------------------------------------------"

  echo  " # On Host Machine (VirtualBox VM Top Menu)
                # Devices > Network > Network Settings > Adapter 1 > Attached to: Bridged Adapter
                # Devices > Shared Clipboard > Bidirectional
                # Devices > Drag and Drop > Bidirectional
                # Devices > Insert Guest Additions CD image [insert Guest machine's Virtual Optical Drive]

              # On Guest Machine
                # /media/$USER/VBox_GAs_7.0.12 > RunSoftware
                # "

  echo "[2] Set IconSize=Minimum,   MenuBar=RightSide"
  echo "-------------------------------------------------------------------------"

  echo "[3] Settings > Power > Blank Screen: Never"
  echo "-------------------------------------------------------------------------"

  gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"
}