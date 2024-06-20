function install_dev_tools(){
	_programming_languages
	_version_control_systems
	_ides
	_build_tools
	_db_tools
	_test_tools
	_container_management_tools
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

function _setup_java(){
    # Check Existing Versions: list available Java versions
    /usr/libexec/java_home

    # Install Java 17 with Homebrew:
    brew install openjdk@17

    # Get the path of the newly installed Java 17
    /usr/libexec/java_home -v 17

    # Set the default Java path permanently
    echo $JAVA_HOME

    # in .zshrc or .bashrc
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)

    # Verify the Change
    java -version
}

function _setup_python() {
  # Install Python 3.12 with Homebrew:
  brew install python@3.12
  brew link --overwrite python@3.12

  # Set the default Python path permanently (added to default-versions.bash)
  alias python=python3

  # Verify the version
  python --version

  # Package and Environment Management
  curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o Miniconda3/Miniconda3.sh
  bash Miniconda3/Miniconda3.sh -b -u -p Miniconda3
  ln -s $HOME/Paradigm/Development/Tools/Miniconda3/bin/conda $HOME/Paradigm/Development/Tools/bin/conda

  # setup conda configuration
  # ln -s $HOME/Paradigm/Development/tools/conda/.condarc ~/.condarc
  # or
  # export CONDARC=$HOME/Paradigm/Development/Root/tools/conda/.condarc

  # setup package directory for miniconda
  mkdir $HOME/Paradigm/Development/Libraries/miniconda3
  # setup environment.yml for miniconda. It will be used when creating a new environment with conda env create --name myenv command when --file is not given
  ln -s $HOME/Paradigm/Development/Root/tools/conda/environment.yml  $HOME/Paradigm/Development/Tools/Miniconda3/envs/environment.yml

  conda info
  conda --version
  conda list
  conda env list
  conda config --show-sources
  conda config --show
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

funciton _ides() {
  brew install --cask intellij-idea
  brew install --cask visual-studio-code

  brew install --cask lens       # not free for $100m revenue org
  brew install --cask kubernetic # not free

  brew install vim
}

function _build_tools() {
  brew install maven
  brew install gradle
  brew install helm
}

function _database_tools() {
   # ! Approach 1: Needs sudoer access for cask install
   # Approach 2: Install from dmg files with Admin access
   brew install --cask dbeaver-community
   brew install --cask pgadmin4

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
}

function _test_tools() {
   brew install httpie
   npm install -g newman
}

function _cloud_interaction_tools() {
  # ! Fetching dependencies for awscli: python@3.11
  brew install awscli
  brew install hashicorp/tap/terraform
}

function _container_management_tools() {
  brew install --cask rancher

  # Colima: Alternative to Docker/Ranger Desktop
  brew install colima         # Colima initiates with a user specified container runtime on MacOS that defaults to Docker.
  brew install docker         # Docker client is required for Docker runtime
  brew install docker-compose # Docker Compose is a tool for defining and running multi-container Docker applications
  brew install docker-completion # Docker completion is a completion script for Docker CLI

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