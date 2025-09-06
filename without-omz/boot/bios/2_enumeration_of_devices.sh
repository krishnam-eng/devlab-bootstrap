# The BIOS/UEFI detects and enumerates connected hardware devices.
# This includes storage devices (hard drives, SSDs), USB controllers, network interfaces, graphics cards, and other peripherals.
function main() {
  lscpu
  lsmem
  lsblk
  lspci
  lsusb
  ifconfig -a

  # network manager command line interface - only Linux
  nmcli device show

  # Darwin
  networksetup -listallhardwareports

  # Set the hostname of the machine to a unique name. Only admins can change the hostname.
  hostname
  vim /etc/hostname
}

