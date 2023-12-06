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

	_system_check
	_perform_cpu_memory_checks
	_perform_storage_checks
	_perform_peripheral_checks
}

function _system_check() {
	sudo systemd-analyze blame
	sudo systemd-analyze critical-chain
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
  ip link        #  linux
  ss -t -a     #  linux
  networksetup -listallhardwareports # darwin

  # net-tools needs to be installed - linux & darwin
  ifconfig -a
  netstat -s #  list network statistics for all interfaces
  netstat -l #  list all listening ports
  netstat -t #  list all TCP ports  (default linux cmd > ss -t -a)
  netstat -u #  list all UDP ports
  netstat -r #  list the kernel’s routing table
  arp -a     #  list the kernel’s ARP table - address resolution protocol (ip - mac)
  dig google.com #  list the DNS records for a domain name

  # network manager command line interface - Linux
  nmcli device show
  nmcli connection show
  nmcli connection show --active
  route -n

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