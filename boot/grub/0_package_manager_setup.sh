# Load HomeLab source code into hrt to configure DevBox
function main(){

  if [ "$(uname)" = "Darwin" ]; then
    _setup_for_darwin_macos
    _verify_homebrew_installation
  fi
}

function _setup_for_darwin_macos{
  # Verify if the user can sudo for installing homebrew
  sudo -v

  # if the user can not sudo, then switch to the user who can
  if [ $? -ne 0 ]; then
    echo "User does not have sudo access. Switching to the user who can."
    su - itadmin

    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # You won’t need Xcode to use Homebrew, but some of the software and components you’ll want to install will rely on Xcode’s Command Line Tools package
    xcode-select --install

    # After installing homebrew, we need to change the owner of /usr/local/* to the user who needs to use homebrew
    # It is required to use homebrew without sudo access
    # Note that chown: /usr/local: Operation not permitted in darwin.
    # As a workaround, changing only for subdirectories and files under /usr/local/*
    sudo chown -R $(homebrew_user) /usr/local/* /User/$(homebrew_user)/Library/Caches/Homebrew/

    # Come back to the original user who needs to use homebrew by logging out from itadmin user session
    exit
  fi

  # cask is an extension to homebrew that allows management of graphical applications through the Cask project
  brew install cask
}

function _verify_homebrew_installation(){
  # show the version of homebrew
  brew --version

  # Verify if homebrew is installed correctly
  brew doctor

  # Update homebrew
  brew update

  # Upgrade all installed packages
  brew upgrade

  # Remove old versions of installed packages
  brew cleanup

  # List all installed packages
  brew list

  # List all installed services
  brew services list

  # List all installed taps
  brew tap

  # Search for a package
  brew search

  # Show the info of a package
  brew info wget

  brew help
}
