#!/usr/bin/env bash

if [ -d "/Library/Frameworks/Python.framework/Versions/3.10/bin" ] ;
then
  PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.10/bin"
fi

# python install from brew
# python@3.10 is keg-only, which means it was not symlinked into /usr/local,
# because this is an alternate version of another formula.
# If you need to have python@3.10 first in your PATH, run:
export PATH="/usr/local/opt/python@3.10/bin:$PATH"

# For compilers to find python@3.10 you may need to set:
export LDFLAGS="-L/usr/local/opt/python@3.10/lib"

# For pkg-config to find python@3.10 you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/python@3.10/lib/pkgconfig"

# Build tools
if [ -d "$HOME/hrt/lib/maven" ]
then
  # maven is a link to a specific version of maven .e.g, apache-maven-3.6.3 
  # >ln -sfn apache-maven-3.6.3 maven
  export M2_HOME="$HOME/hrt/lib/maven"
  PATH="${M2_HOME}/bin:${PATH}"
  # export MAVEN_OPTS="--add-opens java.base/java.lang=ALL-UNNAMED"
fi

if [ -d "$HOME/hrt/lib/gradle-7.1.1" ]
then
  export GRADLE_HOME="~/hrt/lib/gradle"
  PATH=${GRADLE_HOME}/bin:${PATH}
fi

# package manager for kubectl plugins
if [ -d "${HOME}/.krew/" ]
then
  PATH="${PATH}:${HOME}/.krew/bin"
fi

# mac /usr/libexec/java_home -v gives the jre path (after big sur update)
# So, set it to jdk for mvn to work
if [ -d /Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home ]
then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home"
  PATH="${JAVA_HOME}/bin:${PATH}"
fi

# IDE Path
if [ -d "$HOME/hrt/vscode/bin" ]
then
  PATH="$PATH:$HOME/hrt/vscode/bin"
fi

if [ -d "$HOME/hrt/ide/idea-2021/bin" ]
then
  PATH="$PATH:$HOME/hrt/ide/idea-2021/bin"
fi

if [ -d "$HOME/hrt/node/bin" ]
then
  PATH="$PATH:$HOME/hrt/node/bin"
fi

# use development mode as default for python flask project development
export FLASK_ENV=development

# keeping the default value for now
export FLASK_APP=app.py

# ES 1.7 expects ES JAVA HOME
export ES_JAVA_HOME=$JAVA_HOME
export ES_HOME=$HOME/hrt/server/elasticsearch-7.15.2

# MySQL - to access mysqladmin from cli
if [ -d "/usr/local/mysql/bin" ]
then
  PATH="$PATH:/usr/local/mysql/bin"
fi

# Postgres - to access psql form cli
if [ -d "/Applications/Postgres.app/Contents/Versions/latest/bin" ]
then
  PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
  export PGDATA=~/hrt/var/pgsql/data
fi