####
# The BIOS/UEFI initiates a series of diagnostic tests known as the Power-On Self-Test (POST).
####

################
# POST (Power-On Self-Test)
#     The purpose of the POST is to ensure that the essential hardware components are in working order before the operating system takes control.
#
#  The POST sequence is as follows:
#            Power-On
#            CPU Checks
#            Memory (RAM) Checks
#            Storage devices Checks
#            Peripheral Checks
################

function main() {
  _perform_cpu_memory_checks
  _perform_storage_checks
  _perform_peripheral_checks
  _configure_vm_guest_machine
}

function _perform_cpu_memory_checks(){
  echo "Perform CPU Checks"
  lscpu
  cat /proc/cpuinfo

  echo "Perform Memory Checks"
  lsmem
  free -h
}

function _perform_storage_checks() {
  echo "Perform Storage Checks"

  # lists block devices, including hard drives and partitions
  lsblk
}

function _perform_peripheral_checks(){
  echo "Perform Peripheral Checks - Network, Internal & External peripherals"

  # lists all network interfaces (if), including Ethernet and Wi-Fi adapters
  ip link
  ifconfig -a # net-tools needs to be installed linux
  networksetup -listallhardwareports # only on mac

  # lists all PCI devices, , including graphics cards and other internal peripherals
  lspci

  # lists all USB devices, including keyboards, mice, and other external peripherals
  lsusb

  # lists all Bluetooth devices, including keyboards, mice, and other external peripherals
  hcitool dev
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

function _dependency_install() {
  sudo apt install net-tools # for ifconfig cmd - interface config
}