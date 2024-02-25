# Unix
First three key elements of the Unix operating system—assembler, editor, and shell—developed by Ken Thompson in August 1969 at AT&T Bell Labs

## Unix Shells
Provides a command-line interface for Unix-like operating systems.

70s
* sh (Bourne Shell) - late 1970s
  * Default for Solaris OS 
* csh (C Shell) - late 1970s
  * Interactivity, including aliases and a command history, arithmetic and a C-like syntax

80s
* ksh (Korn Shell) - 1983
  * Notably faster than C Shell
* bash (Bourne Again Shell) - **1989**
  * Incorporates features from both Korn and C Shell.
  * Arrow key functionality, as the arrow keys are mapped to command history recall and editing

**POSIX - Portable Operating System Interface** 1988 
* standards specified by the IEEE for maintaining compatibility between operating systems. 

90s
* zsh (Z Shell) - 1990
  * default shell of Kali Linux and Mac OS 
  * modern-day shell born as an extension to the Bourne Shell
  * customizable and extensible
* dash (Debian Almquist Shell) - late 90s

10s
* fish (Friendly Interactive Shell) - mid-200s (2005)
  * developer-oriented, simple user experience directly out-of-box
  * syntax highlighting, autosuggestions, and tab completion
  * non-POSIX compliance. However, the developers aim to improve flawed designs from POSIX shells

Fun fact: 
* [1] MacOS is based on BSD, which is a Unix-like OS and POSIX-compliant OS. Linux is not 100% POSIX-compliant.


## Analogy of the boot process
```agsl
Kernel (Kernel Space) + Shell (User Space)

Power On (core) => BIOS / UEFI
    Boot loader => GRUB2
        Initd => systemd
            service => units
```
