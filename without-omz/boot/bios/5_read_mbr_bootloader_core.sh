# The BIOS/UEFI reads the initial part of the boot loader (such as the Master Boot Record or EFI System Partition) from the designated boot device.
function main() {
  _read_master_boot_record
}

#  For BIOS-based systems, the MBR is read; for UEFI systems, the GPT is read.
#  The MBR or GPT contains the primary boot loader code, which locates the active partition or EFI system partition.
#       - Master Boot Record (MBR) or GUID Partition Table (GPT):
function _read_master_boot_record() {
        # loads to memory and executes the boot loader
        sh  1_load_bootcode.sh
}