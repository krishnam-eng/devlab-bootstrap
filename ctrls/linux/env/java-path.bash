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

# mac /usr/libexec/java_home -v gives the jre path (after big sur update)
# So, set it to jdk for mvn to work
if [ -d /Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/Home ]
then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/Home"
  PATH="${PATH}:${JAVA_HOME}/bin"
fi

# Build tools
if [ -d "$HOME/Paradigm/Development/Libraries/maven" ]
then
  # maven is a link to a specific version of maven .e.g, apache-maven-3.6.3
  # >ln -sfn apache-maven-3.6.3 maven
  export M2_HOME="$HOME/Paradigm/Development/Libraries/maven"
  PATH="${PATH}:${M2_HOME}/bin"
  # export MAVEN_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED"
fi

if [ -d "$HOME/Paradigm/Development/Libraries/gradle-7.1.1" ]
then
  export GRADLE_HOME="$HOME/Paradigm/Development/Libraries/gradle"
  PATH=${PATH}:${GRADLE_HOME}/bin
fi