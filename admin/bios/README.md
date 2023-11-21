# High-level Overview of the BIOS/UEFI Initialization Process

## Power-On or Reset:

When the computer is powered on or restarted, the CPU starts executing instructions from a predefined memory location.

## Power-On Self-Test (POST):

The BIOS/UEFI initiates a Power-On Self-Test (POST) to check the integrity of various hardware components, including the CPU, memory (RAM), storage devices, and peripheral devices.
If the POST detects any issues, it may display error messages or emit beep codes to indicate the problem.

## BIOS/UEFI Identification:

The firmware identifies itself and provides basic information about its version, capabilities, and supported features.
On older systems, this is typically the BIOS. On modern systems, it might be UEFI.

##  Initialization of System Timer and Interrupts:

The firmware initializes the system timer and interrupt controllers, which are crucial for managing time and responding to hardware events.

## Enumeration of Devices:

The BIOS/UEFI detects and enumerates connected hardware devices. This includes storage devices (hard drives, SSDs), USB controllers, network interfaces, graphics cards, and other peripherals.

## Configuration of System Resources:

The firmware configures system resources such as memory addresses, IRQs (Interrupt Requests), and I/O port addresses for each hardware component.
This step involves setting up the system's memory map and initializing the memory controller.

## Boot Device Selection:

The BIOS/UEFI determines the boot order, which specifies the sequence in which it searches for a bootable operating system.
The user or system administrator can configure the boot order in the BIOS/UEFI settings.
The BIOS/UEFI selects the primary boot device (usually the hard drive or SSD) from which the operating system will be loaded.

## Loading the Boot Loader:

The BIOS/UEFI reads the initial part of the boot loader (such as the Master Boot Record or EFI System Partition) from the designated boot device.
This boot loader is responsible for loading the operating system's kernel into memory.

## Handover to the Boot Loader:

* Control is handed over to the boot loader, which continues the boot process.
* For UEFI systems, this handover process is more standardized and involves loading the EFI executable (such as bootx64.efi) from the EFI System Partition.

## Operating System Initialization:

* The boot loader loads the operating system's kernel into memory.
* The kernel takes control and initializes the rest of the operating system.