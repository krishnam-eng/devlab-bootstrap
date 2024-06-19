function install_dev_tools(){
	_programming_languages
	_version_control_systems
	_build_tools
	_db_tools
	_test_tools
	_container_management_tools # TODO
	_cloud_interaction_tools
	# todo: auto completion setup for all CLI tools
}

function _programming_languages(){
  _setup_java
  _setup_python
  _setup_nodejs
  _setup_golang
  _setup_groovy
}

function _version_control_systems() {
  brew install git
  brew install gh                # GitHub CLI
  brew install --cask github     # GitHub Desktop
  brew install --cask sourcetree # SourceTree GUI

  # Verify the version
  git --version
  gh --version
  sourcetree --version
}

function _build_tools() {
  brew install maven
  brew install gradle
  brew install helm
}

function _db_tools() {
   # ! Approach 1: Needs sudoer access for cask install
   # Approach 2: Install from dmg files with Admin access
   brew install --cask dbeaver-community
   brew install --cask pgadmin4
}

function _test_tools() {
   brew install httpie
}

function _cloud_interaction_tools() {
  # ! Fetching dependencies for awscli: python@3.11
  brew install awscli
  brew install hashicorp/tap/terraform
}

function _container_management_tools() {
  # Colima: Alternative to Docker/Ranger Desktop
  brew install colima         # Colima initiates with a user specified container runtime on MacOS that defaults to Docker.
  brew install docker         # Docker client is required for Docker runtime
  brew install docker-compose

  brew install minikube       # Minikube is a tool that makes it easy to run Kubernetes locally
  brew install kubectl        # Kubectl is a command line tool for controlling Kubernetes clusters
  brew install k9s            # k9s is a terminal-based UI to interact with your Kubernetes clusters
  brew install krew           # Krew is the package manager for kubectl plugins

  # TODO: Explore them later - not installed as essential bundle
  brew install kind           # kind is a tool for running local Kubernetes clusters using Docker container “nodes”
  brew install tilt           # Tilt is a tool for local Kubernetes development with no stress
  brew install telepresence   # Telepresence is a tool to enable local development against a remote Kubernetes cluster
  brew install kustomize      # Kustomize is a standalone tool to customize Kubernetes objects through a kustomization file
  brew install kompose        # Kompose is a tool to help users familiar with docker-compose move to Kubernetes
  brew install skaffold       # Skaffold is a command line tool that facilitates continuous development for Kubernetes applications
  brew install duffle         # Duffle is a CLI tool to build, publish, and run Cloud-Native Application Bundles (CNAB)
  brew install pack           # Pack CLI is a tool for building apps using Cloud Native Buildpacks
  brew install podman         # Podman is a daemonless container engine for developing, managing, and running OCI Containers
  brew install podman-compose # Podman Compose is a script to run a group of containers
}

function _setup_python() {
  # Install Python 3.12 with Homebrew:
  brew install python@3.12
  brew link --overwrite python@3.12

  # Set the default Python path permanently (added to default-versions.bash)
  alias python=python3

  # Verify the version
  python --version
}

function _setup_nodejs() {
    # download and install Node.js
    brew install node@22
    # verifies the right Node.js version is in the environment
    node -v # should print `v22.3.0`
    # verifies the right NPM version is in the environment
    npm -v # should print `10.8.1`

    # https://nodejs.org/en/download/package-manager/
}

function _setup_golang() {
    # download and install Go
    brew install go
    # verifies the right Go version is in the environment
    go version # should print >= `go version go1.22.4 darwin/amd64`

    # https://golang.org/doc/install
}

function _setup_groovy(){
    # download and install Groovy
    brew install groovy
    # verifies the right Groovy version is in the environment
    groovy -version # should print `Groovy Version: 3.0.9 JVM: 11.0.12 Vendor: Oracle Corporation OS: Mac OS X`

    # https://groovy-lang.org/install.html
}

function _setup_java(){
    # Check Existing Versions: list available Java versions
    /usr/libexec/java_home

    # Install Java 17 with Homebrew:
    brew install openjdk@17

    # Get the path of the newly installed Java 17
    /usr/libexec/java_home -v 17

	  # TODO: not recognized by java home cmd
    # Set the default Java path permanently
    echo $JAVA_HOME

    # in .zshrc or .bashrc
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)

    # Verify the Change
    java -version
}


#!/usr/bin/env bash

# NOTE: check the mkdevenv-base.sh script first and come back here

function install_core_packages(){

     brew install telnet          # Telnet is an old network protocol that is used to connect to remote systems over a TCP/IP network.  data sent over the protocol is unencrypted.

    # Others
    brew install tnftp      # FTP client

    # have a little fun
     brew install cowsay            # An ASCII cow in terminal that will say what ever you want
     brew install figlet            # utility for creating ASCII text banners or large letters out of ordinary text
     brew install cmatrix           # shows a scrolling ‘Matrix‘ like screen in a Linux terminal [Not in venv setup]
     brew install lolcat            # rainbow view of the cat
}

function install_infra_tools(){
    # Docker - Made it easy to use the Linux Container
    # Install Docker Desktop (preferable over package install and manual configuration)
    # https://docs.docker.com/desktop/mac/install/

    # K8S - Like a Operating System for Data-Center
    brew install minikube

    # Package manager for kubectl plugins
    brew install krew
    kubectl krew ctx
    kubectl krew ns
    kubectl krew view-allocations
    kubectl krew config-cleanup
    kubectl krew whoami
}

function install_db_dev_tools {
 # Install MySQL: Server, Shell, Workbench
 https://dev.mysql.com/downloads/mysql/
 https://dev.mysql.com/downloads/shell/
 https://dev.mysql.com/downloads/workbench/

 # Install PostgreSQL
 https://postgresapp.com/
 https://postgresapp.com/downloads.html
 https://www.postgresql.org/ftp/pgadmin/pgadmin4/v6.3/macos/
 # Configure your $PATH & PGDATA - check env/dev.sh
 initdb # to initialize a data directory
 psql --version
 psql # default db name is $USER

 # NOTE: Choose the right CPU - arm64 or x86_64

}
# For testers and developers responsible for API testing, Postman is a popular and free solution
# Postman says: Automated API testing is far superior to automated UI testing
function setup_postman_api_testenv(){
    # Install newman in global mode (it installs as a global package)
    npm install -g newman
    newman --version

    # Run collection tests
    newman run ${collection_name}.json -e ${env_name}

    # For Desktop, download postman (not the agent) app from https://www.postman.com/downloads/
    # Unzip and move it to $User-Home/Applications dir
}