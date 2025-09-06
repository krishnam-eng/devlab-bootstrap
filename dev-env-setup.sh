#!/bin/zsh

################################################################################
# Goal: Portable Replicatable Scalable Developer Laboratory 
# Nature: Environment Setup Script
# Author: Balamurugan Krishnamoorthy
#
# This script sets up a complete macOS development environment including:
# 1. SBRN (Second Brain) directory structure
# 2. Homebrew package manager
# 3. Zsh with customizations
# 4. Essential development tools and applications
# 5. Git and GitHub configuration
# 6. Development IDEs and editors
#
# My Philosophy: Leverage Industry-Tested Standards for Effortless Productivity
#     This setup harnesses well-established principles, standards, and specifications 
#     that have been battle-tested across industries and proven effective for millions 
#     of developers and knowledge workers daily. By adopting these acclaimed standards 
#     (PARA, XDG, DAM, FHS), we eliminate the complexity of reinventing organizational 
#     systems and instead build upon decades of refinement.
#     
#     The result is a development environment that transforms file organization, 
#     tool management, and workflow efficiency from conscious decisions into second nature—
#     automating good practices by design, reducing cognitive overhead, and creating 
#     muscle memory for peak productivity. Each component becomes an unconscious habit 
#     that compounds productivity gains over time.
#
#     Key Benefits:
#     - Portability: Environment replicates identically across machines
#     - Scalability: Handles simple scripts to complex enterprise projects
#     - Maintainability: Industry standards ensure long-term compatibility
#     - Speed: Reduces setup time from days to minutes
#     - Consistency: Eliminates configuration drift and "works on my machine" issues
################################################################################

# Bash strict mode for robust error handling
set -euo pipefail

# Global variables
SKIP_CASK_APPS=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1"; }

################################################################################
# Main execution flow
function main() {
    log_info " Starting Developer Environment Setup for macOS..."
    echo ""
    
    # Step 1: Setup SBRN Directory Structure
    setup_sbrn_structure
    
    # Step 2: Install Homebrew
    install_homebrew
    
    # Step 3: Setup Zsh Environment
    setup_zsh_environment
    
    # Step 4: Install Essential CLI Tools
    install_essential_cli_tools
    
    # Step 5: Install Development Tools
    install_development_tools
    
    # Step 6: Install Programming Languages & Runtimes
    install_programming_languages
    
    # Step 7: Install IDEs and Editors
    install_ides_and_editors
    
    # Step 8: Setup Git and GitHub
    setup_git_and_github
    
    # Step 9: Configure VS Code Extensions
    configure_vscode_extensions
    
    # Step 10: Final Configuration
    final_configuration
    
    log_success "🎉 Developer Environment Setup completed successfully!"
}

################################################################################
# Step 1: Setup SBRN Directory Structure
# This model creates a scalable, portable directory structure following PARA (PKMS),
# DAM, FHS, and XDG principles and patterns.
#
# My Principle - Leveraging Industry-Tested Standards:
#     Harness well-established principles, standards, and specifications that have been 
#     battle-tested across industries and proven effective for millions of users daily.
#     By adopting these acclaimed standards (PARA, XDG, DAM, FHS), we eliminate the complexity 
#     of reinventing organizational systems and instead build upon decades of refinement.
#     
#     This approach transforms file organization from a conscious decision into second nature—
#     automating good practices by design, reducing cognitive overhead, and creating 
#     muscle memory for efficiency. The Home directory becomes a clean, purposeful space 
#     containing only system defaults plus dedicated management directories (Drives, sbrn),
#     while complex configurations and personal projects flow naturally into their 
#     designated hierarchies.
#     
#     The result: Speed, time savings, and mental clarity through systematic automation 
#     rather than ad-hoc complexity. These principles become unconscious habits that 
#     compound productivity gains over time.
# 
# PARA Principle (Created 2017 by Tiago Forte):
#     Problem Solved: Information overload and scattered digital assets causing wasted time
#                     (average knowledge worker spends 26% of day looking for information, 
#                     76 hours/year on misplaced files).
#     Core Principle: Organize by actionability, not subject - Projects (most actionable), 
#                     Areas (ongoing responsibilities), Resources (future reference), 
#                     Archives (inactive items).
#     Created during Forte's consulting work to manage knowledge efficiently in fast-paced environments.
#
# DAM Principle (Evolved from 1990s-2000s digital asset management):
#     Problem Solved: Organizations losing track of digital assets, version confusion, 
#                     inconsistent branding, and duplicated creative work causing millions 
#                     in wasted resources.
#     Core Principle: Centralized storage with metadata, version control, search capabilities, 
#                     and access permissions for all digital media and creative assets.
#     Developed as businesses transitioned from analog to digital workflows.
#
# XDG Principle (Created August 10, 2003 by freedesktop.org):
#     Problem Solved: Messy home directories cluttered with dotfiles (.config, .cache, .local)
#                     scattered inconsistently across UNIX-like systems, making user 
#                     environments unmanageable.
#     Core Principle: Define standardized base directories for config, cache, data, state, 
#                     and runtime files, ensuring clean separation and cross-application consistency.
#     Created to bring order to desktop Linux environments during the desktop wars era.
#
#
# FHS Principle (Created February 14, 1994 as FSSTND, renamed FHS 1997):
#     Problem Solved: Inconsistent filesystem layouts across UNIX variants causing compatibility 
#                     issues, software installation problems, and system administration complexity.
#     Core Principle: Standardize directory hierarchy (/bin, /etc, /usr, /var, /opt) ensuring
#                     predictable file locations, read-only system partitions, and 
#                     cross-distribution compatibility.
#     Created during early Linux distribution fragmentation to establish universal standards.
#
# Target Persona:
#     Knowledge workers, researchers, developers, creatives, consultants, and digital professionals
#     managing complex information workflows who require organized, searchable, and portable systems.
#     Organizations report 1.5 workdays monthly saved from improved information retrieval.
#
# Industry Adoption and Tool Support:
#     PARA: Supported by Notion, Obsidian, Logseq, Roam Research, implemented at 
#           World Bank, Genentech, Sunrun.
#     DAM:  Market leaders include Adobe Experience Manager, Bynder, Canto, with 88% cloud adoption rate.
#     XDG:  Native support in all major Linux distributions, libraries for Python, C++, Haskell, Qt.
#     FHS:  Universal standard ensuring cross-platform compatibility and long-term maintainability.
#     This hybrid approach provides enterprise-grade organization with personal workflow flexibility.
################################################################################
function setup_sbrn_structure() {
    log_step "📁 Setting up SBRN (Second Brain) directory structure..."

    # Hide standard user folders to reduce clutter before creating SBRN structure
    chflags hidden ~/Movies
    chflags hidden ~/Music
    chflags hidden ~/Desktop
    chflags hidden ~/Public
    chflags hidden ~/Pictures
    chflags hidden ~/Library

    # Set SBRN_HOME if not already set
    if [[ -z "${SBRN_HOME:-}" ]]; then
        export SBRN_HOME="$HOME/sbrn"
        log_info "Set SBRN_HOME to $SBRN_HOME"
    else
        log_success "SBRN_HOME already set: $SBRN_HOME"
    fi

    # Create primary PARA directories under sbrn home for Projects, Areas, Resources, Archives
    mkdir -p "$SBRN_HOME"
    mkdir -p "$SBRN_HOME/proj"/{corp,oss,learn,lab,exp}
    mkdir -p "$SBRN_HOME/area"/{work,personal,community,academic}
    mkdir -p "$SBRN_HOME/rsrc"/{notes,templates,refs}
    mkdir -p "$SBRN_HOME/arch"/{proj,area}

    # Create Cloud Drives directories for mounting cloud storage
    mkdir -p "$HOME/Drives"
    mkdir -p "$HOME/Drives"/{iCloud,GoogleDrive,OneDrive,Dropbox}
    log_info "Please mount your cloud drives (iCloud, Google Drive, OneDrive, Dropbox) under $HOME/Drives"

    # Create XDG config structure to keep the home directory clean of dotfiles and system clutter
    mkdir -p "$SBRN_HOME/sys"/{config,local/share,local/state,cache,bin}

    if [[ -z "${XDG_CONFIG_HOME:-}" ]]; then
        export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
    fi
    
    log_success "SBRN directory structure setup completed"
}

################################################################################
# Step 2: Install Homebrew
################################################################################
function install_homebrew() {
    log_step "🍺 Installing Homebrew package manager..."
    
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log_success "Homebrew already installed"
        brew --version | head -1
    fi
    
    # Update Homebrew
    log_info "Updating Homebrew package lists..."
    brew update
    
    log_success "Homebrew setup completed"
}

################################################################################
# Step 3: Setup Zsh Environment
################################################################################
function setup_zsh_environment() {
    log_step "🐚 Setting up Zsh environment with Oh My Zsh..."
    
    # Set ZSH installation directory
    local zsh_dir="$SBRN_HOME/sys/oh-my-zsh"
    
    # Install Oh My Zsh to custom directory
    if [[ ! -d "$zsh_dir" ]]; then
        export ZSH="$zsh_dir"
        log_info "Installing Oh My Zsh to $zsh_dir..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        log_success "Oh My Zsh already installed"
        export ZSH="$zsh_dir"
    fi
    
    # Install Powerlevel10k theme
    local p10k_dir="${ZSH}/custom/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        log_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    else
        log_success "Powerlevel10k already installed"
    fi
    
    # Install essential plugins
    install_zsh_plugins
    
    # Install Meslo Nerd Font
    install_meslo_font
    
    log_success "Zsh environment setup completed"
}

function install_zsh_plugins() {
    log_info "Installing essential Zsh plugins..."
    
    local custom_dir="${ZSH}/custom"
    
    # zsh-autosuggestions
    if [[ ! -d "$custom_dir/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$custom_dir/plugins/zsh-autosuggestions"
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$custom_dir/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting"
    fi
    
    # history-substring-search
    if [[ ! -d "$custom_dir/plugins/history-substring-search" ]]; then
        git clone https://github.com/zsh-users/zsh-history-substring-search.git "$custom_dir/plugins/history-substring-search"
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

################################################################################
# Step 4: Install Essential CLI Tools
################################################################################
function install_essential_cli_tools() {
    log_step "🛠️ Installing essential CLI tools..."
    
    # Essential CLI tools
    local cli_tools=(
        "tree:Directory tree visualization"
        "wget:File downloader"
        "curl:Data transfer tool (usually pre-installed)"
        "jq:JSON processor"
        "htop:System monitor"
        "tmux:Terminal multiplexer"
        "fzf:Fuzzy finder"
        "ripgrep:Fast text search (rg)"
        "bat:Better cat with syntax highlighting"
        "eza:Better ls with colors and icons"
        "fd:Better find"
        "tldr:Simplified man pages"
        "gh:GitHub CLI"
        "git-lfs:Git Large File Storage"
        "diff-so-fancy:Better Git diffs"
        "tig:Text-mode Git repository browser"
        "lazygit:Simple terminal UI for Git"
        "httpie:User-friendly HTTP client"
    )
    
    for tool_info in "${cli_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
    
    # Configure Git to use diff-so-fancy
    if command -v diff-so-fancy &>/dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" 2>/dev/null || true
    fi
    
    log_success "Essential CLI tools installation completed"
}

################################################################################
# Step 5: Install Development Tools
################################################################################
function install_development_tools() {
    log_step "🔧 Installing development tools..."
    
    # Build tools and package managers
    local dev_tools=(
        "maven:Java build tool"
        "gradle:Build automation tool"
        "helm:Kubernetes package manager"
        "kubectl:Kubernetes CLI"
        "docker:Container platform CLI"
        "docker-compose:Multi-container Docker applications"
        "awscli:AWS Command Line Interface"
        "azure-cli:Azure Command Line Interface"
        "terraform:Infrastructure as Code"
        "ansible:IT automation platform"
        "poetry:Python dependency management"
        "pipenv:Python development workflow"
        "yarn:JavaScript package manager"
    )
    
    for tool_info in "${dev_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
    
    log_success "Development tools installation completed"
}

################################################################################
# Step 6: Install Programming Languages & Runtimes
################################################################################
function install_programming_languages() {
    log_step "💻 Installing programming languages and runtimes..."
    
    # Programming languages and runtimes
    local languages=(
        "python@3.12:Python 3.12"
        "node:Node.js JavaScript runtime"
        "openjdk@17:OpenJDK 17"
        "openjdk@21:OpenJDK 21"
        "go:Go programming language"
        "rust:Rust programming language"
        "ruby:Ruby programming language"
    )
    
    for lang_info in "${languages[@]}"; do
        local lang="${lang_info%%:*}"
        local description="${lang_info#*:}"
        brew_install "$lang" "$description"
    done
    
    # Version managers
    local version_managers=(
        "pyenv:Python version management"
        "nvm:Node.js version management"
        "jenv:Java version management"
        "rbenv:Ruby version management"
    )
    
    for vm_info in "${version_managers[@]}"; do
        local vm="${vm_info%%:*}"
        local description="${vm_info#*:}"
        brew_install "$vm" "$description"
    done
    
    log_success "Programming languages and runtimes installation completed"
}

################################################################################
# Step 7: Install IDEs and Editors
################################################################################
function install_ides_and_editors() {
    log_step "📝 Installing IDEs and editors..."
    
    # IDEs and Editors via Homebrew Cask
    local ides=(
        "visual-studio-code:Visual Studio Code"
        "intellij-idea-ce:IntelliJ IDEA Community Edition"
        "pycharm-ce:PyCharm Community Edition"
        "cursor:Cursor AI-powered editor"
        "sublime-text:Sublime Text editor"
        "vim:Vim text editor (CLI)"
        "neovim:Neovim - modern Vim"
    )
    
    for ide_info in "${ides[@]}"; do
        local ide="${ide_info%%:*}"
        local description="${ide_info#*:}"
        if [[ "$ide" == "vim" || "$ide" == "neovim" ]]; then
            brew_install "$ide" "$description"
        else
            brew_cask_install "$ide" "$description"
        fi
    done
    
    # Install Jupyter Lab
    if command -v pip3 &>/dev/null; then
        if ! pip3 list | grep -q jupyterlab; then
            log_info "Installing JupyterLab..."
            pip3 install jupyterlab notebook
        else
            log_success "JupyterLab already installed"
        fi
    fi
    
    # Create symbolic links for command-line access
    create_ide_symlinks
    
    log_success "IDEs and editors installation completed"
}

function create_ide_symlinks() {
    log_info "Creating symbolic links for IDE command-line access..."
    
    local bin_dir="$SBRN_HOME/sys/bin"
    
    # VS Code
    if [[ -d "/Applications/Visual Studio Code.app" ]] && [[ ! -L "$bin_dir/code" ]]; then
        ln -sf "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" "$bin_dir/code"
        log_success "Created symlink for VS Code"
    fi
    
    # IntelliJ IDEA CE
    if [[ -d "/Applications/IntelliJ IDEA CE.app" ]] && [[ ! -L "$bin_dir/idea" ]]; then
        ln -sf "/Applications/IntelliJ IDEA CE.app/Contents/MacOS/idea" "$bin_dir/idea"
        log_success "Created symlink for IntelliJ IDEA CE"
    fi
    
    # Cursor
    if [[ -d "/Applications/Cursor.app" ]] && [[ ! -L "$bin_dir/cursor" ]]; then
        ln -sf "/Applications/Cursor.app/Contents/MacOS/Cursor" "$bin_dir/cursor"
        log_success "Created symlink for Cursor"
    fi
    
    # Add bin directory to PATH if not already there
    if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
        echo "export PATH=\"$bin_dir:\$PATH\"" >> ~/.zshrc
        export PATH="$bin_dir:$PATH"
        log_success "Added $bin_dir to PATH"
    fi
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
# Step 9: Configure VS Code Extensions
################################################################################
function configure_vscode_extensions() {
    log_step "🔌 Installing VS Code extensions..."
    
    if ! command -v code &>/dev/null; then
        log_warning "VS Code not found, skipping extension installation"
        return
    fi
    
    # Essential VS Code extensions
    local extensions=(
        # AI Assistants
        "GitHub.copilot:GitHub Copilot"
        "GitHub.copilot-chat:GitHub Copilot Chat"
        
        # Language Support
        "ms-python.python:Python"
        "ms-toolsai.jupyter:Jupyter"
        "vscjava.vscode-java-pack:Java Extension Pack"
        "vmware.vscode-spring-boot:Spring Boot Tools"
        "ms-vscode.vscode-typescript-next:TypeScript"
        "bradlc.vscode-tailwindcss:Tailwind CSS"
        
        # Code Quality & Formatting
        "esbenp.prettier-vscode:Prettier Code Formatter"
        "dbaeumer.vscode-eslint:ESLint"
        "ms-python.black-formatter:Black Python Formatter"
        "ms-python.flake8:Flake8 Linter"
        
        # Git & Version Control
        "eamodio.gitlens:GitLens"
        "mhutchie.git-graph:Git Graph"
        
        # Productivity
        "ms-vscode.vscode-json:JSON Language Features"
        "redhat.vscode-yaml:YAML"
        "yzhang.markdown-all-in-one:Markdown All in One"
        "ms-vscode-remote.remote-ssh:Remote - SSH"
        "ms-azuretools.vscode-docker:Docker"
        "ms-kubernetes-tools.vscode-kubernetes-tools:Kubernetes"
        
        # Themes & UI
        "PKief.material-icon-theme:Material Icon Theme"
        "GitHub.github-vscode-theme:GitHub Theme"
        "dracula-theme.theme-dracula:Dracula Official Theme"
    )
    
    for ext_info in "${extensions[@]}"; do
        local ext="${ext_info%%:*}"
        local name="${ext_info#*:}"
        
        if ! code --list-extensions | grep -q "^$ext$"; then
            log_info "Installing VS Code extension: $name"
            code --install-extension "$ext" --force
        else
            log_success "VS Code extension already installed: $name"
        fi
    done
    
    log_success "VS Code extensions installation completed"
}

################################################################################
# Step 10: Final Configuration
################################################################################
function final_configuration() {
    log_step "⚙️ Performing final configuration..."
    
    # Create/update .zshenv
    create_zshenv
    
    # Setup basic shell configuration
    setup_shell_config
    
    # Create useful aliases
    create_aliases
    
    # Setup development environment variables
    setup_dev_env_vars
    
    log_success "Final configuration completed"
}

function create_zshenv() {
    local zshenv_file="$HOME/.zshenv"
    
    if [[ ! -f "$zshenv_file" ]]; then
        log_info "Creating .zshenv configuration..."
        cat > "$zshenv_file" << 'EOF'
# SBRN (Second Brain) Configuration
export SBRN_HOME="$HOME/sbrn"
export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
export XDG_DATA_HOME="$SBRN_HOME/sys/local/share"
export XDG_STATE_HOME="$SBRN_HOME/sys/local/state"
export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"

# Zsh configuration directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Application-specific XDG compliance
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Homebrew paths for macOS on ARM
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

# Custom bin directory
export PATH="$SBRN_HOME/sys/bin:$PATH"
EOF
        log_success "Created .zshenv configuration"
    else
        log_success ".zshenv already exists"
    fi
}

function setup_shell_config() {
    local zshrc_file="$HOME/.zshrc"
    
    if [[ -f "$zshrc_file" ]]; then
        # Add SBRN configuration to existing .zshrc if not already there
        if ! grep -q "SBRN_HOME" "$zshrc_file"; then
            echo "" >> "$zshrc_file"
            echo "# SBRN Development Environment" >> "$zshrc_file"
            echo "export SBRN_HOME=\"$HOME/sbrn\"" >> "$zshrc_file"
            echo "export PATH=\"$SBRN_HOME/sys/bin:\$PATH\"" >> "$zshrc_file"
            log_success "Added SBRN configuration to .zshrc"
        fi
    fi
}

function create_aliases() {
    local aliases_file="$SBRN_HOME/sys/config/aliases"
    
    mkdir -p "$(dirname "$aliases_file")"
    
    cat > "$aliases_file" << 'EOF'
# SBRN Development Aliases

# Directory navigation
alias sbrn="cd $SBRN_HOME"
alias proj="cd $SBRN_HOME/proj"
alias notes="cd $SBRN_HOME/res/notes"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# Development shortcuts
alias ll="eza -la --icons"
alias la="eza -la --icons"
alias tree="tree -C"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Python development
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"

# Docker shortcuts
alias dc="docker-compose"
alias d="docker"

# Kubernetes shortcuts
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
EOF
    
    # Source aliases in .zshrc
    local zshrc_file="$HOME/.zshrc"
    if [[ -f "$zshrc_file" ]] && ! grep -q "source.*aliases" "$zshrc_file"; then
        echo "" >> "$zshrc_file"
        echo "# Load SBRN aliases" >> "$zshrc_file"
        echo "source $aliases_file" >> "$zshrc_file"
        log_success "Added aliases configuration to .zshrc"
    fi
}

function setup_dev_env_vars() {
    local env_file="$SBRN_HOME/sys/config/dev-env"
    
    mkdir -p "$(dirname "$env_file")"
    
    cat > "$env_file" << 'EOF'
# Development Environment Variables

# Java
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"

# Python
export PYTHONPATH="$SBRN_HOME/proj:$PYTHONPATH"

# Node.js
export NODE_ENV="development"

# Go
export GOPATH="$SBRN_HOME/sys/local/go"
export GOBIN="$GOPATH/bin"

# Editor preferences
export EDITOR="code"
export VISUAL="code"
EOF
    
    log_success "Created development environment variables"
}

################################################################################
# Utility Functions
################################################################################
function show_system_summary() {
    log_info "Developer Environment Summary:"
    echo "=================================="
    echo "macOS Version: $(sw_vers -productVersion)"
    echo "Hardware: $(sysctl -n hw.model)"
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
    echo "Shell: $SHELL"
    echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "Git: $(git --version 2>/dev/null || echo 'Not installed')"
    echo "Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
    echo "Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "Java: $(java --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "VS Code: $(code --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "SBRN_HOME: ${SBRN_HOME:-'Not set'}"
    echo "=================================="
}

# Function to show usage
show_usage() {
    local script_name="${0##*/}"
    echo "Usage: $script_name [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  --skip-cask-apps, -s    Skip Homebrew Cask app installations (recommend manual install)"
    echo "  --help, -h              Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  $script_name                      Run the full developer environment setup"
    echo "  $script_name --skip-cask-apps     Skip GUI app installations"
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --skip-cask-apps|-s)
                SKIP_CASK_APPS=true
                shift
                ;;
            --help|-h)
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


# Idempotent helper functions
brew_install() {
    local package="$1"
    local description="${2:-$package}"
    
    if ! command -v "$package" &>/dev/null && ! brew list "$package" &>/dev/null; then
        log_info "Installing $description..."
        brew install "$package"
    else
        log_success "$description already installed"
    fi
}

brew_cask_install() {
    local cask="$1"
    local description="${2:-$cask}"
    
    if [[ $SKIP_CASK_APPS == false ]]; then
        if ! brew list --cask "$cask" &>/dev/null; then
            log_info "Installing $description..."
            brew install --cask "$cask"
        else
            log_success "$description already installed"
        fi
    else
        log_info "Skipping cask installation: $description (manual install recommended)"
    fi
}

################################################################################
# Script Entry Point - Only execute when script is run directly, not sourced
################################################################################
if [[ "${BASH_SOURCE[0]:-$0}" == "${0}" ]] && [[ "$0" != *"zsh"* ]]; then
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
        log_warning "SKIP-CASK-APPS MODE: GUI applications will be skipped (manual install recommended)"
        echo ""
    fi
    
    # Ask for confirmation
    read -p "Proceed with developer environment setup? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        main
        echo ""
        show_system_summary
    else
        log_info "Installation cancelled"
        exit 0
    fi
fi
