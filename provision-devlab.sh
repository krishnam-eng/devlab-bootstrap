#!/bin/zsh

################################################################################
# Portable Replicatable Scalable Developer Laboratory Setup for macOS
# 
# Author: Balamurugan Krishnamoorthy
# Documentation: See PROVISION-DEVLAB.md for complete details
#
# Quick Start:
#   ./provision-devlab.sh                 # Interactive setup
#   ./provision-devlab.sh --yes           # Automated setup
#   ./provision-devlab.sh --status        # Check current status
#   ./provision-devlab.sh --help          # Show usage options
################################################################################

# Global variables
SKIP_CASK_APPS=false
SKIP_ITERM_SETUP=false
AUTO_YES=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }
log_step() { printf "${CYAN}[STEP]${NC} %s\n" "$1"; }

################################################################################
# Main execution flow
function main() {
    log_info "Starting Developer Environment Setup for macOS..."
    echo ""

    # Prerequisites: Essential setup steps
    confirm_and_run_step "Setup Second Brain Directory Root with HRT Repository (Prerequisites)" setup_prerequisites
    confirm_and_run_step "Install Homebrew (Prerequisite)" install_macos_package_manager
    
    # Main setup steps (7 steps)
    confirm_and_run_step "Setup Developer Laboratory Directory Structure" setup_dir_struct_hierarchy
    confirm_and_run_step "Setup Zsh Environment" setup_zsh_environment
    confirm_and_run_step "Install Essential CLI Tools" install_essential_cli_tools
    confirm_and_run_step "Install Development Tools" install_development_tools
    confirm_and_run_step "Install Programming Languages" install_programming_languages
    confirm_and_run_step "Install IDEs and Editors" install_ides_and_editors
    confirm_and_run_step "Setup AI Development Environment" setup_agentic_ai_development
}

function confirm_and_run_step() {
    local step_description="$1"
    local step_function="$2"

    if [[ "$AUTO_YES" == "true" ]]; then
        log_info "Auto-running: $step_description"
        REPLY="y"
    else
        echo "Proceed with $step_description? [y/N]: "
        read -r REPLY
    fi
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $step_function
        log_success "$step_description completed successfully."
    else
        log_info "$step_description skipped."
    fi
}

################################################################################
# Prerequisites: Setup Second Brain Directory Root with HRT Repository
################################################################################
function setup_prerequisites() {
    log_step "🏗️ Setting up prerequisites (Second Brain directory & HRT repository)..."
    
    # Prompt user for second brain directory name
    local sbrn_name="sbrn"
    if [[ "$AUTO_YES" != "true" ]]; then
        echo "Enter your Second Brain directory name [default: sbrn]: "
        read -r user_input
        if [[ -n "$user_input" ]]; then
            sbrn_name="$user_input"
        fi
    fi
    
    # Set SBRN_HOME based on user input
    export SBRN_HOME="$HOME/$sbrn_name"
    log_info "Second Brain directory set to: $SBRN_HOME"
    
    # Create the base Second Brain directory
    mkdir -p "$SBRN_HOME"
    
    # Create essential sys directory structure
    mkdir -p "$SBRN_HOME/sys"
    
    # Clone the HRT (Home Runtime Tools) repository if it doesn't exist
    if [[ ! -d "$SBRN_HOME/sys/hrt" ]]; then
        log_info "Cloning HRT repository to $SBRN_HOME/sys/hrt..."
        git clone --depth=1 https://github.com/krishnam-eng/sbrn-sys-hrt.git "$SBRN_HOME/sys/hrt"
        log_success "HRT repository cloned successfully"
    else
        log_success "HRT repository already exists at $SBRN_HOME/sys/hrt"
    fi
    
    log_success "Prerequisites setup completed"
}


function install_macos_package_manager() {
    log_step "🍺 Installing Homebrew package manager..."
    
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_info "Homebrew PATH configuration is managed by HRT .zprofile"
    else
        log_success "Homebrew already installed"
    fi
    brew update
    log_success "Homebrew setup completed"
}

#################################################################################
# Step 1: Setup Developer Laboratory Directory Structure
#################################################################################
function setup_dir_struct_hierarchy() {
    log_step "📁 Setting up SBRN (Second Brain) directory structure..."

    # Hide standard user folders to reduce clutter before creating SBRN structure
    chflags hidden ~/Movies
    chflags hidden ~/Music
    chflags hidden ~/Desktop
    chflags hidden ~/Public
    chflags hidden ~/Pictures
    chflags hidden ~/Library

    # Create primary PARA directories under sbrn home for Projects, Areas, Resources, Archives
    mkdir -p "$SBRN_HOME"
    mkdir -p "$SBRN_HOME/proj"/{corp,oss,learn,lab,exp}
    mkdir -p "$SBRN_HOME/area"/{work,personal,community,academic}
    mkdir -p "$SBRN_HOME/rsrc"/{notes,templates,refs}
    mkdir -p "$SBRN_HOME/arch"/{proj,area}

    # Create Cloud Drives directories for mounting cloud storage
    mkdir -p "$HOME/Drives"
    mkdir -p "$HOME/Drives"/{iCloud,GoogleDrive,OneDrive,Dropbox}
    log_info "Please manually mount your cloud drives (iCloud, Google Drive, OneDrive, Dropbox) under $HOME/Drives"

    # Setup XDG Base Directory Specification environment variables
    export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
    export XDG_DATA_HOME="$SBRN_HOME/sys/local/share"
    export XDG_STATE_HOME="$SBRN_HOME/sys/local/state"
    export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"
    
    # Create XDG-compliant directories
    mkdir -p "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"
    
    # Create FSH config structure under SBRN_HOME/sys
    mkdir -p "$SBRN_HOME/sys"/{bin,etc}
 
   log_success "SBRN directory structure setup completed"
}

################################################################################
# Step 2: Setup Zsh Environment
################################################################################
function setup_zsh_environment() {
    log_step "🐚 Setting up Zsh environment with Oh My Zsh..."
    
    # Set Zsh configuration directory (must be set before Oh My Zsh installation)
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    
    # Create XDG-compliant directories for Zsh files
    create_zsh_xdg_directories
    
    # Install Oh My Zsh to custom directory
    install_oh_my_zsh
    
    # Install Powerlevel10k theme
    install_powerlevel10k_theme
    
    # Install essential plugins
    install_zsh_plugins
    
    # Install Meslo Nerd Font
    install_meslo_font
    
    # Setup Zsh configuration symlinks from HRT if available
    setup_zsh_configuration_links
    
    log_success "Zsh environment setup completed"
}

function create_zsh_xdg_directories() {
    log_info "Creating XDG-compliant directories for Zsh files..."
    mkdir -p "$XDG_STATE_HOME/zsh/sessions"
    mkdir -p "$XDG_CACHE_HOME/zsh"
    log_success "Created Zsh XDG directories (state, cache, sessions)"
}

function install_oh_my_zsh() {
    local zsh_dir="$SBRN_HOME/sys/etc/oh-my-zsh"
    
    if [[ ! -d "$zsh_dir" ]]; then
        export ZSH="$zsh_dir"
        log_info "Installing Oh My Zsh to $zsh_dir..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed successfully"

        # Restore original .zshrc file from Oh My Zsh backup
        log_info "Restoring original .zshrc configuration..."
        cp "$XDG_CONFIG_HOME/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc.oh-my-zsh-generated"
        cp "$XDG_CONFIG_HOME/zsh/.zshrc.pre-oh-my-zsh" "$XDG_CONFIG_HOME/zsh/.zshrc"
        log_success "Original .zshrc configuration restored (Oh My Zsh version backed up as .zshrc.oh-my-zsh-generated)"
        
    else
        log_success "Oh My Zsh already installed"
        export ZSH="$zsh_dir"
    fi
}

function install_powerlevel10k_theme() {
    local p10k_dir="${ZSH}/custom/themes/powerlevel10k"
    
    if [[ ! -d "$p10k_dir" ]]; then
        log_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
        ln -sfn "$SBRN_HOME/sys/hrt/conf/p10k" "$XDG_CONFIG_HOME/p10k"
        log_success "Powerlevel10k theme installed"
    else
        log_success "Powerlevel10k already installed"
    fi
}

function install_zsh_plugins() {
    log_info "Installing essential Zsh plugins that are not part of Oh My Zsh repo..."

    local custom_dir="${ZSH}/custom"
    
    # zsh-autosuggestions
    if [[ ! -d "$custom_dir/plugins/zsh-autosuggestions" ]]; then
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$custom_dir/plugins/zsh-autosuggestions"
        log_success "Autosuggestions plugin installed"
    else
        log_success "Autosuggestions plugin already installed"  
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$custom_dir/plugins/zsh-syntax-highlighting" ]]; then
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting"
        log_success "Syntax highlighting plugin installed"
    else
        log_success "Syntax highlighting plugin already installed"
    fi
    
    # history-substring-search
    if [[ ! -d "$custom_dir/plugins/history-substring-search" ]]; then
        git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git "$custom_dir/plugins/history-substring-search"
        log_success "History substring search plugin installed"
    else
        log_success "History substring search plugin already installed"
    fi
    
    # zsh-autoswitch-virtualenv
    if [[ ! -d "$custom_dir/plugins/zsh-autoswitch-virtualenv" ]]; then
        git clone --depth=1 https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git "$custom_dir/plugins/zsh-autoswitch-virtualenv"
        log_success "Autoswitch virtualenv plugin installed"
    else
        log_success "Autoswitch virtualenv plugin already installed"
    fi

    log_success "Zsh plugins installed"
}

function install_meslo_font() {
    log_info "Installing Meslo Nerd Font..."
    
    local font_dir="$HOME/Library/Fonts"
    local temp_dir="/tmp/meslo-font"
    
    if [[ ! -f "$font_dir/MesloLGS NF Regular.ttf" ]]; then
        mkdir -p "$temp_dir"
        cd "$temp_dir"
        curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
        unzip -q Meslo.zip
        cp *.ttf "$font_dir/"
        cd - > /dev/null
        rm -rf "$temp_dir"
        log_success "Meslo Nerd Font installed"
    else
        log_success "Meslo Nerd Font already installed"
    fi
}

function setup_zsh_configuration_links() {
    log_info "Setting up Zsh configuration links from HRT..."
    
    # Symlink .zshenv
    ln -sfn "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ~/.zshenv
    log_success "Linked .zshenv configuration"

    # Symlink zsh configuration directory
    ln -sfn "$SBRN_HOME/sys/hrt/conf/zsh" "$XDG_CONFIG_HOME/zsh"
    log_success "Linked Zsh configuration directory"
}

################################################################################
# Step 3: Install Essential CLI Tools
################################################################################
function install_essential_cli_tools() {
    log_step "🛠️ Installing essential CLI tools..."
    
    # Shell Enhancements & CLI Productivity
    install_shell_productivity_tools
    
    # Networking, Security, & Transfer Tools
    install_networking_security_tools
    
    # Text, Regex, JSON, Data Tools
    install_text_data_tools
    
    log_success "Essential CLI tools installation completed"
}

function install_shell_productivity_tools() {
    log_info "Installing shell enhancement & productivity tools..."
    
    local shell_tools=(
        "coreutils" "tree" "fzf" "tmux" "screen" "htop" "bat" "fd" "tldr" 
        "eza" "zoxide" "watch" "ncdu" "glances" "lsd" "ctop" "autoenv" 
        "atuin" "direnv" "ack" "broot" "figlet" "lolcat" "ranger" 
        "as-tree" "agedu" "zsh-autosuggestions" "zsh-completions" 
        "bash-completion" "fish" "starship"
    )
    
    for tool in "${shell_tools[@]}"; do
        brew_install "$tool"
    done
}


function install_networking_security_tools() {
    log_info "Installing Networking, Security, & Transfer tools..."
    
    local network_tools=(
        "curl" "wget" "httpie" "netcat" "gnupg" "certbot" "telnet"
    )
    
    for tool in "${network_tools[@]}"; do
        brew_install "$tool"
    done
}

function install_text_data_tools() {
    log_info "Installing text, regex, JSON, data tools..."
    
    local text_tools=(
        "vim" "neovim" "emacs" "nano" "jq" "ripgrep" "grep" 
        "fx" "jid" "colordiff" "base64" "base91" "python-yq" "ccat"
    )
    
    for tool in "${text_tools[@]}"; do
        brew_install "$tool"
    done

    # Create ripgrep config directory and link configuration
    ln -sfn "$SBRN_HOME/sys/hrt/conf/ripgrep" "$XDG_CONFIG_HOME/ripgrep"
}

################################################################################
# Step 4: Install Development Tools
################################################################################
function install_development_tools() {
    log_step "🔧 Installing general development tools..."
    
    # Developer Tools (VCS, Repos, Git Helpers)
    install_vcs_tools
    
    # Cloud & Containers
    install_cloud_container_tools
    
    # Graphics, OCR, and UI Libraries
    install_graphics_ocr_libraries

    # Additional Development & API tools
    install_additional_dev_tools

    # Configure Git to use diff-so-fancy
    if command -v diff-so-fancy &>/dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" 2>/dev/null || true
    fi
        
    log_success "Development tools installation completed"
}

function install_vcs_tools() {
    log_info "Installing VCS tools..."
    
    local git_tools=(
        "git" "git-extras" "git-lfs" "gh" "ghq" "diff-so-fancy" 
        "delta" "tig" "lazygit" "git-gui" "gitk" "gibo"
    )
    
    for tool in "${git_tools[@]}"; do
        brew_install "$tool"
    done

    ln -sfn "$SBRN_HOME/sys/hrt/conf/git" "$XDG_CONFIG_HOME/git"
}

function install_cloud_container_tools() {
    log_info "Installing cloud & containers tools..."
    
    local cloud_tools=(
        "docker" "docker-compose" "colima" "kubernetes-cli" "helm" 
        "awscli" "dive" "dockviz" "k9s" "kubecolor" "kompose" "krew" 
        "kube-ps1" "kubebuilder" "kustomize" "istioctl" "minikube" 
        "terraform" "pulumi" "railway" "vercel-cli"
    )
    
    for tool in "${cloud_tools[@]}"; do
        brew_install "$tool"
    done
}

function install_graphics_ocr_libraries() {
    log_info "Installing graphics, images, and UI libraries..."
    
    local graphics_tools=(
        "librsvg" "gtk+3" "ghostscript" "graphviz" "guile" 
        "pcre" "xerces-c" "pygobject3"
    )
    
    for tool in "${graphics_tools[@]}"; do
        brew_install "$tool"
    done
}

function install_additional_dev_tools() {
    log_info "Installing additional development & API tools..."
    
    local dev_tools=(
        "jwt-cli" "newman" "openapi-generator" "operator-sdk" "hugo" 
        "logrotate" "rtmpdump" "sftpgo" "etcd" "postgresql@15" 
        "redis" "nginx"
    )
    
    for tool in "${dev_tools[@]}"; do
        brew_install "$tool"
    done
}

################################################################################
# Step 5: Install Core Programming Languages & Runtimes
################################################################################
function install_programming_languages() {
    log_step "Installing core programming languages, runtime environment managers, and build tools..."

    # Core Programming Languages & Runtimes
    install_core_programming_languages
    
    # Runtime Environment Managers
    install_runtime_environment_managers
    
    # Build Automation Tools
    install_build_automation_tools
    
    log_success "Programming languages, runtime environment managers, and build tools installation completed"
}

function install_core_programming_languages() {
    log_info "Installing core programming languages and runtimes..."
    
    local languages=(
        "openjdk@17" "openjdk@21" "python@3.13" "perl" 
        "node" "go" "rust"
    )
    
    for lang in "${languages[@]}"; do
        brew_install "$lang"
    done
}

function install_runtime_environment_managers() {
    log_info "Installing runtime environment managers..."
    
    local runtime_managers=(
        "jenv" "uv" "nvm" "pipx"
    )
    
    for rm in "${runtime_managers[@]}"; do
        brew_install "$rm"
    done
    
    # Configure runtime environment managers
    configure_jenv
    configure_uv
    configure_nvm
    configure_pipx
    create_ml_dev_environment
}

function configure_jenv() {
    log_info "Configuring jenv with Java versions (XDG-compliant)..."
    
    # Currently, jenv does not natively support using the XDG Base Directory Specification
    # Move existing jenv configuration to XDG config directory if it exists
    [[ -d ~/.jenv ]] && [[ ! -L ~/.jenv ]] && [[ ! -d "$XDG_CONFIG_HOME/jenv" ]] && {
        mkdir -p "$XDG_CONFIG_HOME"
        mv ~/.jenv "$XDG_CONFIG_HOME/jenv"
        ln -s "$XDG_CONFIG_HOME/jenv" ~/.jenv
        log_success "Moved jenv configuration to XDG-compliant location"
    }
    
    # Set jenv to use XDG data directory
    export JENV_ROOT="$XDG_DATA_HOME/jenv"
    mkdir -p "$JENV_ROOT"
    
    # Initialize jenv with XDG path
    eval "$(jenv init -)"
    
    # Enable essential plugins
    jenv enable-plugin export 2>/dev/null || true
    jenv enable-plugin maven 2>/dev/null || true
    jenv enable-plugin gradle 2>/dev/null || true
    
    # Add Java versions if they exist
    for java_version in 17 21; do
        local java_path="/opt/homebrew/opt/openjdk@${java_version}"
        [[ ! -d "$java_path" ]] && java_path="/usr/local/opt/openjdk@${java_version}"
        
        if [[ -d "$java_path" ]] && ! jenv versions | grep -q "$java_version"; then
            jenv add "$java_path" 2>/dev/null && log_success "Added Java $java_version to jenv"
        fi
    done
    jenv global 21 2>/dev/null && log_success "Set global Java version to 21"

    # Application-specific XDG compliance directories
    export ANDROID_HOME="$XDG_DATA_HOME/android"
    export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
    mkdir -p "$ANDROID_HOME" "$GRADLE_USER_HOME"
    
    log_success "jenv configured with XDG-compliant path: $JENV_ROOT"
}

function configure_nvm() {
    log_info "Configuring NVM (Node Version Manager)..."
    
    # Set NVM_DIR to XDG-compliant location
    export NVM_DIR="$XDG_DATA_HOME/nvm"
    mkdir -p "$NVM_DIR"
    
    # Source NVM from Homebrew installation
    source "/opt/homebrew/opt/nvm/nvm.sh"
    log_success "NVM loaded from Homebrew installation"
    
    # Install latest LTS Node.js if no versions are installed
    if ! nvm list | grep -q "v"; then
        log_info "Installing latest LTS Node.js version..."
        nvm install --lts
        nvm use --lts
        nvm alias default lts/*
        log_success "Installed and set latest LTS Node.js as default"
    else
        log_success "Node.js versions already installed via NVM"
    fi
}

function configure_uv() {
    log_info "Configuring uv with XDG compliance for modern Python package management..."

    # Set uv configuration to use XDG-compliant locations
    export UV_CONFIG_FILE="$XDG_CONFIG_HOME/uv/uv.toml"
    export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
    export UV_TOOL_DIR="$XDG_DATA_HOME/uv/tools"
    export UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/bin"
    export UV_PYTHON_INSTALL_DIR="$XDG_DATA_HOME/uv/python"
    
    # Create XDG-compliant directories for uv
    mkdir -p "$UV_CACHE_DIR"
    mkdir -p "$XDG_DATA_HOME/uv"/{tools,bin,python}
    
    # Link uv configuration directory from HRT repository
    if [[ -d "$SBRN_HOME/sys/hrt/conf/uv" ]]; then
        ln -sfn "$SBRN_HOME/sys/hrt/conf/uv" "$XDG_CONFIG_HOME/uv"
        log_success "Linked uv configuration directory from HRT: $XDG_CONFIG_HOME/uv"
    else
        log_warning "HRT uv configuration directory not found, using default uv settings"
        mkdir -p "$XDG_CONFIG_HOME/uv"
    fi
    
    # Add uv tool bin directory to PATH for current session
    if [[ ":$PATH:" != *":$UV_TOOL_BIN_DIR:"* ]]; then
        export PATH="$UV_TOOL_BIN_DIR:$PATH"
        log_success "Added uv tool bin directory to current PATH: $UV_TOOL_BIN_DIR"
    else
        log_success "uv tool bin directory already in PATH"
    fi
    
    # Install a modern Python version if not available
    if command -v uv &>/dev/null; then
        log_info "Installing Python 3.12 via uv for optimal AI/ML compatibility..."
        uv python install 3.12 2>/dev/null || log_warning "Python 3.12 installation skipped (may already exist)"
        log_success "uv Python management configured"
    fi
    
    log_success "uv configured with XDG-compliant directories:"
    echo "   • UV_CONFIG_FILE: $UV_CONFIG_FILE (linked from HRT)"
    echo "   • UV_CACHE_DIR: $UV_CACHE_DIR"
    echo "   • UV_TOOL_DIR: $UV_TOOL_DIR"
    echo "   • UV_TOOL_BIN_DIR: $UV_TOOL_BIN_DIR (added to PATH)"
    echo "   • UV_PYTHON_INSTALL_DIR: $UV_PYTHON_INSTALL_DIR"
    echo "   • Configuration: Managed via HRT repository"
}

function configure_pipx() {
    log_info "Configuring pipx to use XDG Base Directory Specification..."
    
    # Set XDG-compliant environment variables for pipx
    export PIPX_HOME="$XDG_DATA_HOME/pipx"
    export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
    export PIPX_MAN_DIR="$XDG_DATA_HOME/pipx/man"
    export PIPX_SHARED_LIBS="$XDG_DATA_HOME/pipx/pyvenv"
    export PIPX_LOCAL_VENVS="$XDG_DATA_HOME/pipx/venvs"
    export PIPX_LOG_DIR="$XDG_STATE_HOME/pipx/logs"
    export PIPX_CACHE_DIR="$XDG_CACHE_HOME/pipx"
    
    # Create XDG-compliant directories
    local pipx_dirs=(
        "$PIPX_HOME"
        "$PIPX_BIN_DIR" 
        "$PIPX_MAN_DIR"
        "$PIPX_SHARED_LIBS"
        "$PIPX_LOCAL_VENVS"
        "$PIPX_LOG_DIR"
        "$PIPX_CACHE_DIR"
    )
    
    for dir in "${pipx_dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    # Add pipx bin directory to PATH for current session
    if [[ ":$PATH:" != *":$PIPX_BIN_DIR:"* ]]; then
        export PATH="$PIPX_BIN_DIR:$PATH"
        log_success "Added XDG pipx bin directory to current PATH: $PIPX_BIN_DIR"
    else
        log_success "pipx XDG bin directory already in PATH"
    fi
    
    log_success "pipx configured with XDG-compliant directories:"
    echo "   • PIPX_HOME: $PIPX_HOME"
    echo "   • PIPX_BIN_DIR: $PIPX_BIN_DIR (added to PATH)"
    echo "   • PIPX_CACHE_DIR: $PIPX_CACHE_DIR"
    echo "   • PIPX_LOG_DIR: $PIPX_LOG_DIR"
    echo "   • Configuration: Defined in HRT .zshenv for persistence across sessions"
}

function create_ml_dev_environment() {
    log_info "Creating ML development environment using uv..."
    
    if ! command -v uv &>/dev/null; then
        log_warning "uv not available - skipping ML environment creation"
        return 1
    fi
    
    # Create ml-dev project with uv in XDG location
    local env_name="ml-dev"
    local project_path="$XDG_DATA_HOME/python-projects/$env_name"
    
    if [[ ! -d "$project_path" ]]; then
        log_info "Creating ML development project: $env_name in XDG location using uv"
        
        # Create project directory
        mkdir -p "$project_path"
        cd "$project_path"
        
        # Initialize uv project with Python 3.12
        if ! uv init --python 3.12 .; then
            log_warning "Failed to create uv ML project - continuing without ML environment"
            cd - > /dev/null
            return 1
        fi
        
        # Copy pyproject.toml template from HRT configuration
        log_info "Setting up ML development environment with essential packages..."
        local ml_template="$SBRN_HOME/sys/hrt/conf/uv/ml-dev-pyproject.toml"
        
        if [[ -f "$ml_template" ]]; then
            cp "$ml_template" pyproject.toml
            log_success "Using ML development pyproject.toml template from HRT"
        else
            log_error "ML template not found at $ml_template"
            log_error "Please ensure HRT repository is properly cloned and templates exist"
            return 1
        fi
        
        # Install all dependencies
        log_info "Installing ML development packages via uv..."
        if uv sync; then
            log_success "ML development dependencies installed successfully"
        else
            log_warning "Some ML packages may have failed to install - check uv output"
        fi
        
        # Register Jupyter kernel with XDG-compliant paths
        export JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"
        mkdir -p "$JUPYTER_DATA_DIR"
        
        # Install kernel using uv run
        log_info "Registering Jupyter kernel for ml-dev environment..."
        uv run python -m ipykernel install --user --name="$env_name" --display-name="Python (ML-Dev-UV)"
        
        log_success "ML development environment '$env_name' created in XDG-compliant location: $project_path"
        log_info "Activate with: cd $project_path && uv shell"
        log_info "Run Jupyter: cd $project_path && uv run jupyter lab"
        log_info "Jupyter kernel 'Python (ML-Dev-UV)' is now available in JupyterLab"
        
        # Return to original directory
        cd - > /dev/null
        
    else
        log_success "ML development environment '$env_name' already exists in XDG location"
        
        # Check if dependencies are up to date
        cd "$project_path"
        if uv sync --dry-run &>/dev/null; then
            log_success "All ML dependencies are up to date"
        else
            log_info "Some dependencies may need updating - run: cd $project_path && uv sync"
        fi
        cd - > /dev/null
    fi
}

function install_build_automation_tools() {
    log_info "Installing build automation tools..."
    
    local build_tools=("maven" "gradle" "poetry" "yarn")
    
    for tool in "${build_tools[@]}"; do
        brew_install "$tool"
    done
}

################################################################################
# Step 6: Install IDEs and Editors
################################################################################
function install_ides_and_editors() {
    log_step "📝 Installing IDEs and editors..."
    
    # Development Environment for Data Science and Notebooks
    install_python_notebook_env_tools

    # Core IDEs and Editors
    install_core_ides_editors
    
    # Productivity and Development Support Apps
    install_productivity_apps
    
    # Create symbolic links for command-line access
    create_app_cli_symlinks
    
    log_success "IDEs and editors installation completed"
}

function install_core_ides_editors() {
    log_info "Installing core IDEs and editors..."
    
    local ides=(
        "visual-studio-code" "intellij-idea-ce" "pycharm-ce" "cursor" "iterm2"
    )
    
    for ide in "${ides[@]}"; do
        brew_cask_install "$ide"
    done

    # Link VSCode settings from HRT configuration if available
    mkdir -p "$SBRN_HOME/sys/config/code/user"
    ln -sfn $SBRN_HOME/sys/hrt/conf/vscode/settings.json $SBRN_HOME/sys/config/code/user/settings.json
    ln -sfn "${XDG_CONFIG_HOME:-$HOME/.config}/code/user" "$HOME/Library/Application Support/Code/User"
    
    setup_vscode_extensions
    setup_iterm_profiles
}

function install_productivity_apps() {
    log_info "Installing productivity and development support applications..."
    
    local productivity_apps=(
        "notion" "obsidian" "figma" "slack" "github" "postman" 
        "insomnia" "dbeaver-community" "pgadmin4" "rapidapi"
    )
    
    for app in "${productivity_apps[@]}"; do
        brew_cask_install "$app"
    done
}

function install_python_notebook_env_tools() {
    log_info "Installing development environment and data science tools..."
    
    # Note: pipx installation and XDG configuration is handled in configure_pipx()
    # Verify pipx is available for Jupyter installation
    if ! command -v pipx &>/dev/null; then
        log_warning "pipx not yet available - it should be configured in runtime environment managers step"
        return 1
    fi
    
    log_info "Installing Jupyter ecosystem using pipx..."
    
    # Install core Jupyter applications via pipx (these are standalone applications)
    local jupyter_apps=(
        "jupyterlab"
        "notebook"
    )
    
    for app in "${jupyter_apps[@]}"; do
        if ! pipx list | grep -q "^$app "; then
            log_info "Installing $app via pipx..."
            pipx install "$app" 2>/dev/null || {
                log_warning "Failed to install $app via pipx, trying pip with virtual environment..."
                # Fallback: create a temporary virtual environment
                local temp_venv="/tmp/jupyter_install_$$"
                python3 -m venv "$temp_venv"
                source "$temp_venv/bin/activate"
                pip install "$app"
                deactivate
                rm -rf "$temp_venv"
            }
        else
            log_success "$app already installed via pipx"
        fi
    done
}

function create_app_cli_symlinks() {
    # Skip CLI symlinks creation if cask apps are disabled
    if [[ "$SKIP_CASK_APPS" == "true" ]]; then
        log_info "Skipping application CLI symlinks setup (SKIP_CASK_APPS=true)"
        return 0
    fi
    
    log_info "Creating symbolic links for Application command-line access..."

        local bin_dir="$SBRN_HOME/sys/bin"


        # App symlink definitions: (relative app dir, cli_name, actual_executable)
        typeset -A app_symlinks
        app_symlinks=(
            "Visual Studio Code.app" "code:Contents/Resources/app/bin/code"
            "IntelliJ IDEA.app" "idea-ultimate:Contents/MacOS/idea"
            "IntelliJ IDEA CE.app" "idea:Contents/MacOS/idea"
            "PyCharm.app" "pycharm:Contents/MacOS/pycharm"
            "Cursor.app" "cursor:Contents/MacOS/Cursor"
            "DBeaver.app" "dbeaver:Contents/MacOS/dbeaver"
            "DevToys.app" "devtoys:Contents/MacOS/DevToys"
            "LM Studio.app" "lmstudio:Contents/MacOS/LM Studio"
            "Figma.app" "figma:Contents/MacOS/Figma"
            "Framer.app" "framer:Contents/MacOS/Framer"
            "Obsidian.app" "obsidian:Contents/MacOS/Obsidian"
            "Notion.app" "notion:Contents/MacOS/Notion"
            "GitHub Desktop.app" "github:Contents/MacOS/GitHub Desktop"
            "Insomnia.app" "insomnia:Contents/MacOS/Insomnia"
            "Postman.app" "postman:Contents/MacOS/Postman"
            "Rancher Desktop.app" "rancher:Contents/MacOS/Rancher Desktop"
            "RapidAPI.app" "rapidapi:Contents/MacOS/RapidAPI"
            "Slack.app" "slack:Contents/MacOS/Slack"
            "VirtualBox.app" "vbox:Contents/MacOS/VirtualBoxVM"
            "pgAdmin 4.app" "pgadmin:Contents/MacOS/pgAdmin 4"
            "zoom.us.app" "zoom:Contents/MacOS/zoom.us"
        )

        # Check both /Applications and $HOME/Applications
        for app_dir in "${(@k)app_symlinks}"; do
            local cli_def="${app_symlinks[$app_dir]}"
            local cli_name="${cli_def%%:*}"
            local exec_rel_path="${cli_def#*:}"
            local found_app_path=""
            for base_dir in "/Applications" "$HOME/Applications"; do
                local app_path="$base_dir/$app_dir"
                local exec_path="$app_path/$exec_rel_path"
                if [[ -d "$app_path" ]] && [[ -f "$exec_path" ]]; then
                    found_app_path="$exec_path"
                    break
                fi
            done
            if [[ -n "$found_app_path" ]] && [[ ! -L "$bin_dir/$cli_name" ]]; then
                ln -sf "$found_app_path" "$bin_dir/$cli_name"
                log_success "Created symlink for $cli_name ($found_app_path)"
            fi
        done

        # Add bin directory to PATH if not already there
        if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
            echo "export PATH=\"$bin_dir:\$PATH\"" >> ~/.zshrc
            export PATH="$bin_dir:$PATH"
            log_success "Added $bin_dir to PATH"
        fi
}

################################################################################
# Step 7: Setup Agentic AI Development Environment
################################################################################
function setup_agentic_ai_development() {
    log_step "🤖 Setting up Agentic AI Development Environment..."
    
    # AI/ML Core Tools & Frameworks
    install_ai_development_tools
    
    # AI Agent Development Frameworks
    install_ai_agent_frameworks
    
    # Local LLM Capabilities
    setup_local_llm
    
    # Modern AI-Enhanced IDEs
    install_modern_ai_ides
    
    # Vector Databases & Search
    install_vector_databases
    
    # Modern Productivity & Automation Tools
    install_modern_productivity_tools
    
    # AI-Enhanced VS Code Extensions
    setup_ai_vscode_extensions
    
    log_success "Agentic AI Development Environment setup completed"
}


function install_ai_development_tools() {
    log_info "Installing AI/ML Core Tools & Frameworks..."
    
    mkdir -p "$XDG_CONFIG_HOME/ai-tools" "$XDG_DATA_HOME/ai-tools" "$XDG_CACHE_HOME/ai-tools" "$XDG_STATE_HOME/ai-tools"
    
    # Note: pipx configuration is handled in configure_pipx()
    
    local ai_tools=(
        "ollama" "huggingface-cli" "duckdb" "datasette" 
        "sqlite-utils" "uv" "pyenv"
    )
    
    for tool in "${ai_tools[@]}"; do
        brew_install "$tool"
    done
    
    install_special_ai_tools
}

function install_special_ai_tools() {
    log_info "Installing additional AI tools that require special handling..."
    
    # Install mlflow via pipx
    if ! command -v "mlflow" &>/dev/null; then
        pipx install mlflow || log_warning "Failed to install mlflow via pipx"
        export MLFLOW_TRACKING_URI="file://$XDG_DATA_HOME/mlflow"
        mkdir -p "$XDG_DATA_HOME/mlflow"
    fi
    
    # Create symlinks for AI tool configurations from HRT to XDG locations
    local config_dirs=("ollama" "jupyter" "uv" "vector-databases" "ai-tools")
    
    for config_dir in "${config_dirs[@]}"; do
        local hrt_conf_dir="$SBRN_HOME/sys/hrt/conf/$config_dir"
        local xdg_conf_link="$XDG_CONFIG_HOME/$config_dir"
        
        if [[ -d "$hrt_conf_dir" ]]; then
            [[ -e "$xdg_conf_link" ]] && rm -rf "$xdg_conf_link"
            ln -sfn "$hrt_conf_dir" "$xdg_conf_link"
        fi
    done
    
    # Create necessary XDG directories for AI tools data and cache
    local xdg_dirs=(
        "$XDG_CACHE_HOME"/{huggingface,torch,langchain,wandb,pip,uv}
        "$XDG_DATA_HOME"/{mlflow,jupyter,ollama/models,duckdb,chromadb,wandb,tensorboard,pyenv}
        "$XDG_DATA_HOME/vector-databases"/{chromadb,qdrant,weaviate}
    )
    
    for dir in "${xdg_dirs[@]}"; do
        mkdir -p "$dir"
    done
}


function install_ai_agent_frameworks() {
    log_info "Installing 🤖 AI Agent Development Frameworks via uv environments..."
    
    if ! command -v uv &>/dev/null; then
        log_warning "uv not available - skipping AI agent frameworks installation"
        log_info "Install uv first to use this feature"
        return 1
    fi
    
    # Create agentic-ai project with uv in XDG location
    local env_name="agentic-ai"
    local project_path="$XDG_DATA_HOME/python-projects/$env_name"
    
    if [[ ! -d "$project_path" ]]; then
        log_info "Creating agentic AI project: $env_name in XDG location using uv"
        
        # Create project directory
        mkdir -p "$project_path"
        cd "$project_path"
        
        # Initialize uv project with Python 3.12
        if ! uv init --python 3.12 .; then
            log_error "Failed to create uv project."
            log_error "Please ensure uv is properly installed:"
            log_error "  uv init --python 3.12 \"$project_path\""
            return 1
        fi
        
        # Create a comprehensive pyproject.toml for AI agent development
        log_info "Setting up comprehensive AI agent development environment..."
        
        local agentic_template="$SBRN_HOME/sys/hrt/conf/uv/agentic-ai-pyproject.toml"
        if [[ -f "$agentic_template" ]]; then
            cp "$agentic_template" pyproject.toml
            log_success "Using agentic AI pyproject.toml template from HRT"
        else
            log_error "Agentic AI template not found at $agentic_template"
            log_error "Please ensure HRT repository is properly cloned and templates exist"
            return 1
        fi
        
        # Install all dependencies
        log_info "Installing AI agent frameworks and tools via uv..."
        if uv sync; then
            log_success "All AI agent dependencies installed successfully"
        else
            log_warning "Some packages may have failed to install - check uv output"
        fi
        
        # Create a simple example script
        mkdir -p examples
        local simple_agent_template="$SBRN_HOME/sys/hrt/conf/uv/simple_agent.py"
        if [[ -f "$simple_agent_template" ]]; then
            cp "$simple_agent_template" examples/simple_agent.py
            log_success "Using simple agent example from HRT template"
        else
            log_warning "Simple agent template not found, creating minimal placeholder"
            echo '#!/usr/bin/env python3' > examples/simple_agent.py
            echo '"""Simple AI Agent Example - Template missing, please check HRT repository"""' >> examples/simple_agent.py
            echo 'print("Please update this file with actual agent code")' >> examples/simple_agent.py
        fi
        
        # Make example executable
        chmod +x examples/simple_agent.py
        
        # Register Jupyter kernel with XDG-compliant paths
        export JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"
        mkdir -p "$JUPYTER_DATA_DIR"
        
        # Install kernel using uv run
        log_info "Registering Jupyter kernel for agentic-ai environment..."
        uv run python -m ipykernel install --user --name="$env_name" --display-name="Python (Agentic-AI-UV)"
        
        log_success "Agentic AI environment '$env_name' created in XDG-compliant location: $project_path"
        log_info "Activate with: cd $project_path && uv shell"
        log_info "Run Jupyter: cd $project_path && uv run jupyter lab"
        log_info "Example script: cd $project_path && uv run python examples/simple_agent.py"
        log_info "Jupyter kernel 'Python (Agentic-AI-UV)' is now available in JupyterLab"
        
        # Return to original directory
        cd - > /dev/null
        
    else
        log_success "Agentic AI environment '$env_name' already exists in XDG location"
        
        # Check if dependencies are up to date
        cd "$project_path"
        if uv sync --dry-run &>/dev/null; then
            log_success "All dependencies are up to date"
        else
            log_info "Some dependencies may need updating - run: cd $project_path && uv sync"
        fi
        cd - > /dev/null
    fi
}

function setup_local_llm() {
    log_info "Setting up 🧠 Local LLM Capabilities with XDG compliance..."
    
    # Set XDG-compliant paths for Ollama
    export OLLAMA_MODELS="$XDG_DATA_HOME/ollama/models"
    mkdir -p "$OLLAMA_MODELS"
    
    # Install Ollama for local LLM hosting
    if ! command -v ollama &>/dev/null; then
        log_info "Installing Ollama for local LLM deployment..."
        brew_install "ollama" "Local LLM deployment and management platform"
        
        # Start ollama service
        if command -v ollama &>/dev/null; then
            log_info "Starting Ollama service with XDG-compliant model storage..."
            
            # Create Ollama configuration file
            local ollama_config="$XDG_CONFIG_HOME/ollama/config.yaml"
            mkdir -p "$(dirname "$ollama_config")"
            cat > "$ollama_config" << EOF
# Ollama XDG-compliant configuration
models_path: "$OLLAMA_MODELS"
host: "127.0.0.1:11434"
origins: ["http://localhost", "http://127.0.0.1", "https://localhost", "https://127.0.0.1"]
EOF
            
            # Set environment variable for Ollama configuration
            export OLLAMA_HOST="127.0.0.1:11434"
            
            ollama serve &
            sleep 3  # Give service time to start
            
            # Download useful models for development
            log_info "Downloading essential LLM models to XDG location: $OLLAMA_MODELS"
            local models=(
                "llama3.2:3b"
                "codellama:7b"
                "mistral:7b"
                "phi3:mini"
            )
            
            for model in "${models[@]}"; do
                log_info "Downloading model: $model"
                OLLAMA_MODELS="$OLLAMA_MODELS" ollama pull "$model" || log_warning "Failed to download $model - continuing..."
            done
            
            log_success "Ollama configured with essential models in XDG location: $OLLAMA_MODELS"
        fi
    else
        log_success "Ollama already installed"
        
        # Ensure XDG configuration
        if [[ ! -f "$XDG_CONFIG_HOME/ollama/config.yaml" ]]; then
            mkdir -p "$XDG_CONFIG_HOME/ollama"
            cat > "$XDG_CONFIG_HOME/ollama/config.yaml" << EOF
# Ollama XDG-compliant configuration
models_path: "$OLLAMA_MODELS"
host: "127.0.0.1:11434"
origins: ["http://localhost", "http://127.0.0.1", "https://localhost", "https://127.0.0.1"]
EOF
            log_success "Created XDG-compliant Ollama configuration"
        fi
    fi
    
    # Install llamafile for single-file LLM deployment
    if ! command -v llamafile &>/dev/null; then
        log_info "Installing llamafile for portable LLM deployment..."
        # Download the actual llamafile binary
        local llamafile_url="https://github.com/Mozilla-Ocho/llamafile/releases/download/0.8.13/llamafile-0.8.13"
        local llamafile_path="$SBRN_HOME/sys/bin/llamafile"
        
        # Create bin directory if it doesn't exist
        mkdir -p "$(dirname "$llamafile_path")"
        
        if curl -L -o "$llamafile_path" "$llamafile_url"; then
            chmod +x "$llamafile_path"
            
            # Create XDG-compliant llamafile directory
            mkdir -p "$XDG_DATA_HOME/llamafile/models"
            mkdir -p "$XDG_CONFIG_HOME/llamafile"
            
            log_success "llamafile installed to $llamafile_path with XDG data dir: $XDG_DATA_HOME/llamafile"
        else
            log_warning "Failed to download llamafile - continuing..."
        fi
    else
        log_success "llamafile already installed"
    fi
}

function install_modern_ai_ides() {
    log_info "Installing 🚀 Modern AI-Enhanced IDEs..."
    
    local ai_ides=(
        "cursor: AI-native code editor with advanced AI features"
        "windsurf: AI-native IDE from Codeium with collaborative AI"
        "zed: High-performance collaborative code editor with AI"
        "continue: Open-source AI code assistant"
    )
    
    for ide_info in "${ai_ides[@]}"; do
        local ide="${ide_info%%:*}"
        local description="${ide_info#*:}"
        
        case "$ide" in
            "windsurf")
                # Windsurf might not be available via brew, provide manual installation info
                if [[ ! -d "/Applications/Windsurf.app" ]] && [[ ! -d "$HOME/Applications/Windsurf.app" ]]; then
                    log_info "Windsurf not found - manual installation required"
                    log_info "  → Download from: https://codeium.com/windsurf"
                else
                    log_success "Windsurf already installed"
                fi
                ;;
            "continue")
                # Continue is a VS Code extension, will be handled in AI VS Code extensions
                log_info "Continue AI assistant will be installed as VS Code extension"
                ;;
            *)
                brew_cask_install "$ide" "$description"
                ;;
        esac
    done
}

function install_vector_databases() {
    log_info "Installing 🔍 Vector Databases & Search Engines with XDG compliance..."
    
    # Create XDG-compliant directories for vector databases
    mkdir -p "$XDG_DATA_HOME/vector-databases"
    mkdir -p "$XDG_CONFIG_HOME/vector-databases"
    mkdir -p "$XDG_CACHE_HOME/vector-databases"
    
    local vector_tools=(
        "qdrant: Vector search engine for AI applications"
        "chroma: AI-native open-source embedding database"
        "weaviate: Cloud-native vector database"
        "pinecone: Managed vector database service CLI"
        "pgvector: Vector similarity search for PostgreSQL"
    )
    
    for tool_info in "${vector_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        
        case "$tool" in
            "qdrant")
                if ! command -v qdrant &>/dev/null; then
                    if command -v docker &>/dev/null; then
                        # Check if Docker daemon is running
                        if docker info &>/dev/null; then
                            log_info "Installing $description via Docker with XDG data persistence..."
                            # Create XDG-compliant data directory for Qdrant
                            local qdrant_data="$XDG_DATA_HOME/vector-databases/qdrant"
                            mkdir -p "$qdrant_data"
                            
                            docker pull qdrant/qdrant
                            
                            # Create docker-compose configuration for XDG persistence
                            local qdrant_compose="$XDG_CONFIG_HOME/vector-databases/qdrant-docker-compose.yml"
                            cat > "$qdrant_compose" << EOF
version: '3.7'
services:
  qdrant:
    image: qdrant/qdrant
    ports:
      - "6333:6333"
      - "6334:6334"
    volumes:
      - "$qdrant_data:/qdrant/storage"
    environment:
      - QDRANT__SERVICE__HTTP_PORT=6333
      - QDRANT__SERVICE__GRPC_PORT=6334
EOF
                            
                            log_success "$description Docker image pulled with XDG persistence config"
                            log_info "Start with: docker-compose -f $qdrant_compose up -d"
                            log_info "Data will be stored in: $qdrant_data"
                        else
                            log_warning "Docker daemon not running - cannot install Qdrant via Docker"
                            log_info "Start Docker and run the script again for Qdrant installation"
                        fi
                    else
                        log_warning "Docker not available, skipping Qdrant installation"
                    fi
                else
                    log_success "$description already available"
                fi
                ;;
            "chroma"|"pinecone")
                if ! pipx list | grep -q "^${tool}db" && ! pipx list | grep -q "^$tool"; then
                    log_info "Installing $description via pipx..."
                    if [[ "$tool" == "chroma" ]]; then
                        pipx install chromadb || log_warning "Failed to install chromadb via pipx"
                    else
                        pipx install pinecone-client || log_warning "Failed to install pinecone-client via pipx"
                    fi
                    
                    # Configure XDG paths for ChromaDB
                    if [[ "$tool" == "chroma" ]]; then
                        local chroma_config="$XDG_CONFIG_HOME/vector-databases/chromadb.conf"
                        cat > "$chroma_config" << EOF
# ChromaDB XDG-compliant configuration
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/vector-databases/chromadb"
EOF
                        mkdir -p "$XDG_DATA_HOME/vector-databases/chromadb"
                        log_success "$description installed with XDG data dir: $XDG_DATA_HOME/vector-databases/chromadb"
                    else
                        log_success "$description installed via pipx"
                    fi
                else
                    log_success "$description already installed"
                fi
                ;;
            "weaviate")
                if ! pipx list | grep -q "weaviate"; then
                    log_info "Installing $description via pipx..."
                    pipx install weaviate-client || log_warning "Failed to install weaviate-client via pipx"
                    
                    # Create XDG-compliant configuration for Weaviate
                    local weaviate_config="$XDG_CONFIG_HOME/vector-databases/weaviate.conf"
                    cat > "$weaviate_config" << EOF
# Weaviate XDG-compliant configuration
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"
EOF
                    mkdir -p "$XDG_DATA_HOME/vector-databases/weaviate"
                    log_success "$description client installed with XDG configuration"
                else
                    log_success "$description already installed"
                fi
                ;;
            "pgvector")
                # pgvector is a PostgreSQL extension
                if command -v pg_config &>/dev/null; then
                    log_info "pgvector requires PostgreSQL - check if extension is available"
                    log_info "  → Install via: CREATE EXTENSION vector; (in PostgreSQL)"
                    
                    # Create helper script for pgvector setup
                    local pgvector_script="$XDG_CONFIG_HOME/vector-databases/setup-pgvector.sql"
                    cat > "$pgvector_script" << EOF
-- PostgreSQL pgvector setup script
-- Run this in your PostgreSQL database

-- Create the vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Example table with vector column
-- CREATE TABLE documents (
--   id SERIAL PRIMARY KEY,
--   content TEXT,
--   embedding VECTOR(1536)  -- OpenAI embedding dimension
-- );

-- Example index for vector similarity search
-- CREATE INDEX ON documents USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
EOF
                    log_success "pgvector setup script created: $pgvector_script"
                else
                    log_info "PostgreSQL not found - pgvector requires PostgreSQL"
                fi
                ;;
        esac
    done
    
    # Create a unified vector database configuration script
    local vector_db_script="$XDG_CONFIG_HOME/vector-databases/env-setup.sh"
    cat > "$vector_db_script" << 'EOF'
#!/bin/bash
# Vector Database Environment Setup Script
# Source this file to set up XDG-compliant paths for vector databases

# ChromaDB
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/vector-databases/chromadb"

# Weaviate
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"

# Qdrant data directory
export QDRANT_DATA_DIR="$XDG_DATA_HOME/vector-databases/qdrant"

echo "Vector database XDG environment configured:"
echo "  ChromaDB: $CHROMA_PERSIST_DIRECTORY"
echo "  Weaviate: $WEAVIATE_DATA_PATH"
echo "  Qdrant:   $QDRANT_DATA_DIR"
EOF
    
    chmod +x "$vector_db_script"
    log_success "Vector database XDG environment script created: $vector_db_script"
}

function install_modern_productivity_tools() {
    log_info "Installing ⚡ Modern Productivity & Automation Tools..."
    
    local productivity_tools=(
        "raycast: AI-powered launcher and productivity tool"
        "rectangle: Window management for enhanced productivity"
        "cleanmymac: System optimization and maintenance"
        "bartender: Menu bar organization and management"
        "alfred: Productivity app for macOS with workflows"
        "karabiner-elements: Keyboard customization tool"
        "hammerspoon: Desktop automation tool"
        "brew-services: Manage background services via Homebrew"
    )
    
    for tool_info in "${productivity_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        
        case "$tool" in
            "cleanmymac")
                # CleanMyMac might require manual installation or App Store
                if [[ ! -d "/Applications/CleanMyMac.app" ]]; then
                    log_info "CleanMyMac requires manual installation from App Store or website"
                    log_info "  → Download from: https://macpaw.com/cleanmymac"
                else
                    log_success "CleanMyMac already installed"
                fi
                ;;
            "brew-services")
                # This is a built-in brew command, not a separate package
                if command -v brew &>/dev/null; then
                    log_success "brew services available via Homebrew"
                else
                    log_warning "Homebrew not available"
                fi
                ;;
            *)
                brew_cask_install "$tool" "$description"
                ;;
        esac
    done
    
    # Install command-line productivity tools
    local cli_productivity=(
        "terminal-notifier: Send macOS notifications from command line"
        "mas: Mac App Store command line interface"
        "duti: Set default applications for document types"
        "trash: Move files to trash from command line"
    )
    
    for tool_info in "${cli_productivity[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function setup_ai_vscode_extensions() {
    # Skip AI VS Code extensions if cask apps are disabled
    if [[ "$SKIP_CASK_APPS" == "true" ]]; then
        log_info "Skipping AI VS Code extensions setup (SKIP_CASK_APPS=true)"
        return 0
    fi
    
    log_info "Setting up 🧠 AI-Enhanced VS Code Extensions..."
    
    # Check if VS Code CLI is available
    if ! command -v code &> /dev/null; then
        log_warning "VS Code CLI 'code' command not found. Skipping AI extension installation."
        log_info "To enable: Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
        return 0
    fi
    
    # AI-enhanced extensions
    local ai_extensions=(
        "continue.continue"
        "codeium.codeium"
        "github.copilot"
        "ms-toolsai.vscode-ai"
        "huggingface.huggingface-vscode"
        "tabnine.tabnine-vscode"
        "amazonwebservices.aws-toolkit-vscode"
        "ms-toolsai.vscode-jupyter-cell-tags"
        "charliermarsh.ruff"
        "ms-python.black-formatter"
        "ms-python.isort"
        "bradlc.vscode-tailwindcss"
        "prisma.prisma"
        "graphql.vscode-graphql"
        "rust-lang.rust-analyzer"
        "golang.go"
        "hashicorp.terraform"
        "redhat.vscode-yaml"
    )
    
    log_info "Installing AI-enhanced VS Code extensions..."
    for extension in "${ai_extensions[@]}"; do
        if ! code --list-extensions | grep -q "^$extension$"; then
            log_info "Installing extension: $extension"
            # Add error handling for VS Code CLI crashes
            if code --install-extension "$extension" --force 2>/dev/null; then
                log_success "Installed: $extension"
            else
                log_warning "Failed to install extension: $extension (installation failed)"
                continue
            fi
        else
            log_success "Extension already installed: $extension"
        fi
    done
    
    # Update the extensions.txt file with new AI extensions
    local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
    if [[ -f "$extensions_file" ]]; then
        # Backup current extensions file
        cp "$extensions_file" "$extensions_file.backup.$(date +%Y%m%d_%H%M%S)"
        
        # Add AI extensions header and new extensions
        {
            echo "# AI Development Extensions - Added $(date +%Y-%m-%d)"
            for extension in "${ai_extensions[@]}"; do
                # Check if extension is not already in file
                if ! grep -q "^$extension" "$extensions_file"; then
                    echo "$extension"
                fi
            done
            echo ""
            echo "# Original Extensions"
            grep -v "^#" "$extensions_file" | grep -v "^$"
        } > "$extensions_file.new"
        
        mv "$extensions_file.new" "$extensions_file"
        log_success "Updated extensions.txt with AI development extensions"
    fi
    
    log_success "AI-enhanced VS Code extensions setup completed"
}

################################################################################
# Step 8: Setup Git and GitHub
################################################################################
function setup_git_and_github() {
    log_step "🔗 Setting up Git and GitHub..."
    
    # Check if Git is configured
    if ! git config --global user.name &>/dev/null; then
        log_warning "Git user.name not configured. Please run:"
        log_warning "  git config --global user.name 'Your Name'"
    else
        log_success "Git user.name configured: $(git config --global user.name)"
    fi
    
    if ! git config --global user.email &>/dev/null; then
        log_warning "Git user.email not configured. Please run:"
        log_warning "  git config --global user.email 'your.email@example.com'"
    else
        log_success "Git user.email configured: $(git config --global user.email)"
    fi
    
    # Setup SSH key if not exists
    setup_ssh_key
    
    # GitHub CLI authentication
    if command -v gh &>/dev/null; then
        if ! gh auth status &>/dev/null; then
            log_warning "GitHub CLI not authenticated. Please run: gh auth login"
        else
            log_success "GitHub CLI already authenticated"
        fi
    fi
    
    log_success "Git and GitHub setup completed"
}

function setup_ssh_key() {
    if [[ ! -f ~/.ssh/id_ed25519 ]]; then
        log_info "Generating SSH key for GitHub..."
        ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)" -f ~/.ssh/id_ed25519 -N ""
        
        # Start SSH agent and add key
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
        
        log_success "SSH key generated. Add the following public key to your GitHub account:"
        echo ""
        cat ~/.ssh/id_ed25519.pub
        echo ""
    else
        log_success "SSH key already exists"
    fi
}

################################################################################
# Impact Summary Functions
################################################################################

function show_directory_impact() {
    echo "✅ Created SBRN directory structure at: $SBRN_HOME"
    echo "   📁 Projects: $SBRN_HOME/proj/{corp,oss,learn,lab,exp}"
    echo "   📁 Areas: $SBRN_HOME/area/{work,personal,community,academic}"
    echo "   📁 Resources: $SBRN_HOME/rsrc/{notes,templates,refs}"
    echo "   📁 Archives: $SBRN_HOME/arch/{proj,area}"
    echo "   📁 System: $SBRN_HOME/sys/{config,local,cache,bin}"
    echo "   📁 Cloud Drives: $HOME/Drives/{iCloud,GoogleDrive,OneDrive,Dropbox}"
    if [[ -d "$SBRN_HOME/sys/hrt" ]]; then
        echo "   📁 HRT Tools: $SBRN_HOME/sys/hrt (cloned from GitHub)"
    fi
    echo "✅ Hidden standard macOS folders (Movies, Music, Desktop, Public, Pictures, Library)"
    echo "✅ XDG Base Directory Specification configured:"
    echo "   • XDG_CONFIG_HOME=$XDG_CONFIG_HOME"
    echo "   • XDG_DATA_HOME=$XDG_DATA_HOME"
    echo "   • XDG_STATE_HOME=$XDG_STATE_HOME"
    echo "   • XDG_CACHE_HOME=$XDG_CACHE_HOME"
    echo "✅ Application-specific directories:"
    echo "   • ANDROID_HOME=$ANDROID_HOME"
    echo "   • GRADLE_USER_HOME=$GRADLE_USER_HOME"
    echo "✅ Non-shell configuration symlinks:"
    if [[ -L "$XDG_CONFIG_HOME/git" ]]; then
        echo "   • Git configuration linked"
    fi
}

function show_homebrew_impact() {
    echo "✅ Package manager installed: $(brew --version | head -1)"
    echo "✅ Homebrew location: $(which brew)"
    echo "✅ Package database updated to latest versions"
    if [[ $(uname -m) == "arm64" ]]; then
        echo "✅ Apple Silicon configuration: Added /opt/homebrew/bin to PATH"
    fi
}

function show_zsh_impact() {
    echo "✅ Oh My Zsh installed at: $SBRN_HOME/sys/etc/oh-my-zsh"
    echo "✅ Powerlevel10k theme installed for enhanced prompt"
    echo "✅ Essential plugins installed:"
    echo "   • zsh-autosuggestions (command completion)"
    echo "   • zsh-syntax-highlighting (syntax highlighting)"
    echo "   • history-substring-search (better history search)"
    echo "   • zsh-autoswitch-virtualenv (auto Python venv switch)"
    echo "✅ Meslo Nerd Font installed for terminal icons"
    echo "✅ Zsh configuration setup:"
    echo "   • ZDOTDIR set to: $XDG_CONFIG_HOME/zsh"
    echo "✅ XDG-compliant Zsh directories created:"
    echo "   • History: $XDG_STATE_HOME/zsh/history"
    echo "   • Completion dumps: $XDG_CACHE_HOME/zsh/zcompdump-\${ZSH_VERSION}"
    echo "   • Sessions: $XDG_STATE_HOME/zsh/sessions/"
    if [[ -L "$XDG_CONFIG_HOME/zsh" ]]; then
        echo "   • Zsh configuration directory linked from HRT"
    fi
    if [[ -f ~/.zshenv ]]; then
        echo "   • .zshenv symlinked from HRT configuration"
    fi
}

function show_cli_tools_impact() {
    echo "✅ Shell Enhancements & CLI Productivity tools installed:"
    echo "   • coreutils (GNU core utilities with g- prefix)"
    echo "   • tree (directory tree visualization)"
    echo "   • fzf (command-line fuzzy finder)"
    echo "   • tmux (terminal multiplexer)"
    echo "   • screen (terminal multiplexer with VT100/ANSI terminal emulation)"
    echo "   • htop (interactive process viewer)"
    echo "   • bat (cat clone with syntax highlighting)"
    echo "   • fd (fast alternative to find)"
    echo "   • tldr (simplified man pages)"
    echo "   • eza (modern ls replacement with colors and icons)"
    echo "   • zoxide (smarter cd command)"
    echo "   • watch (execute programs periodically)"
    echo "   • ncdu (NCurses disk usage analyzer)"
    echo "   • glances (system monitoring tool)"
    echo "   • lsd (LSDeluxe - next gen ls command)"
    echo "   • ctop (top-like interface for container metrics)"
    echo "   • autoenv (directory-based environments)"
    echo "   • atuin (improved shell history for zsh, bash, fish and nushell)"
    echo "   • direnv (load/unload environment variables based on PWD)"
    echo "   • ack (search tool like grep, optimized for programmers)"
    echo "   • broot (new way to see and navigate directory trees)"
    echo "   • figlet (banner-like program prints strings as ASCII art)"
    echo "   • lolcat (rainbows and unicorns in your console)"
    echo "   • ranger (file browser)"
    echo "   • as-tree (print a list of paths as a tree of paths)"
    echo "   • agedu (Unix utility for tracking down wasted disk space)"
    echo "   • zsh-autosuggestions (fish-like autosuggestions for zsh)"
    echo "   • zsh-completions (additional completion definitions for zsh)"
    echo "   • bash-completion (programmable completion for Bash 3.2)"
    echo "   • fish (user-friendly command-line shell for UNIX-like operating systems)"
    echo "✅ Networking, Security, & Transfer tools:"
    echo "   • curl (command-line data transfer tool)"
    echo "   • wget (internet file retriever)"
    echo "   • httpie (user-friendly HTTP client)"
    echo "   • netcat (networking utility)"
    echo "   • gnupg (GNU Pretty Good Privacy PGP package)"
    echo "   • certbot (tool to obtain certs from Let's Encrypt)"
    echo "   • telnet (user interface to the TELNET protocol)"
    echo "✅ Text, Regex, JSON, Data tools & CLI Editors:"
    echo "   • jq (lightweight JSON processor)"
    echo "   • ripgrep (fast text search tool with configuration and aliases)"
    echo "   • grep (GNU grep, egrep and fgrep with color aliases)"
    echo "   • fx (terminal JSON viewer)"
    echo "   • jid (JSON incremental digger)"
    echo "   • colordiff (color-highlighted diff output)"
    echo "   • base64 (encode and decode base64 files)"
    echo "   • base91 (utility to encode and decode base91 files)"
    echo "   • python-yq (command-line YAML and XML processor that wraps jq)"
    echo "   • ccat (like cat but displays content with syntax highlighting)"
    echo "   • vim (Vi IMproved - enhanced version of the vi editor)"
    echo "   • neovim (Ambitious Vim-fork focused on extensibility and agility)"
    echo "   • emacs (GNU Emacs text editor)"
    echo "   • nano (Free GNU replacement for the Pico text editor)"
}

function show_dev_tools_impact() {
    echo "✅ Developer Tools (VCS, Repos, Git Helpers):"
    echo "   • git (distributed revision control system)"
    echo "   • git-extras (small git utilities)"
    echo "   • git-lfs (Git extension for versioning large files)"
    echo "   • gh (GitHub command-line tool)"
    echo "   • gibo (fast access to .gitignore boilerplates)"
    echo "   • ghq (remote repository management)"
    echo "   • lazygit (simple terminal UI for git)"
    echo "   • tig (text-mode interface for git)"
    echo "   • diff-so-fancy (good-lookin' diffs with diff-highlight)"
    echo "   • git-gui (Tcl/Tk based graphical user interface to Git)"
    echo "   • gitk (Git repository browser)"
    echo "   • Git configured to use diff-so-fancy for enhanced diffs"
    echo "✅ Cloud & Containers:"
    echo "   • docker (platform for developing, shipping, and running applications)"
    echo "   • docker-compose (isolated development environments using Docker)"
    echo "   • colima (container runtimes on macOS with minimal setup)"
    echo "   • kubernetes-cli (Kubernetes command-line interface)"
    echo "   • helm (Kubernetes package manager)"
    echo "   • awscli (official Amazon AWS command-line interface)"
    echo "   • dive (tool for exploring each layer in a docker image)"
    echo "   • dockviz (visualizing docker data)"
    echo "   • k9s (Kubernetes CLI to manage clusters in style)"
    echo "   • kubecolor (colorize your kubectl output)"
    echo "   • kompose (tool to move from docker-compose to Kubernetes)"
    echo "   • krew (package manager for kubectl plugins)"
    echo "   • kube-ps1 (Kubernetes prompt info for bash and zsh)"
    echo "   • kubebuilder (SDK for building Kubernetes APIs using CRDs)"
    echo "   • kustomize (template-free customization of Kubernetes YAML manifests)"
    echo "   • istioctl (Istio configuration command-line utility)"
    echo "   • minikube (run a Kubernetes cluster locally)"
    echo "   • terraform (tool to build, change, and version infrastructure)"
    echo "✅ Graphics, Images, and UI Libraries:"
    echo "   • librsvg (library to render SVG files using Cairo)"
    echo "   • gtk+3 (toolkit for creating graphical user interfaces)"
    echo "   • ghostscript (interpreter for PostScript and PDF)"
    echo "   • graphviz (graph visualization software from AT&T and Bell Labs)"
    echo "   • guile (GNU Ubiquitous Intelligent Language for Extensions)"
    echo "   • pcre (Perl compatible regular expressions library)"
    echo "   • xerces-c (validating XML parser)"
    echo "   • pygobject3 (GNOME Python bindings based on GObject Introspection)"
    echo "✅ Additional Development & API tools:"
    echo "   • jwt-cli (super fast CLI tool to decode and encode JWTs built in Rust)"
    echo "   • newman (command-line collection runner for Postman)"
    echo "   • openapi-generator (generate clients, server & docs from an OpenAPI spec)"
    echo "   • operator-sdk (SDK for building Kubernetes applications)"
    echo "   • hugo (configurable static site generator)"
    echo "   • logrotate (rotates, compresses, and mails system logs)"
    echo "   • rtmpdump (tool for downloading RTMP streaming media)"
    echo "   • sftpgo (fully featured SFTP server with HTTP/S, FTP/S and WebDAV support)"
    echo "   • etcd (key value store for shared configuration and service discovery)"
    echo "   • postgresql@15 (object-relational database system)"
    echo "   • redis (persistent key-value database, with built-in net interface)"
    echo "   • nginx (HTTP(S) server and reverse proxy, and IMAP/POP3 proxy server)"
}

function show_languages_impact() {
    echo "✅ Core Programming Languages & Runtimes:"
    echo "   • openjdk@17 (Java Platform, Standard Edition v17)"
    echo "   • openjdk@21 (Java Platform, Standard Edition v21)"
    echo "   • python@3.13 (Python 3.13 programming language)"
    echo "   • perl (highly capable, feature-rich programming language)"
    echo "   • node (platform built on V8 to build network applications)"
    echo "   • go (open source programming language)"
    echo "   • rust (safe, concurrent, practical language)"
    echo "✅ Runtime Environment Managers:"
    echo "   • jenv (Java runtime environment management)"
    echo "   • uv (Python virtual environment management)"
    echo "   • nvm (Node.js runtime environment management - Homebrew install with XDG-compliant configuration)"
    echo "   • pipx (Isolated Python application environments)"
    echo "✅ Build Automation Tools:"
    echo "   • maven (Java-based project management)"
    echo "   • gradle (build automation tool based on Groovy and Kotlin)"
    echo "   • poetry (Python package and dependency manager)"
    echo "   • yarn (JavaScript package manager)"
    echo "✅ Runtime Versions:"
    echo "   • Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "   • Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
    echo "   • Java: $(java --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "   • Go: $(go version 2>/dev/null || echo 'Not installed')"
    echo "   • Rust: $(rustc --version 2>/dev/null || echo 'Not installed')"
    echo "   • Perl: $(perl --version 2>/dev/null | head -2 | tail -1 || echo 'Not installed')"
}

function show_ides_impact() {
    echo "✅ Core IDEs and editors installed:"
    if [[ -d "/Applications/Visual Studio Code.app" ]]; then
        echo "   • Visual Studio Code (GUI + CLI: code)"
    fi
    if [[ -d "/Applications/IntelliJ IDEA CE.app" ]]; then
        echo "   • IntelliJ IDEA CE (GUI + CLI: idea)"
    fi
    if [[ -d "/Applications/PyCharm CE.app" ]]; then
        echo "   • PyCharm Community Edition"
    fi
    if [[ -d "/Applications/Cursor.app" ]]; then
        echo "   • Cursor AI Editor (GUI + CLI: cursor)"
    fi
    if [[ -d "/Applications/iTerm.app" ]]; then
        echo "   • iTerm2 Terminal Emulator"
    fi
    echo "   • CLI editors: vim, neovim, emacs, nano"
    echo "✅ Productivity and Development Support Apps:"
    if [[ -d "/Applications/Notion.app" ]]; then
        echo "   • Notion (all-in-one workspace)"
    fi
    if [[ -d "/Applications/Obsidian.app" ]]; then
        echo "   • Obsidian (knowledge management)"
    fi
    if [[ -d "/Applications/Figma.app" ]]; then
        echo "   • Figma (collaborative design tool)"
    fi
    if [[ -d "/Applications/Slack.app" ]]; then
        echo "   • Slack (team communication)"
    fi
    if [[ -d "/Applications/Zoom.app" ]]; then
        echo "   • Zoom (video conferencing)"
    fi
    if [[ -d "/Applications/GitHub Desktop.app" ]]; then
        echo "   • GitHub Desktop (Git GUI client)"
    fi
    if [[ -d "/Applications/Postman.app" ]]; then
        echo "   • Postman (API development and testing)"
    fi
    if [[ -d "/Applications/Insomnia.app" ]]; then
        echo "   • Insomnia (REST API client)"
    fi
    if [[ -d "/Applications/DBeaver.app" ]]; then
        echo "   • DBeaver Community (universal database tool)"
    fi
    if [[ -d "/Applications/pgAdmin 4.app" ]]; then
        echo "   • pgAdmin 4 (PostgreSQL administration)"
    fi
    if [[ -d "/Applications/RapidAPI.app" ]]; then
        echo "   • RapidAPI (API testing tool)"
    fi
    if [[ -d "/Applications/VirtualBox.app" ]]; then
        echo "   • VirtualBox (virtual machine software)"
    fi
    if [[ -d "/Applications/Microsoft Edge.app" ]]; then
        echo "   • Microsoft Edge (web browser)"
    fi
    echo "✅ Development Environment Tools:"
    if command -v jupyter &>/dev/null; then
        echo "   • JupyterLab installed via pipx (XDG-compliant: $XDG_DATA_HOME/pipx)"
    elif command -v pipx &>/dev/null; then
        # Check if JupyterLab is already installed via pipx
        if pipx list 2>/dev/null | grep -q jupyterlab; then
            echo "   • JupyterLab already installed via pipx (XDG-compliant: $XDG_DATA_HOME/pipx)"
        else
            echo "   • pipx available for installing Python applications (XDG-compliant: $XDG_DATA_HOME/pipx)"
            echo "   • Run 'pipx install jupyterlab' for isolated Jupyter installation"
        fi
    else
        echo "   • Note: For Jupyter, create virtual environments to avoid system conflicts"
    fi
    echo "   • git-gui, gitk (Git graphical tools)"
    echo "✅ Command-line shortcuts created in: $SBRN_HOME/sys/bin"
    echo "✅ pipx configured with XDG Base Directory Specification:"
    if [[ -n "${PIPX_HOME:-}" ]]; then
        echo "   • PIPX_HOME: $PIPX_HOME"
        echo "   • PIPX_BIN_DIR: $PIPX_BIN_DIR (added to PATH)"
        echo "   • PIPX_CACHE_DIR: $PIPX_CACHE_DIR"
    else
        echo "   • pipx will use XDG directories when configured"
    fi
    
    # Show iTerm2 setup status
    if [[ "$SKIP_ITERM_SETUP" == "true" ]]; then
        echo "⚠️  iTerm2 setup skipped (--skip-iterm-setup flag active)"
    elif [[ -d "/Applications/iTerm.app" ]]; then
        echo "✅ iTerm2 terminal setup:"
        local colors_dir="$SBRN_HOME/sys/hrt/conf/terminal/colors"
        local profiles_dir="$SBRN_HOME/sys/hrt/conf/terminal/profiles"
        local iterm_script="$SBRN_HOME/sys/hrt/scripts/manage-iterm-profiles.sh"
        
        if [[ -d "$colors_dir" ]]; then
            local color_count=$(find "$colors_dir" -name "*.itermcolors" 2>/dev/null | wc -l | tr -d ' ')
            echo "   • Color schemes: $color_count themes available"
        fi
        
        if [[ -d "$profiles_dir" ]]; then
            local profile_count=$(find "$profiles_dir" -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
            echo "   • Profiles: $profile_count configurations available"
        fi
        
        if [[ -x "$iterm_script" ]]; then
            echo "   • Management: $iterm_script"
            echo "   • Commands: install, import, export, backup, sync, list"
        fi
    else
        echo "⚠️  iTerm2 not found - terminal configurations skipped"
    fi
}

function show_ai_development_impact() {
    echo "✅ 🤖 AI/ML Core Tools & Frameworks (XDG-compliant with uv):"
    echo "   • ollama (local LLM deployment with XDG model storage: $XDG_DATA_HOME/ollama/models)"
    echo "   • huggingface-cli (with XDG cache: $XDG_CACHE_HOME/huggingface)"
    echo "   • duckdb (with XDG data: $XDG_DATA_HOME/duckdb)"
    echo "   • mlflow (with XDG tracking: $XDG_DATA_HOME/mlflow)"
    echo "   • datasette, sqlite-utils"
    echo "   • uv (modern Python package manager with XDG compliance)"
    if command -v pyenv &>/dev/null; then
        echo "   • pyenv (XDG root: $XDG_DATA_HOME/pyenv)"
    fi
    echo "✅ 🐍 ML-Optimized Python Environment (uv-based, XDG-compliant):"
    if command -v uv &>/dev/null; then
        local env_path="$XDG_DATA_HOME/python-projects/ml-dev"
        if [[ -d "$env_path" ]]; then
            echo "   • ml-dev uv project in XDG location: $env_path"
            echo "   • Jupyter kernel 'Python (ML-Dev-UV)' with XDG data: $XDG_DATA_HOME/jupyter"
            echo "   • Packages: torch, transformers, scikit-learn, chromadb, streamlit"
            echo "   • Activate with: cd $env_path && uv shell"
        else
            echo "   • uv available for XDG-compliant ML environment creation"
        fi
    else
        echo "   • Install uv for optimal XDG-compliant ML environment"
    fi
    echo "✅ 🤖 AI Agent Development Frameworks (uv-based project):"
    if command -v uv &>/dev/null; then
        local env_path="$XDG_DATA_HOME/python-projects/agentic-ai"
        if [[ -d "$env_path" ]]; then
            echo "   • agentic-ai uv project in XDG location: $env_path"
            echo "   • Jupyter kernel 'Python (Agentic-AI-UV)' with XDG data: $XDG_DATA_HOME/jupyter"
            echo "   • LangChain ecosystem: langchain, langsmith, langserve, langchain-community"
            echo "   • Multi-agent frameworks: crewai, autogen-agentchat, semantic-kernel"
            echo "   • Search & retrieval: haystack-ai, llama-index with extensions"
            echo "   • LLM clients: openai, anthropic, cohere, google-generativeai"
            echo "   • Vector databases: chromadb, qdrant-client, weaviate-client, pinecone-client"
            echo "   • Web frameworks: streamlit, gradio, chainlit, fastapi"
            echo "   • Monitoring: mlflow, wandb, langfuse, arize-phoenix"
            echo "   • Activate with: cd $env_path && uv shell"
        else
            echo "   • uv available for agentic AI environment creation"
        fi
    else
        echo "   • Install uv for optimal agentic AI environment"
    fi
    echo "✅ 🧠 Local LLM Capabilities (XDG-compliant):"
    if command -v ollama &>/dev/null; then
        echo "   • Ollama service with XDG model storage: $XDG_DATA_HOME/ollama/models"
        echo "   • Models: llama3.2:3b, codellama:7b, mistral:7b, phi3:mini"
        echo "   • Configuration: $XDG_CONFIG_HOME/ollama/config.yaml"
    fi
    if [[ -f "$SBRN_HOME/sys/bin/llamafile" ]]; then
        echo "   • llamafile with XDG data dir: $XDG_DATA_HOME/llamafile"
    fi
    echo "✅ 🚀 Modern AI-Enhanced IDEs:"
    if [[ -d "/Applications/Cursor.app" ]] || [[ -d "$HOME/Applications/Cursor.app" ]]; then
        echo "   • Cursor (AI-native code editor)"
    fi
    if [[ -d "/Applications/Zed.app" ]] || [[ -d "$HOME/Applications/Zed.app" ]]; then
        echo "   • Zed (high-performance collaborative editor)"
    fi
    if [[ -d "/Applications/Windsurf.app" ]] || [[ -d "$HOME/Applications/Windsurf.app" ]]; then
        echo "   • Windsurf (Codeium AI-native IDE)"
    fi
    echo "✅ 🔍 Vector Databases & Search (XDG-compliant):"
    if command -v docker &>/dev/null; then
        echo "   • Qdrant (Docker with XDG persistence: $XDG_DATA_HOME/vector-databases/qdrant)"
    fi
    echo "   • ChromaDB (XDG data: $XDG_DATA_HOME/vector-databases/chromadb)"
    echo "   • Weaviate client (XDG config: $XDG_CONFIG_HOME/vector-databases/weaviate)"
    echo "   • Pinecone client, pgvector setup script"
    echo "   • Environment setup: $XDG_CONFIG_HOME/vector-databases/env-setup.sh"
    echo "✅ ⚡ Modern Productivity & Automation:"
    if [[ -d "/Applications/Raycast.app" ]] || [[ -d "$HOME/Applications/Raycast.app" ]]; then
        echo "   • Raycast (AI-powered launcher)"
    fi
    if [[ -d "/Applications/Rectangle.app" ]] || [[ -d "$HOME/Applications/Rectangle.app" ]]; then
        echo "   • Rectangle (window management)"
    fi
    if [[ -d "/Applications/Alfred.app" ]] || [[ -d "$HOME/Applications/Alfred.app" ]]; then
        echo "   • Alfred (productivity workflows)"
    fi
    if command -v terminal-notifier &>/dev/null; then
        echo "   • terminal-notifier, mas CLI, trash CLI"
    fi
    echo "✅ 🧠 AI-Enhanced VS Code Extensions:"
    if command -v code &>/dev/null; then
        local ai_ext_count=$(code --list-extensions | grep -E "(continue|codeium|copilot|tabnine|huggingface)" | wc -l | tr -d ' ')
        echo "   • $ai_ext_count AI extensions installed (Continue, Codeium, Copilot Labs, etc.)"
        echo "   • Extensions updated in: $SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
    else
        echo "   • VS Code CLI not available - extensions pending"
    fi
    echo "✅ 🌐 Modern Cloud & Deployment Tools:"
    if command -v pulumi &>/dev/null; then
        echo "   • Pulumi, Railway, Vercel CLIs"
    fi
    echo "✅ 📁 XDG Configuration:"
    echo "   • uv configuration: $XDG_CONFIG_HOME/uv/uv.toml"
    echo "   • uv data directory: $XDG_DATA_HOME/uv"
    echo "   • Python projects: $XDG_DATA_HOME/python-projects/{ml-dev,agentic-ai}"
    echo "   • Vector databases: $XDG_CONFIG_HOME/vector-databases/"
    echo "   • All AI tool data in XDG-compliant locations"
}

function show_git_impact() {
    echo "✅ Git configuration:"
    echo "   • User name: $(git config --global user.name 2>/dev/null || echo 'Not configured')"
    echo "   • User email: $(git config --global user.email 2>/dev/null || echo 'Not configured')"
    if [[ -f ~/.ssh/id_ed25519 ]]; then
        echo "✅ SSH key generated for GitHub authentication"
    fi
    if command -v gh &>/dev/null; then
        if gh auth status &>/dev/null; then
            echo "✅ GitHub CLI authenticated"
        else
            echo "⚠️  GitHub CLI installed but not authenticated"
        fi
    fi
}

function setup_vscode_extensions() {
    # Skip VS Code extensions setup if cask apps are disabled
    if [[ "$SKIP_CASK_APPS" == "true" ]]; then
        log_info "Skipping VS Code extensions setup (SKIP_CASK_APPS=true)"
        return 0
    fi
    
    log_info "Setting up VS Code extensions from configuration..."
    
    # Check if VS Code CLI is available
    if ! command -v code &> /dev/null; then
        log_warning "VS Code CLI 'code' command not found. Skipping extension installation."
        log_info "To enable: Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
        return 0
    fi
    
    local extensions_script="$SBRN_HOME/sys/hrt/scripts/manage-vscode-extensions.sh"
    local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
    
    # Check if the management script exists and is executable
    if [[ -x "$extensions_script" ]]; then
        log_info "Using VS Code extensions management script..."
        
        # If extensions file doesn't exist, create one by capturing current extensions
        if [[ ! -f "$extensions_file" ]]; then
            log_info "Creating VS Code extensions configuration from current installations..."
            "$extensions_script" capture
            log_success "Captured current VS Code extensions to extensions.txt"
        fi
        
        # Install missing extensions using the script
        log_info "Installing missing VS Code extensions..."
        if "$extensions_script" install; then
            log_success "VS Code extensions setup completed using management script"
        else
            log_warning "VS Code extension installation failed"
            log_info "You can run this manually later: $extensions_script install"
        fi
        
    else
        # Script should exist as part of the repository
        log_warning "VS Code extensions management script not found or not executable: $extensions_script"
        log_info "Expected script location: $extensions_script"
        log_info "Skipping VS Code extensions setup - please run the script manually after setup"
        return 1
    fi
}

function setup_iterm_profiles() {
    # Skip iTerm setup if flag is set
    if [[ "$SKIP_ITERM_SETUP" == "true" ]]; then
        log_info "Skipping iTerm2 setup (SKIP_ITERM_SETUP=true)"
        return 0
    fi
    
    log_info "Setting up iTerm2 profiles and color schemes from configuration..."
    
    local iterm_script="$SBRN_HOME/sys/hrt/scripts/manage-iterm-profiles.sh"
    local colors_dir="$SBRN_HOME/sys/hrt/conf/terminal/colors"
    local profiles_dir="$SBRN_HOME/sys/hrt/conf/terminal/profiles"
    
    # Check if iTerm2 is installed
    if [[ ! -d "/Applications/iTerm.app" ]]; then
        log_warning "iTerm2 not found. Installing via Homebrew..."
        brew_cask_install "iterm2" "iTerm2 - Terminal emulator for macOS"
    fi
    
    # Check if management script exists and is executable
    if [[ -x "$iterm_script" ]]; then
        # Install color schemes if available
        if [[ -d "$colors_dir" ]]; then
            local color_count=$(find "$colors_dir" -name "*.itermcolors" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $color_count -gt 0 ]]; then
                log_info "Installing $color_count iTerm2 color schemes..."
                "$iterm_script" install
                log_success "iTerm2 color schemes installed"
            else
                log_warning "No .itermcolors files found in $colors_dir"
            fi
        else
            log_warning "Colors directory not found: $colors_dir"
        fi
        
        # Ask user if they want to import profiles and show available profiles
        if [[ -d "$profiles_dir" ]]; then
            local profile_count=$(find "$profiles_dir" -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $profile_count -gt 0 ]]; then
                log_info "Found $profile_count iTerm2 profile configurations:"
                
                # List available profile names from individual JSON files
                for profile_file in "$profiles_dir"/*.json; do
                    if [[ -f "$profile_file" && "$(basename "$profile_file")" != "profiles.iterm2.json" ]]; then
                        local profile_name=$(basename "$profile_file" .json)
                        echo "   • $profile_name"
                    fi
                done
                
                # Ask user if they want to import
                echo ""
                if [[ "$AUTO_YES" == "true" ]]; then
                    log_info "Auto-importing iTerm2 profiles..."
                    REPLY="y"
                else
                    echo "Import iTerm2 profiles automatically? [y/N]: "
                    read -r REPLY
                fi
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    log_info "Importing iTerm2 profiles..."
                    if "$iterm_script" import; then
                        log_success "iTerm2 profiles import completed"
                        log_info "Profiles are now available in iTerm2 → Preferences → Profiles"
                    else
                        log_warning "Automatic import failed. Manual import instructions:"
                        echo "   1. Open iTerm2 → Preferences → Profiles"
                        echo "   2. Click 'Other Actions...' → 'Import JSON Profiles'"
                        echo "   3. Select: $profiles_dir/profiles.iterm2.json"
                    fi
                else
                    log_info "Profile import skipped. To import later:"
                    echo "   • Run: $iterm_script import"
                    echo "   • Or manually: iTerm2 → Preferences → Profiles → Other Actions → Import JSON Profiles"
                fi
            else
                log_warning "No profile .json files found in $profiles_dir"
            fi
        else
            log_warning "Profiles directory not found: $profiles_dir"
        fi
    else
        # Script should exist as part of the repository
        log_warning "iTerm2 profiles management script not found or not executable: $iterm_script"
        log_info "Expected script location: $iterm_script"
        log_info "Skipping iTerm2 profiles setup - please run the script manually after setup"
        return 1
    fi
}

function show_vscode_impact() {
    if command -v code &>/dev/null; then
        local ext_count=$(code --list-extensions | wc -l)
        local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
        local configured_count=0
        
        if [[ -f "$extensions_file" ]]; then
            # Backup current extensions file
            cp "$extensions_file" "$extensions_file.backup.$(date +%Y%m%d_%H%M%S)"
            
            # Add AI extensions header and new extensions
            {
                echo "# AI Development Extensions - Added $(date +%Y-%m-%d)"
                for extension in "${ai_extensions[@]}"; do
                    # Check if extension is not already in file
                    if ! grep -q "^$extension" "$extensions_file"; then
                        echo "$extension"
                    fi
                done
                echo ""
                echo "# Original Extensions"
                grep -v "^#" "$extensions_file" | grep -v "^$"
            } > "$extensions_file.new"
            
            mv "$extensions_file.new" "$extensions_file"
            log_success "Updated extensions.txt with AI development extensions"
        fi
        
        echo "✅ VS Code extensions: $ext_count installed, $configured_count configured"
        echo "   • Settings: Linked from $SBRN_HOME/sys/hrt/conf/vscode/settings.json"
        echo "   • Extensions: Managed via $SBRN_HOME/sys/hrt/scripts/manage-vscode-extensions.sh"
        echo "   • Configuration: $extensions_file"
        echo "   • Management commands:"
        echo "     - Capture current: ./scripts/manage-vscode-extensions.sh capture"
        echo "     - Install missing: ./scripts/manage-vscode-extensions.sh install" 
        echo "     - Sync all: ./scripts/manage-vscode-extensions.sh sync"
    else
        echo "⚠️  VS Code not found, extensions skipped"
        echo "   • Install VS Code and run provision script again"
        echo "   • Or manually run: $SBRN_HOME/sys/hrt/scripts/manage-vscode-extensions.sh install"
    fi
}

function show_final_config_impact() {
    echo "✅ Shell configuration files updated:"
    if [[ -f "$HOME/.zshenv" ]]; then
        echo "   • ~/.zshenv (SBRN and XDG environment variables)"
    fi
    if [[ -f "$HOME/.zshrc" ]]; then
        echo "   • ~/.zshrc (SBRN paths and aliases)"
    fi
    echo "✅ Configuration files created:"
    echo "   • $SBRN_HOME/sys/config/aliases (development shortcuts)"
    echo "   • $SBRN_HOME/sys/config/dev-env (environment variables)"
    echo "   • $SBRN_HOME/sys/config/ripgrep/config (ripgrep configuration)"
}

################################################################################
# Utility Functions
################################################################################

# Shell-based timeout function for commands that don't have built-in timeout
run_with_timeout() {
    local timeout_duration="$1"
    shift
    local command=("$@")
    
    # Run command in background
    "${command[@]}" &
    local cmd_pid=$!
    
    # Start timeout counter in background
    (
        sleep "$timeout_duration"
        if kill -0 "$cmd_pid" 2>/dev/null; then
            kill "$cmd_pid" 2>/dev/null
        fi
    ) &
    local timeout_pid=$!
    
    # Wait for command to complete
    if wait "$cmd_pid" 2>/dev/null; then
        # Command completed successfully, kill timeout process
        kill "$timeout_pid" 2>/dev/null
        return 0
    else
        # Command failed or was killed by timeout
        kill "$timeout_pid" 2>/dev/null
        return 1
    fi
}

# Helper function to install Homebrew packages
function brew_install() {
    local package="$1"
    
    if brew list "$package" &>/dev/null; then
        log_success "$package already installed"
    else
        log_info "Installing $package..."
        brew install "$package" >/dev/null 2>&1 && log_success "$package installed successfully" || log_warning "Failed to install $package"
    fi
}

# Helper function to install Homebrew Cask applications
function brew_cask_install() {
    local cask="$1"
    local description="${2:-$cask}"
    
    if [[ $SKIP_CASK_APPS == false ]]; then
        if ! brew list --cask "$cask" &>/dev/null; then
            log_info "Installing $description..."
            brew install --cask --appdir=~/Applications "$cask" >/dev/null 2>&1 && log_success "$description installed successfully" || log_warning "Failed to install $description"
        else
            log_success "$description already installed"
        fi
    else
        log_info "Skipping cask installation: $description"

    fi
}

################################################################################
# Argument Parsing
################################################################################
function parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--skip-cask-apps)
                SKIP_CASK_APPS=true
                log_info "SKIP-CASK-APPS mode enabled: GUI applications will be skipped"
                shift
                ;;
            -i|--skip-iterm-setup)
                SKIP_ITERM_SETUP=true
                log_info "SKIP-ITERM-SETUP mode enabled: iTerm2 profiles setup will be skipped"
                shift
                ;;
            -y|--yes)
                AUTO_YES=true
                log_info "Auto-mode enabled: All confirmations will be automatically accepted"
                shift
                ;;
            --status)
                show_system_summary
                exit 0
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

function show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Portable Replicatable Scalable Developer Laboratory Setup for macOS"
    echo ""
    echo "Options:"
    echo "  -c, --skip-cask-apps     Skip GUI application installations (brew cask apps)"
    echo "  -i, --skip-iterm-setup   Skip iTerm2 profiles and color schemes setup"
    echo "  -y, --yes               Auto-accept all confirmations (non-interactive mode)"
    echo "      --status            Show current system status and exit"
    echo "  -h, --help              Show this help message and exit"
    echo ""
    echo "Examples:"
    echo "  $0                      # Interactive setup with all options"
    echo "  $0 --yes               # Automated setup with all options"
    echo "  $0 -c -y               # Automated setup, skip GUI apps"
    echo "  $0 --skip-iterm-setup  # Interactive setup, skip iTerm2 setup"
    echo "  $0 --status            # Check current installation status"
}

function show_system_summary() {
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo "🖥️  SYSTEM SUMMARY"
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo "macOS Version: $(sw_vers -productVersion)"
    echo "Architecture: $(uname -m)"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Shell: $SHELL"
    echo "Home Directory: $HOME"
    if [[ -n "${SBRN_HOME:-}" ]]; then
        echo "SBRN Home: $SBRN_HOME"
    else
        echo "SBRN Home: Not yet configured"
    fi
    echo "════════════════════════════════════════════════════════════════════════════════"
}

################################################################################
# Script Entry Point - Only execute when script is run directly, not sourced
################################################################################
# Parse command line arguments
parse_arguments "$@"
    
    # Check if running on macOS
    if [[ $(uname) != "Darwin" ]]; then
        log_error "This script is designed for macOS only"
        exit 1
    fi
    
    # Show system summary before starting
    show_system_summary
    echo ""
    
    # Show configuration warnings
    if [[ $SKIP_CASK_APPS == true ]]; then
        log_warning "SKIP-CASK-APPS MODE: GUI applications will be skipped - manual install recommended"
        echo ""
    fi
    
    if [[ $SKIP_ITERM_SETUP == true ]]; then
        printf "${YELLOW}[WARNING]${NC} SKIP-ITERM-SETUP MODE: iTerm2 profiles and colors setup will be skipped\n"
        printf "${CYAN}[INFO]${NC} To setup iTerm2 later, run without --skip-iterm-setup flag or run:\n"
        printf "${CYAN}[INFO]${NC}   %s/sys/hrt/conf/terminal/manage-iterm-profiles.sh install && import\n" "$SBRN_HOME"
        echo ""
    fi
    
    # Ask for confirmation
    if [[ "$AUTO_YES" == "true" ]]; then
        log_info "Auto-mode enabled: Starting full developer environment setup..."
        REPLY="y"
    else
        echo "Proceed with developer environment setup? [y/N]: "
        read -r REPLY
    fi
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        main
        echo ""
        show_system_summary
    else
        log_info "Installation cancelled"
        exit 0
    fi
