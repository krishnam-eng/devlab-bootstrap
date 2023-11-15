####
# The BIOS/UEFI (Basic Input/Output System or the Unified Extensible Firmware Interface)
#         initiates a series of diagnostic tests known as the Power-On Self-Test (POST).
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
  _upgrade_system
  _install_dependencies

  _perform_cpu_memory_checks
  _perform_storage_checks
  _perform_peripheral_checks
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

function _install_dependencies(){
  sudo apt install net-tools # for ifconfig cmd - interface config
}

function _upgrade_system() {
  sudo apt update
  sudo apt list --upgradeable # list packages that can be upgraded
  sudo apt upgrade
}