# Linux like commands for macOS

alias lscpu="sysctl -a | grep machdep.cpu"

alias lsmem="sysctl -a | grep hw.memsize"

alias lsblk="diskutil list"

alias lspci="system_profiler SPPCIDataType"

alias lsusb="system_profiler SPUSBDataType"

alias hcitool="system_profiler SPBluetoothDataType"
