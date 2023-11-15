# The BIOS/UEFI detects and enumerates connected hardware devices.
# This includes storage devices (hard drives, SSDs), USB controllers, network interfaces, graphics cards, and other peripherals.
function main() {
  lscpu
  lsmem
  lsblk
  lspci
  lsusb
  ifconfig -a
}
