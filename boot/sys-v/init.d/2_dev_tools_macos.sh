function load_dev_tools(){
	_programming_languages
	_version_control_systems
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