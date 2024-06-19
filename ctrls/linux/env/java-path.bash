#!/usr/bin/env bash
# brew install openjdk@17
# output:
#  ==> openjdk@17
#  For the system Java wrappers to find this JDK, symlink it with
#    sudo ln -sfn /usr/local/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
#
#  openjdk@17 is keg-only, which means it was not symlinked into /usr/local,
#  because this is an alternate version of another formula.
#
#If you need to have openjdk@17 first in your PATH, run:
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

#For compilers to find openjdk@17 you may need to set:
export CPPFLAGS="-I/usr/local/opt/openjdk@17/include"