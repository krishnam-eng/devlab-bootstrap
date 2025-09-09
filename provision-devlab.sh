#!/bin/zsh

################################################################################
# Goal: Portable Replicatable Scalable Developer Laboratory Setup for macOS
#
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

# Global variables
SKIP_CASK_APPS=false
SKIP_ITERM_SETUP=false

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
    log_info " Starting Developer Environment Setup for macOS..."
    echo ""

    confirm_and_run_step "Setup Directory Structure Hierarchy" setup_dir_struct_hierarchy show_directory_impact
    confirm_and_run_step "Install Homebrew" install_macos_package_manager show_homebrew_impact
    confirm_and_run_step "Setup Zsh Environment" setup_zsh_environment show_zsh_impact
    confirm_and_run_step "Install Essential CLI Tools" install_essential_cli_tools show_cli_tools_impact
    confirm_and_run_step "Install Development Tools" install_development_tools show_dev_tools_impact
    confirm_and_run_step "Install Programming Languages & Runtimes" install_programming_languages show_languages_impact
    confirm_and_run_step "Install IDEs and Editors" install_ides_and_editors show_ides_impact
    # confirm_and_run_step "Setup Git and GitHub" setup_git_and_github show_git_impact
}

function confirm_and_run_step() {
    local step_description="$1"
    local step_function="$2"
    local summary_function="${3:-}"

    echo "Proceed with $step_description? [y/N]: "
    read -r REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $step_function
        
        # Show step impact summary
        if [[ -n "$summary_function" ]]; then
            echo ""
            log_info "📋 Impact Summary for: $step_description"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            $summary_function
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
        fi
        
        log_success "$step_description completed successfully."
    else
        log_info "$step_description skipped."
    fi
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
function setup_dir_struct_hierarchy() {
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
    log_info "Please manually mount your cloud drives (iCloud, Google Drive, OneDrive, Dropbox) under $HOME/Drives"

    # Create XDG config structure to keep the home directory clean of dotfiles and system clutter
    mkdir -p "$SBRN_HOME/sys"/{config,local/share,local/state,cache,bin,etc}

    # Clone the HRT (Home Runtime Tools) repository if it doesn't exist
    if [[ ! -d "$SBRN_HOME/sys/hrt" ]]; then
        log_info "Cloning HRT repository to $SBRN_HOME/sys/hrt..."
        git clone --depth=1 https://github.com/krishnam-eng/sbrn-sys-hrt.git "$SBRN_HOME/sys/hrt"
        log_success "HRT repository cloned successfully"
    else
        log_success "HRT repository already exists at $SBRN_HOME/sys/hrt"
    fi

    # Setup XDG Base Directory Specification environment variables
    export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
    export XDG_DATA_HOME="$SBRN_HOME/sys/local/share"
    export XDG_STATE_HOME="$SBRN_HOME/sys/local/state"
    export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"
    
    # Create XDG-compliant directories
    mkdir -p "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"
    
    # Application-specific XDG compliance directories
    export ANDROID_HOME="$XDG_DATA_HOME/android"
    export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
    mkdir -p "$ANDROID_HOME" "$GRADLE_USER_HOME"
 
   log_success "SBRN directory structure setup completed"
}

################################################################################
# Step 2: Install Homebrew
################################################################################
function install_macos_package_manager() {
    log_step "🍺 Installing Homebrew package manager..."
    
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ $(uname -m) == "arm64" ]]; then
            local zprofile_file="$ZDOTDIR/.zprofile"
            
            # Only add if not already present
            if [[ ! -f "$zprofile_file" ]] || ! grep -q "brew shellenv" "$zprofile_file"; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$zprofile_file"
                log_success "Added Homebrew shellenv to .zprofile"
            else
                log_success "Homebrew shellenv already in .zprofile"
            fi
            
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log_success "Homebrew already installed"
        brew --version | head -1
        
        # Show currently installed packages
        show_installed_brew_packages
    fi
    
    # Update Homebrew and upgrade existing packages
    log_info "Updating Homebrew package lists..."
    brew update
    
    log_info "Upgrading existing Homebrew packages to latest versions..."
    echo "Do you want to run 'brew upgrade' to update all packages? [y/N]: "
    read -r REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew upgrade
        log_success "Homebrew packages upgraded."
    else
        log_info "brew upgrade skipped."
    fi
    
    log_success "Homebrew setup completed"
}

function show_installed_brew_packages() {
    log_info "📦 Currently installed Homebrew packages (leaf packages only):"
    
    if ! command -v brew &>/dev/null; then
        log_warning "Homebrew not found"
        return 1
    fi
    
    local leaves
    leaves=$(brew leaves 2>/dev/null)
    
    if [[ -n "$leaves" ]]; then
        # Convert to array and display in columns
        local packages_array=()
        while IFS= read -r package; do
            # Clean the package name and only add non-empty ones
            package=$(echo "$package" | tr -d '\r\n' | xargs)
            [[ -n "$package" ]] && packages_array+=("$package")
        done <<< "$leaves"
        
        # Display packages in 4 columns, 15 characters each
        local col_width=15
        local cols=4
        local total_packages=${#packages_array[@]}
        
        # Start fresh line and add initial padding
        printf "\n   "
        for ((i=1; i<=total_packages; i++)); do
            printf "%-${col_width}s" "${packages_array[i]}"
            
            # Add new line every 4 packages or at the end
            if (( i % cols == 0 )) || (( i == total_packages )); then
                printf "\n"
                # Add padding for next line if not the last
                (( i != total_packages )) && printf "   "
            fi
        done
        printf "\n"  # Ensure we end with a newline
    else
        echo "   • No packages installed"
    fi
}

################################################################################
# Step 3: Setup Zsh Environment
################################################################################
function setup_zsh_environment() {
    log_step "🐚 Setting up Zsh environment with Oh My Zsh..."
    
    # Set Zsh configuration directory (must be set before Oh My Zsh installation)
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    
    # Create XDG-compliant directories for Zsh files
    log_info "Creating XDG-compliant directories for Zsh files..."
    mkdir -p "$XDG_STATE_HOME/zsh/sessions"
    mkdir -p "$XDG_CACHE_HOME/zsh"
    log_success "Created Zsh XDG directories (state, cache, sessions)"
    
    # Set ZSH installation directory
    local zsh_dir="$SBRN_HOME/sys/etc/oh-my-zsh"
    
    # Install Oh My Zsh to custom directory
    if [[ ! -d "$zsh_dir" ]]; then
        export ZSH="$zsh_dir"
        log_info "Installing Oh My Zsh to $zsh_dir..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed successfully"

        # Restore original .zshrc file from Oh My Zsh backup
        log_info "Restoring original .zshrc configuration..."
        # Backup the Oh My Zsh generated file first
        cp "$XDG_CONFIG_HOME/zsh/.zshrc" "$XDG_CONFIG_HOME/zsh/.zshrc.oh-my-zsh-generated"
        # Restore the original configuration
        cp "$XDG_CONFIG_HOME/zsh/.zshrc.pre-oh-my-zsh" "$XDG_CONFIG_HOME/zsh/.zshrc"
        log_success "Original .zshrc configuration restored (Oh My Zsh version backed up as .zshrc.oh-my-zsh-generated)"
        
    else
        log_success "Oh My Zsh already installed"
        export ZSH="$zsh_dir"
    fi
    
    # Install Powerlevel10k theme
    local p10k_dir="${ZSH}/custom/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        log_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
        ln -sfn "$SBRN_HOME/sys/hrt/conf/p10k" "$XDG_CONFIG_HOME/p10k"
    else
        log_success "Powerlevel10k already installed"
    fi
    
    # Install essential plugins
    install_zsh_plugins
    
    # Install Meslo Nerd Font
    install_meslo_font
    
    # Setup Zsh configuration symlinks from HRT if available
    setup_zsh_configuration_links
    
    log_success "Zsh environment setup completed"
}

function install_zsh_plugins() {
    log_info "Installing essential Zsh plugins..."
    
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
    
    # Setup Zsh configuration symlinks if HRT conf directory exists
    if [[ -d "$SBRN_HOME/sys/hrt/conf" ]]; then
        # Symlink zsh configuration directory
        if [[ -d "$SBRN_HOME/sys/hrt/conf/zsh" ]]; then
            ln -sfn "$SBRN_HOME/sys/hrt/conf/zsh" "$XDG_CONFIG_HOME/zsh"
            log_success "Linked Zsh configuration directory"
        fi
        
        # Symlink .zshenv if it exists
        if [[ -f "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ]]; then
            ln -sfn "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ~/.zshenv
            log_success "Linked .zshenv configuration"
        fi
    else
        log_info "HRT configuration directory not found, skipping Zsh config links"
    fi
}

################################################################################
# Step 4: Install Essential CLI Tools
################################################################################
function install_essential_cli_tools() {
    log_step "🛠️ Installing essential CLI tools..."
    
    # 🖥️ Shell Enhancements & CLI Productivity
    install_shell_productivity_tools
    
    # 🌐 Networking, Security, & Transfer Tools
    install_networking_security_tools
    
    # 📊 Text, Regex, JSON, Data Tools
    install_text_data_tools
    
    log_success "Essential CLI tools installation completed"
}

function install_shell_productivity_tools() {
    log_info "Installing 🖥️ Shell Enhancements & CLI Productivity tools..."
    
    # Core shell enhancement tools (ordered by popularity)
    local shell_tools=(
        "coreutils: GNU core utilities (g-prefixed)"
        "tree: Directory tree visualization"
        "fzf: Command-line fuzzy finder"
        "tmux: Terminal multiplexer"
        "screen: Terminal multiplexer with VT100/ANSI terminal emulation"        
        "htop: Interactive process viewer"
        "bat: Cat clone with syntax highlighting and Git integration"
        "fd: Simple, fast and user-friendly alternative to find"
        "tldr: Simplified and community-driven man pages"
        "eza: Modern replacement for ls with colors and icons"
        "zoxide: Smarter cd command with frecency"
        "watch: Execute a program periodically, showing output fullscreen"
        "ncdu: NCurses Disk Usage - disk usage analyzer"
        "glances: System monitoring tool"
        "lsd: LSDeluxe - next gen ls command"
        "ctop: Top-like interface for container metrics"
        "autoenv: Directory-based environments"
        "atuin: Improved shell history for zsh, bash, fish and nushell"
        "direnv: Load/unload environment variables based on PWD"
        "ack: Search tool like grep, but optimized for programmers"
        "broot: New way to see and navigate directory trees"
        "figlet: Banner-like program prints strings as ASCII art"
        "lolcat: Rainbows and unicorns in your console"
        "ranger: File browser"
        "as-tree: Print a list of paths as a tree of paths"
        "agedu: Unix utility for tracking down wasted disk space"
        "zsh-autosuggestions: Fish-like fast/unobtrusive autosuggestions for zsh"
        "zsh-completions: Additional completion definitions for zsh"
        "bash-completion: Programmable completion for Bash 3.2"
        "fish: User-friendly command-line shell for UNIX-like operating systems"
    )
    
    for tool_info in "${shell_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}


function install_networking_security_tools() {
    log_info "Installing 🌐 Networking, Security, & Transfer tools..."
    
    local network_tools=(
        "curl: Command-line tool for transferring data with URL syntax"
        "wget: Internet file retriever"
        "httpie: User-friendly command-line HTTP client"
        "netcat: Utility for reading/writing network connections"
        "gnupg: GNU Pretty Good Privacy (PGP) package"
        "certbot: Tool to obtain certs from Let's Encrypt and autoenable HTTPS"
        "telnet: User interface to the TELNET protocol"
    )
    
    for tool_info in "${network_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_text_data_tools() {
    log_info "Installing 📊 Text, Regex, JSON, Data tools..."
    
    # CLI editors via Homebrew
    local cli_editors=(
        "vim: Vi IMproved - enhanced version of the vi editor"
        "neovim: Ambitious Vim-fork focused on extensibility and agility"
        "emacs: GNU Emacs text editor"
        "nano: Free (GNU) replacement for the Pico text editor"
    )

    local text_tools=(
        "jq: Lightweight and flexible command-line JSON processor"
        "ripgrep: Search tool like grep and The Silver Searcher"
        "grep: GNU grep, egrep and fgrep"
        "fx: Terminal JSON viewer"
        "jid: Json incremental digger"
        "colordiff: Color-highlighted diff(1) output"
        "base64: Encode and decode base64 files"
        "base91: Utility to encode and decode base91 files"
        "python-yq: Command-line YAML and XML processor that wraps jq"
        "ccat: Like cat but displays content with syntax highlighting"
    )
    
    for tool_info in "${text_tools[@]}" "${cli_editors[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done

    # Create ripgrep config directory and link configuration
    ln -sfn "$SBRN_HOME/sys/hrt/conf/ripgrep" "$XDG_CONFIG_HOME/ripgrep"
}

################################################################################
# Step 5: Install Development Tools
################################################################################
function install_development_tools() {
    log_step "🔧 Installing development tools..."
    
    # 🔧 Developer Tools (VCS, Repos, Git Helpers)
    install_git_and_vcs_tools
    
    # ☁️ Cloud & Containers
    install_cloud_container_tools
    
    # 🎨 Graphics, OCR, and UI Libraries
    install_graphics_ocr_libraries

    # 🛠️ Additional Development & API tools
    install_additional_dev_tools

    # Configure Git to use diff-so-fancy
    if command -v diff-so-fancy &>/dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" 2>/dev/null || true
    fi
        
    log_success "Development tools installation completed"
}

function install_git_and_vcs_tools() {
    log_info "Installing 🔧 Developer Tools (VCS, Repos, Git Helpers)..."
    
    local git_tools=(
        "git: Distributed revision control system"
        "git-extras: Small git utilities"
        "git-lfs: Git extension for versioning large files"
        "gh: GitHub command-line tool"
        "ghq: Remote repository management made easy"
        "diff-so-fancy: Good-lookin' diffs with diff-highlight and more"
        "delta: Syntax-highlighting pager for git, diff, and grep output"
        "tig: Text-mode interface for git"
        "lazygit: Simple terminal UI for git commands"
        "git-gui: Tcl/Tk based graphical user interface to Git"
        "gitk: The Git repository browser"        
        "gibo: Fast access to .gitignore boilerplates"
    )
    
    for tool_info in "${git_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done

    ln -sfn "$SBRN_HOME/sys/hrt/conf/git" "$XDG_CONFIG_HOME/git"
}

function install_cloud_container_tools() {
    log_info "Installing ☁️ Cloud & Containers tools..."
    
    local cloud_tools=(
        "docker: Platform for developing, shipping, and running applications"
        "docker-compose: Isolated development environments using Docker"
        "colima: Container runtimes on macOS (and Linux) with minimal setup"
        "kubernetes-cli: Kubernetes command-line interface"
        "helm: Kubernetes package manager"
        "awscli: Official Amazon AWS command-line interface"
        "dive: Tool for exploring each layer in a docker image"
        "dockviz: Visualizing docker data"
        "k9s: Kubernetes CLI To Manage Your Clusters In Style"
        "kubecolor: Colorize your kubectl output"
        "kompose: Tool to move from docker-compose to Kubernetes"
        "krew: Package manager for kubectl plugins"
        "kube-ps1: Kubernetes prompt info for bash and zsh"
        "kubebuilder: SDK for building Kubernetes APIs using CRDs"
        "kustomize: Template-free customization of Kubernetes YAML manifests"
        "istioctl: Istio configuration command-line utility"
        "minikube: Run a Kubernetes cluster locally"
        "terraform: Tool to build, change, and version infrastructure"
    )
    
    for tool_info in "${cloud_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_graphics_ocr_libraries() {
    log_info "Installing 🎨 Graphics, Images, and UI libraries..."
    
    local graphics_tools=(
        "librsvg: Library to render SVG files using Cairo"
        "gtk+3: Toolkit for creating graphical user interfaces"
        "ghostscript: Interpreter for PostScript and PDF"
        "graphviz: Graph visualization software from AT&T and Bell Labs"
        "guile: GNU Ubiquitous Intelligent Language for Extensions"
        "pcre: Perl compatible regular expressions library"
        "xerces-c: Validating XML parser"
        "pygobject3: GNOME Python bindings (based on GObject Introspection)"
    )
    
    for tool_info in "${graphics_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_additional_dev_tools() {
    log_info "Installing 🛠️ Additional Development & API tools..."
    
    local dev_tools=(
        "jwt-cli: Super fast CLI tool to decode and encode JWTs built in Rust"
        "newman: Command-line collection runner for Postman"
        "openapi-generator: Generate clients, server & docs from an OpenAPI spec (v2, v3)"
        "operator-sdk: SDK for building Kubernetes applications"
        "hugo: Configurable static site generator"
        "logrotate: Rotates, compresses, and mails system logs"
        "rtmpdump: Tool for downloading RTMP streaming media"
        "sftpgo: Fully featured SFTP server with optional HTTP/S, FTP/S and WebDAV support"
        "etcd: Key value store for shared configuration and service discovery"
        "postgresql@15: Object-relational database system"
        "redis: Persistent key-value database, with built-in net interface"
        "nginx: HTTP(S) server and reverse proxy, and IMAP/POP3 proxy server"
    )
    
    for tool_info in "${dev_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

################################################################################
# Step 6: Install Programming Languages & Runtimes
################################################################################
function install_programming_languages() {
    log_step "💻 Installing programming languages and runtimes..."
    
    # Core Programming Languages & Runtimes
    install_core_programming_languages
    
    # Version Managers
    install_version_managers
    
    # Package, and Build Tools
    install_build_automation_tools
    
    log_success "Programming languages and runtimes installation completed"
}

function install_core_programming_languages() {
    log_info "Installing core programming languages and runtimes..."
    
    local languages=(
        "openjdk@17: Open-source implementation of Java Platform, Standard Edition (v17)"
        "openjdk@21: Open-source implementation of Java Platform, Standard Edition (v21)"
        "python@3.13: Python 3.13 programming language"
        "perl: Highly capable, feature-rich programming language"
        "node: Platform built on V8 to build network applications"
        "go: Open source programming language to build simple/reliable/efficient software"
        "rust: Safe, concurrent, practical language"
    )
    
    for lang_info in "${languages[@]}"; do
        local lang="${lang_info%%:*}"
        local description="${lang_info#*:}"
        brew_install "$lang" "$description"
    done
}

function install_version_managers() {
    log_info "Installing version managers..."
    
    # Clean up any existing jenv home directory configuration
    if [[ -d ~/.jenv ]] || [[ -L ~/.jenv ]]; then
        log_info "Cleaning up existing jenv configuration in home directory..."
        # Backup existing jenv data if it's a real directory
        if [[ -d ~/.jenv ]] && [[ ! -L ~/.jenv ]]; then
            if [[ ! -d "$XDG_DATA_HOME/jenv" ]]; then
                mkdir -p "$XDG_DATA_HOME"
                mv ~/.jenv "$XDG_DATA_HOME/jenv"
                log_success "Moved existing jenv configuration to XDG data directory"
            else
                log_warning "XDG jenv directory already exists, removing home directory version"
                rm -rf ~/.jenv
            fi
        else
            # Remove symlink
            rm ~/.jenv
            log_success "Removed jenv symlink from home directory"
        fi
    fi
    
    local version_managers=(
        "jenv: Java version management"
        "uv: python virtual environment management"
        "nvm: Node Version Manager"
    )
    # Currently, jenv does not natively support using the XDG Base Directory Specification
    # Move existing jenv configuration to XDG config directory if it exists
    # This at least keeps the data physically away from your $HOME, but jenv itself still expects to “see” `~/.jenv`
    [[ -d ~/.jenv ]] && [[ ! -L ~/.jenv ]] && [[ ! -d "$XDG_CONFIG_HOME/jenv" ]] && {
        mkdir -p "$XDG_CONFIG_HOME"
        mv ~/.jenv "$XDG_CONFIG_HOME/jenv"
        ln -s "$XDG_CONFIG_HOME/jenv" ~/.jenv
        log_success "Moved jenv configuration to XDG-compliant location"
    }

    for vm_info in "${version_managers[@]}"; do
        local vm="${vm_info%%:*}"
        local description="${vm_info#*:}"
        brew_install "$vm" "$description"
    done
    
    # Configure jenv with Java versions using XDG-compliant paths
    if command -v jenv &>/dev/null; then
        log_info "Configuring jenv with Java versions (XDG-compliant)..."
        
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
        
        log_success "jenv configured with XDG-compliant path: $JENV_ROOT"
    else
        log_warning "jenv not found, skipping Java version management setup"
    fi
    
    # Configure NVM (Node Version Manager)
    if command -v nvm &>/dev/null || [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
        log_info "Configuring NVM (Node Version Manager)..."
        
        # Create NVM working directory using XDG specification
        # This prevents destruction during Homebrew upgrades
        if [[ ! -d "$NVM_DIR" ]]; then
            mkdir -p "$NVM_DIR"
            log_success "Created NVM directory at $NVM_DIR"
        fi
        
        # Source NVM if available (for immediate use in this script)
        if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
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
        fi
    else
        log_warning "NVM not found - install with: brew install nvm"
    fi
}

function install_build_automation_tools() {
    log_info "Installing additional build and automation tools..."
    
    local build_tools=(
        "maven: Java-based project management"
        "gradle: Build automation tool based on Groovy and Kotlin"        
        "poetry: Python package and dependency manager"
        "pipx: Install and run Python applications in isolated environments"
        "yarn: JavaScript package manager"
    )
    
    for tool_info in "${build_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

################################################################################
# Step 7: Install IDEs and Editors
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
    
    # IDEs and Editors via Homebrew Cask
    local ides=(
        "visual-studio-code: Visual Studio Code - Microsoft's free code editor"
        "intellij-idea-ce: IntelliJ IDEA Community Edition - JetBrains Java IDE"
        "pycharm-ce: PyCharm Community Edition - JetBrains Python IDE"
        "cursor: Cursor - AI-powered code editor"
        "iterm2: iTerm2 - Terminal emulator for macOS"
    )
    
    for ide_info in "${ides[@]}"; do
        local ide="${ide_info%%:*}"
        local description="${ide_info#*:}"
        brew_cask_install "$ide" "$description"
    done

    # Link VSCode settings from HRT configuration if available
    mkdir -p "$SBRN_HOME/sys/config/code/user"
    ln -sfn $SBRN_HOME/sys/hrt/conf/vscode/settings.json $SBRN_HOME/sys/config/code/user/settings.json
    ln -sfn "${XDG_CONFIG_HOME:-$HOME/.config}/code/user" "$HOME/Library/Application Support/Code/User"
    
    # Install VSCode extensions from HRT configuration
    setup_vscode_extensions
    
    # Setup iTerm2 profiles and color schemes from HRT configuration
    setup_iterm_profiles
}

function install_productivity_apps() {
    log_info "Installing productivity and development support applications..."
    
    # Productivity and Development Support Apps via Homebrew Cask
    local productivity_apps=(
        "notion: Notion - All-in-one workspace for notes, docs, and collaboration"
        "obsidian: Obsidian - Knowledge management and note-taking app"
        "figma: Figma - Collaborative interface design tool"
        "slack: Slack - Team communication and collaboration"
        "github: GitHub Desktop - Git GUI client for GitHub"
        "postman: Postman - API development and testing platform"
        "insomnia: Insomnia - REST API client and testing tool"
        "dbeaver-community: DBeaver Community - Universal database tool"
        "pgadmin4: pgAdmin 4 - PostgreSQL administration and development platform"
        "rapidapi: RapidAPI - API testing and development tool"
        # "microsoft-edge: Microsoft Edge - Web browser" # Pre-installed on corp machines
        # "virtualbox: VirtualBox - Virtual machine software" # Sudoer rights needed
        # "zoom: Zoom - Video conferencing and online meetings" # Sudoer rights needed
    )
    
    for app_info in "${productivity_apps[@]}"; do
        local app="${app_info%%:*}"
        local description="${app_info#*:}"
        brew_cask_install "$app" "$description"
    done
}

function install_python_notebook_env_tools() {
    log_info "Installing development environment and data science tools..."
    
    # Install pipx first for Python applications
    brew_install "pipx" "Install and run Python applications in isolated environments"

    log_info "Installing Jupyter ecosystem using pipx and Homebrew..."
    
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
    echo "✅ 🖥️ Shell Enhancements & CLI Productivity tools installed:"
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
    echo "✅ 🌐 Networking, Security, & Transfer tools:"
    echo "   • curl (command-line data transfer tool)"
    echo "   • wget (internet file retriever)"
    echo "   • httpie (user-friendly HTTP client)"
    echo "   • netcat (networking utility)"
    echo "   • gnupg (GNU Pretty Good Privacy PGP package)"
    echo "   • certbot (tool to obtain certs from Let's Encrypt)"
    echo "   • telnet (user interface to the TELNET protocol)"
    echo "✅ 📊 Text, Regex, JSON, Data tools & CLI Editors:"
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
    echo "✅ 🔧 Developer Tools (VCS, Repos, Git Helpers):"
    echo "   • git (distributed revision control system)"
    echo "   • git-extras (small git utilities)"
    echo "   • git-lfs (Git extension for versioning large files)"
    echo "   • gh (GitHub command-line tool)"
    echo "   • gibo (fast access to .gitignore boilerplates)"
    echo "   • ghq (remote repository management)"
    echo "   • lazygit (simple terminal UI for git commands)"
    echo "   • tig (text-mode interface for git)"
    echo "   • diff-so-fancy (good-lookin' diffs with diff-highlight)"
    echo "   • git-gui (Tcl/Tk based graphical user interface to Git)"
    echo "   • gitk (Git repository browser)"
    echo "   • Git configured to use diff-so-fancy for enhanced diffs"
    echo "✅ ☁️ Cloud & Containers:"
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
    echo "✅ 🎨 Graphics, Images, and UI Libraries:"
    echo "   • librsvg (library to render SVG files using Cairo)"
    echo "   • gtk+3 (toolkit for creating graphical user interfaces)"
    echo "   • ghostscript (interpreter for PostScript and PDF)"
    echo "   • graphviz (graph visualization software from AT&T and Bell Labs)"
    echo "   • guile (GNU Ubiquitous Intelligent Language for Extensions)"
    echo "   • pcre (Perl compatible regular expressions library)"
    echo "   • xerces-c (validating XML parser)"
    echo "   • pygobject3 (GNOME Python bindings based on GObject Introspection)"
    echo "✅ 🛠️ Additional Development & API tools:"
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
    echo "✅ Version Managers:"
    echo "   • jenv (Java version management)"
    echo "   • uv (Python virtual environment management)"
    echo "   • nvm (Node Version Manager - Homebrew install with XDG-compliant configuration)"
    echo "✅ Build & Automation Tools:"
    echo "   • maven (Java-based project management)"
    echo "   • gradle (build automation tool based on Groovy and Kotlin)"
    echo "   • poetry (Python package and dependency manager)"
    echo "   • pipx (Install and run Python applications in isolated environments)"
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
        echo "   • JupyterLab installed via pipx (isolated Python environment)"
    elif command -v pipx &>/dev/null; then
        # Check if JupyterLab is already installed via pipx
        if pipx list 2>/dev/null | grep -q jupyterlab; then
            echo "   • JupyterLab already installed via pipx (isolated environment)"
        else
            echo "   • pipx available for installing Python applications (including JupyterLab)"
            echo "   • Run 'pipx install jupyterlab' for isolated Jupyter installation"
        fi
    else
        echo "   • Note: For Jupyter, create virtual environments to avoid system conflicts"
    fi
    echo "   • git-gui, gitk (Git graphical tools)"
    echo "✅ Command-line shortcuts created in: $SBRN_HOME/sys/bin"
    
    # Show iTerm2 setup status
    if [[ "$SKIP_ITERM_SETUP" == "true" ]]; then
        echo "⚠️  iTerm2 setup skipped (--skip-iterm-setup flag active)"
    elif [[ -d "/Applications/iTerm.app" ]]; then
        echo "✅ iTerm2 terminal setup:"
        local colors_dir="$SBRN_HOME/sys/hrt/conf/terminal/colors"
        local profiles_dir="$SBRN_HOME/sys/hrt/conf/terminal/profiles"
        local iterm_script="$SBRN_HOME/sys/hrt/conf/terminal/manage-iterm-profiles.sh"
        
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
    log_info "Setting up VS Code extensions from configuration..."
    
    # Check if VS Code CLI is available
    if ! command -v code &> /dev/null; then
        log_warning "VS Code CLI 'code' command not found. Skipping extension installation."
        log_info "To enable: Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
        return 0
    fi
    
    local extensions_script="$SBRN_HOME/sys/hrt/conf/vscode/manage-extensions.sh"
    local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
    
    # Check if extension configuration exists
    if [[ ! -f "$extensions_file" ]]; then
        log_warning "VS Code extensions.txt not found. Creating from current installations..."
        if [[ -x "$extensions_script" ]]; then
            "$extensions_script" capture
        else
            log_error "Extensions management script not found or not executable"
            return 1
        fi
    fi
    
    # Install missing extensions
    if [[ -x "$extensions_script" && -f "$extensions_file" ]]; then
        log_info "Installing VS Code extensions from configuration..."
        "$extensions_script" install
        log_success "VS Code extensions setup completed"
    else
        log_error "VS Code extension setup failed - missing script or configuration"
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
    
    local iterm_script="$SBRN_HOME/sys/hrt/conf/terminal/manage-iterm-profiles.sh"
    local colors_dir="$SBRN_HOME/sys/hrt/conf/terminal/colors"
    local profiles_dir="$SBRN_HOME/sys/hrt/conf/terminal/profiles"
    
    # Check if iTerm2 is installed
    if [[ ! -d "/Applications/iTerm.app" ]]; then
        log_warning "iTerm2 not found. Installing via Homebrew..."
        brew_cask_install "iterm2" "iTerm2 - Terminal emulator for macOS"
    fi
    
    # Check if management script exists and is executable
    if [[ ! -x "$iterm_script" ]]; then
        log_warning "iTerm profile management script not found or not executable"
        if [[ -f "$iterm_script" ]]; then
            chmod +x "$iterm_script"
            log_info "Made iTerm management script executable"
        else
            log_error "iTerm management script not found: $iterm_script"
            return 1
        fi
    fi
    
    # Install color schemes if available
    if [[ -d "$colors_dir" ]]; then
        local color_count=$(find "$colors_dir" -name "*.itermcolors" | wc -l | tr -d ' ')
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
        local profile_count=$(find "$profiles_dir" -name "*.json" | wc -l | tr -d ' ')
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
            echo "Import iTerm2 profiles automatically? [y/N]: "
            read -r REPLY
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
}

function show_vscode_impact() {
    if command -v code &>/dev/null; then
        local ext_count=$(code --list-extensions | wc -l)
        local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
        local configured_count=0
        
        if [[ -f "$extensions_file" ]]; then
            configured_count=$(grep -v '^#' "$extensions_file" | grep -v '^$' | wc -l)
        fi
        
        echo "✅ VS Code extensions: $ext_count installed, $configured_count configured"
        echo "   • Settings: Linked from $SBRN_HOME/sys/hrt/conf/vscode/settings.json"
        echo "   • Extensions: Managed via $SBRN_HOME/sys/hrt/conf/vscode/manage-extensions.sh"
        echo "   • Configuration: $extensions_file"
        echo "   • Management commands:"
        echo "     - Capture current: ./manage-extensions.sh capture"
        echo "     - Install missing: ./manage-extensions.sh install" 
        echo "     - Sync all: ./manage-extensions.sh sync"
    else
        echo "⚠️  VS Code not found, extensions skipped"
        echo "   • Install VS Code and run provision script again"
        echo "   • Or manually run: $SBRN_HOME/sys/hrt/conf/vscode/manage-extensions.sh install"
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
    echo "✅ PATH updated to include: $SBRN_HOME/sys/bin"
    echo "✅ Search tool enhancements:"
    echo "   • ripgrep with smart defaults and file type exclusions"
    echo "   • grep with color output enabled"
    echo "   • custom aliases for common search patterns (rg, rgcode, rgconfig, etc.)"
}

################################################################################
# Utility Functions
################################################################################

# Helper function to install Homebrew packages
function brew_install() {
    local package="$1"
    local description="${2:-}"
    
    if brew list "$package" &>/dev/null; then
        log_success "$package already installed"
    else
        log_info "Installing $package..."
        if [[ -n "$description" ]]; then
            log_info "  → $description"
        fi
        
        local install_exit_code=0
        brew install "$package" >/dev/null 2>&1 || install_exit_code=$?
        
        if [[ $install_exit_code -eq 0 ]]; then
            log_success "$package installed successfully"
        else
            # Installation failed - log error but continue
            log_warning "Failed to install $package via Homebrew"
            log_info "  → You can manually install $package or check if it's already available"
            
            # Try to detect if the package was actually installed despite the error
            sleep 1
            if brew list "$package" &>/dev/null; then
                log_success "$package installation completed (detected via brew list)"
            elif command -v "$package" &>/dev/null; then
                log_success "$package is available (found in system PATH)"
            fi
        fi
    fi
}

# Helper function to install Homebrew Cask applications
function brew_cask_install() {
    local cask="$1"
    local description="${2:-}"
    
    # Early return if cask apps are disabled
    [[ "$SKIP_CASK_APPS" == "true" ]] && {
        log_info "Skipping cask $cask (SKIP_CASK_APPS=true)"
        return 0
    }
    
    # Check if already installed via Homebrew first (fastest check)
    if brew list --cask "$cask" &>/dev/null; then
        log_success "$cask already installed via Homebrew"
        return 0
    fi
    
    # Get expected app name and check if manually installed
    local app_name
    app_name=$(get_app_name_for_cask "$cask")
    
    if [[ -n "$app_name" ]] && is_app_installed "$app_name"; then
        log_success "$cask already installed manually (found $app_name)"
        return 0
    fi
    
    # Proceed with installation
    _install_cask "$cask" "$description" "$app_name"
}

# Helper function to map cask names to app names
function get_app_name_for_cask() {
    local cask="$1"
    
    # Use associative array for cleaner mapping
    declare -A cask_to_app_map=(
        ["visual-studio-code"]="Visual Studio Code.app"
        ["intellij-idea-ce"]="IntelliJ IDEA CE.app" 
        ["pycharm-ce"]="PyCharm CE.app"
        ["cursor"]="Cursor.app"
        ["notion"]="Notion.app"
        ["obsidian"]="Obsidian.app"
        ["figma"]="Figma.app"
        ["slack"]="Slack.app"
        ["github"]="GitHub Desktop.app"
        ["postman"]="Postman.app"
        ["insomnia"]="Insomnia.app"
        ["dbeaver-community"]="DBeaver.app"
        ["pgadmin4"]="pgAdmin 4.app"
        ["rapidapi"]="RapidAPI.app"
        ["microsoft-edge"]="Microsoft Edge.app"
        ["virtualbox"]="VirtualBox.app"
        ["zoom"]="zoom.us.app"
    )
    
    echo "${cask_to_app_map[$cask]:-}"
}

# Helper function to check if app is installed in standard locations
function is_app_installed() {
    local app_name="$1"
    [[ -z "$app_name" ]] && return 1
    
    local locations=("/Applications" "$HOME/Applications")
    local location
    
    for location in "${locations[@]}"; do
        [[ -d "$location/$app_name" ]] && return 0
    done
    
    return 1
}

# Helper function to perform the actual cask installation
function _install_cask() {
    local cask="$1"
    local description="$2"
    local app_name="$3"
    
    log_info "Installing $cask..."
    [[ -n "$description" ]] && log_info "  → $description"
    
    local install_output install_exit_code=0
    install_output=$(brew install --cask "$cask" 2>&1) || install_exit_code=$?
    
    if [[ $install_exit_code -eq 0 ]]; then
        log_success "$cask installed successfully"
        return 0
    fi
    
    # Handle installation failures gracefully
    _handle_cask_install_failure "$cask" "$app_name" "$install_output"
}

# Helper function to handle cask installation failures
function _handle_cask_install_failure() {
    local cask="$1"
    local app_name="$2" 
    local install_output="$3"
    
    if [[ "$install_output" == *"already an App at"* ]]; then
        log_success "$cask app already exists - installation skipped"
        
        # Extract and verify app location from error message
        local existing_path
        existing_path=$(echo "$install_output" | grep -o "'/[^']*\.app'" | tr -d "'")
        [[ -n "$existing_path" && -d "$existing_path" ]] && 
            log_info "  → Found existing app at: $existing_path"
    else
        log_warning "Failed to install $cask via Homebrew"
        log_info "  → Error: $(echo "$install_output" | tail -1)"
        log_info "  → You can manually install $cask or check if it's already installed"
    fi
    
    # Final verification after failure
    _verify_cask_post_failure "$cask" "$app_name"
}

# Helper function to verify cask installation after apparent failure
function _verify_cask_post_failure() {
    local cask="$1"
    local app_name="$2"
    
    # Brief pause to allow filesystem to settle
    sleep 1
    
    if brew list --cask "$cask" &>/dev/null; then
        log_success "$cask installation completed (detected via brew list)"
    elif [[ -n "$app_name" ]] && is_app_installed "$app_name"; then
        log_success "$cask app is available: $app_name"
    fi
}

# Helper function to create a Python development environment
function create_python_dev_env() {
    local env_name="${1:-jupyter-dev}"
    local env_path="$HOME/.local/share/python-envs/$env_name"
    
    log_info "Creating Python development environment: $env_name"
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$env_path")"
    
    # Create virtual environment
    if [[ ! -d "$env_path" ]]; then
        python3 -m venv "$env_path"
        log_success "Created virtual environment at: $env_path"
    else
        log_info "Virtual environment already exists at: $env_path"
    fi
    
    # Activate and install common packages
    source "$env_path/bin/activate"
    
    # Upgrade pip first
    pip install --upgrade pip
    
    # Install common data science and development packages
    local packages=(
        "jupyter"
        "jupyterlab"
        "notebook"
        "ipywidgets"
        "jupyter-console"
        "nbconvert"
        "ipykernel"
        "matplotlib"
        "pandas"
        "numpy"
        "requests"
    )
    
    log_info "Installing Python packages in virtual environment..."
    for package in "${packages[@]}"; do
        pip install "$package"
    done
    
    # Add kernel to Jupyter
    python -m ipykernel install --user --name="$env_name" --display-name="Python ($env_name)"
    
    deactivate
    
    log_success "Python development environment '$env_name' created successfully!"
    log_info "To use this environment:"
    log_info "  source $env_path/bin/activate"
    log_info "  # Your work here"
    log_info "  deactivate"
    log_info ""
    log_info "Jupyter kernel '$env_name' is now available in JupyterLab"
}

function show_system_summary() {
    log_info "🖥️  Developer Environment Status Check"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # System Information
    echo "📊 System Information:"
    echo "   • macOS Version: $(sw_vers -productVersion)"
    echo "   • Hardware: $(sysctl -n hw.model)"
    echo "   • Architecture: $(uname -m)"
    echo "   • CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "   • Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
    echo "   • Shell: $SHELL"
    echo ""
    
    # SBRN Directory Structure Status
    echo "📁 SBRN Directory Structure:"
    check_sbrn_structure
    echo ""
    
    # Package Manager Status
    echo "📦 Package Manager:"
    check_homebrew_status
    echo ""
    
    # Shell Environment Status
    echo "🐚 Shell Environment:"
    check_zsh_environment_status
    echo ""
    
    # Essential CLI Tools Status
    echo "🛠️  Essential CLI Tools:"
    check_cli_tools_status
    echo ""
    
    # Development Tools Status
    echo "🔧 Development Tools:"
    check_dev_tools_status
    echo ""
    
    # Programming Languages Status
    echo "💻 Programming Languages & Runtimes:"
    check_programming_languages_status
    echo ""
    
    # IDEs and Editors Status
    echo "📝 IDEs and Editors:"
    check_ides_status
    echo ""

    # Productivity Apps Status
    echo "📦 Productivity Apps:"
    check_productivity_apps_status
    echo ""
    
    # Application CLI Symlinks Status
    echo "🔗 Application CLI Symlinks:"
    check_app_cli_symlinks_status
    echo ""
    
    # Git Configuration Status
    echo "� Git Configuration:"
    check_git_status
    echo ""
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

function check_sbrn_structure() {
    local sbrn_home="${SBRN_HOME:-$HOME/sbrn}"
    
    if [[ -d "$sbrn_home" ]]; then
        echo "   ✅ SBRN_HOME: $sbrn_home"
        
        # Check main PARA directories
        local para_dirs=("proj" "area" "rsrc" "arch")
        for dir in "${para_dirs[@]}"; do
            if [[ -d "$sbrn_home/$dir" ]]; then
                echo "   ✅ $dir/ directory exists"
            else
                echo "   ❌ $dir/ directory missing"
            fi
        done
        
        # Check system directories
        if [[ -d "$sbrn_home/sys" ]]; then
            echo "   ✅ sys/ directory exists"
            
            # Check HRT repository
            if [[ -d "$sbrn_home/sys/hrt" ]]; then
                echo "   ✅ HRT repository cloned"
            else
                echo "   ❌ HRT repository not cloned"
            fi
            
            # Check Oh My Zsh
            if [[ -d "$sbrn_home/sys/etc/oh-my-zsh" ]]; then
                echo "   ✅ Oh My Zsh installed"
            else
                echo "   ❌ Oh My Zsh not installed"
            fi
        else
            echo "   ❌ sys/ directory missing"
        fi
        
        # Check Drives directory
        if [[ -d "$HOME/Drives" ]]; then
            echo "   ✅ Cloud Drives directory exists"
        else
            echo "   ❌ Cloud Drives directory missing"
        fi
    else
        echo "   ❌ SBRN directory structure not created"
    fi
}

function check_homebrew_status() {
    if command -v brew &>/dev/null; then
        echo "   ✅ Homebrew: $(brew --version | head -1)"
        echo "   ✅ Location: $(which brew)"
        
        # Check if Homebrew is properly configured for Apple Silicon
        if [[ $(uname -m) == "arm64" ]] && [[ $(which brew) == "/opt/homebrew/bin/brew" ]]; then
            echo "   ✅ Apple Silicon configuration: Correct"
        elif [[ $(uname -m) == "x86_64" ]] && [[ $(which brew) == "/usr/local/bin/brew" ]]; then
            echo "   ✅ Intel configuration: Correct"
        fi
    else
        echo "   ❌ Homebrew not installed"
    fi
}

function check_zsh_environment_status() {
    local sbrn_home="${SBRN_HOME:-$HOME/sbrn}"
    
    # Check Oh My Zsh installation
    if [[ -d "$sbrn_home/sys/etc/oh-my-zsh" ]]; then
        echo "   ✅ Oh My Zsh installed"
        
        # Check Powerlevel10k theme
        if [[ -d "$sbrn_home/sys/etc/oh-my-zsh/custom/themes/powerlevel10k" ]]; then
            echo "   ✅ Powerlevel10k theme installed"
        else
            echo "   ❌ Powerlevel10k theme not installed"
        fi
        
        # Check essential plugins
        local plugins=("zsh-autosuggestions" "zsh-syntax-highlighting" "history-substring-search" "zsh-autoswitch-virtualenv")
        for plugin in "${plugins[@]}"; do
            if [[ -d "$sbrn_home/sys/etc/oh-my-zsh/custom/plugins/$plugin" ]]; then
                echo "   ✅ $plugin plugin installed"
            else
                echo "   ❌ $plugin plugin not installed"
            fi
        done
    else
        echo "   ❌ Oh My Zsh not installed"
    fi
    
    # Check Meslo Nerd Font
    if [[ -f "$HOME/Library/Fonts/MesloLGS NF Regular.ttf" ]]; then
        echo "   ✅ Meslo Nerd Font installed"
    else
        echo "   ❌ Meslo Nerd Font not installed"
    fi
    
    # Check ZDOTDIR configuration
    if [[ -n "${ZDOTDIR:-}" ]]; then
        echo "   ✅ ZDOTDIR configured: $ZDOTDIR"
    else
        echo "   ❌ ZDOTDIR not configured"
    fi
}

function check_cli_tools_status() {
    # Shell productivity tools - updated to match install_shell_productivity_tools()
    local shell_tools=("coreutils" "tree" "fzf" "tmux" "htop" "bat" "fd" "tldr" "eza" "zoxide" "watch" "ncdu" "glances" "lsd" "ctop" "autoenv" "atuin" "direnv" "ack" "broot" "figlet" "lolcat" "ranger" "as-tree" "agedu" "zsh-autosuggestions" "zsh-completions" "bash-completion" "fish")
    # Network tools - updated to match install_networking_security_tools()
    local network_tools=("curl" "wget" "httpie" "netcat" "gnupg" "certbot" "telnet")
    # Text/data tools and CLI editors - updated to match install_text_data_tools()
    local text_tools=("jq" "ripgrep" "grep" "fx" "jid" "colordiff" "base64" "base91" "python-yq" "ccat" "vim" "neovim" "emacs" "nano")
    
    # Check shell productivity tools
    local installed_count=0
    local total_count=${#shell_tools[@]}
    local missing_tools=()
    
    for tool in "${shell_tools[@]}"; do
        local is_installed=false
        # Special cases for tools with different command names
        case "$tool" in
            "coreutils")
                if command -v "gls" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "autoenv")
                # autoenv is a shell script, check if it's installed via homebrew
                if [[ -f "/opt/homebrew/opt/autoenv/activate.sh" || -f "/usr/local/opt/autoenv/activate.sh" ]]; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "zsh-autosuggestions"|"zsh-completions"|"bash-completion")
                # These are shell plugins/completions, check for their existence differently
                if [[ "$tool" == "zsh-autosuggestions" ]] && [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" || -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                elif [[ "$tool" == "zsh-completions" ]] && [[ -d "/opt/homebrew/share/zsh-completions" || -d "/usr/local/share/zsh-completions" ]]; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                elif [[ "$tool" == "bash-completion" ]] && [[ -f "/opt/homebrew/etc/profile.d/bash_completion.sh" || -f "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            *)
                if command -v "$tool" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
        esac
        [[ "$is_installed" == false ]] && missing_tools+=("$tool")
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Shell Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Shell Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
    
    # Check networking tools
    installed_count=0
    total_count=${#network_tools[@]}
    missing_tools=()
    
    for tool in "${network_tools[@]}"; do
        local is_installed=false
        # Special cases for tools with different command names
        case "$tool" in
            "gnupg")
                if command -v "gpg" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            *)
                if command -v "$tool" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
        esac
        [[ "$is_installed" == false ]] && missing_tools+=("$tool")
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Network Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Network Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
    
    # Check text/data tools
    installed_count=0
    total_count=${#text_tools[@]}
    missing_tools=()
    
    for tool in "${text_tools[@]}"; do
        local is_installed=false
        # Special case for tools with different command names
        case "$tool" in
            "neovim")
                if command -v "nvim" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "ripgrep")
                if command -v "rg" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "python-yq")
                if command -v "yq" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            *)
                if command -v "$tool" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
        esac
        [[ "$is_installed" == false ]] && missing_tools+=("$tool")
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Text/Data Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Text/Data Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
}

function check_dev_tools_status() {
    local git_tools=("git" "git-extras" "git-lfs" "gh" "ghq" "diff-so-fancy" "delta" "tig" "lazygit")
    local cloud_tools=("docker" "docker-compose" "colima" "kubectl" "helm" "aws" "dive" "dockviz" "k9s" "kubecolor" "kompose" "krew" "kube-ps1" "kubebuilder" "kustomize" "istioctl" "minikube" "terraform")
    local additional_dev_tools=("jwt-cli" "newman" "openapi-generator" "operator-sdk" "hugo" "logrotate" "rtmpdump" "sftpgo" "etcd" "postgresql@15" "redis" "nginx")
    
    # Check Git/VCS tools
    local installed_count=0
    local total_count=${#git_tools[@]}
    local missing_tools=()
    
    for tool in "${git_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        else
            missing_tools+=("$tool")
        fi
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Git/VCS Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Git/VCS Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
    
    # Check cloud/container tools
    installed_count=0
    total_count=${#cloud_tools[@]}
    missing_tools=()
    
    for tool in "${cloud_tools[@]}"; do
        local is_installed=false
        # Special cases for tools with different command names
        case "$tool" in
            "krew")
                if command -v "kubectl-krew" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "kube-ps1")
                # kube-ps1 is a shell script, check if it's installed via homebrew
                if [[ -f "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh" || -f "/usr/local/opt/kube-ps1/share/kube-ps1.sh" ]]; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            *)
                if command -v "$tool" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
        esac
        [[ "$is_installed" == false ]] && missing_tools+=("$tool")
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Cloud/Container/K8s Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Cloud/Container/K8s Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
    
    # Check additional development tools
    installed_count=0
    total_count=${#additional_dev_tools[@]}
    missing_tools=()
    
    for tool in "${additional_dev_tools[@]}"; do
        local is_installed=false
        # Special cases for tools with different command names
        case "$tool" in
            "jwt-cli")
                if command -v "jwt" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "postgresql@15")
                if [[ -x "/opt/homebrew/opt/postgresql@15/bin/psql" ]] || [[ -x "/usr/local/opt/postgresql@15/bin/psql" ]] || command -v "psql" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            "redis")
                if command -v "redis-server" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
            *)
                if command -v "$tool" &>/dev/null; then
                    installed_count=$((installed_count + 1))
                    is_installed=true
                fi
                ;;
        esac
        [[ "$is_installed" == false ]] && missing_tools+=("$tool")
    done
    
    if [ $installed_count -eq $total_count ]; then
        echo "   ✅ Additional Dev/API Tools: $installed_count/$total_count installed"
    else
        echo "   ⚠️  Additional Dev/API Tools: $installed_count/$total_count installed"
    fi
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        echo "      Missing: ${missing_tools[*]}"
    fi
}

function check_programming_languages_status() {
    # Check core languages
    if command -v python3 &>/dev/null; then
        echo "   ✅ Python: $(python3 --version)"
    else
        echo "   ❌ Python not installed"
    fi
    
    if command -v node &>/dev/null; then
        echo "   ✅ Node.js: $(node --version)"
    else
        echo "   ❌ Node.js not installed"
    fi
    
    # Check Java installation (handle macOS stub that exists but Java not installed)
    if command -v java &>/dev/null; then
        echo "   ✅ Java: $(java --version | head -1)"
    else
        echo "   ❌ Java not installed"
    fi
    
    if command -v go &>/dev/null; then
        echo "   ✅ Go: $(go version | cut -d' ' -f3)"
    else
        echo "   ❌ Go not installed"
    fi
    
    if command -v rustc &>/dev/null; then
        echo "   ✅ Rust: $(rustc --version | cut -d' ' -f2)"
    else
        echo "   ❌ Rust not installed"
    fi
    
    # Check version managers
    local version_managers=("jenv" "uv" "nvm")
    local installed_count=0
    
    for vm in "${version_managers[@]}"; do
        if command -v "$vm" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    
    if [ $installed_count -eq ${#version_managers[@]} ]; then
        echo "   ✅ Version Managers: $installed_count/${#version_managers[@]} installed"
    else
        echo "   ⚠️  Version Managers: $installed_count/${#version_managers[@]} installed"
    fi
    
    # Check build tools
    local build_tools=("maven" "gradle" "poetry" "pipx" "yarn")
    installed_count=0
    
    for tool in "${build_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    
    if [ $installed_count -eq ${#build_tools[@]} ]; then
        echo "   ✅ Build Tools: $installed_count/${#build_tools[@]} installed"
    else
        echo "   ⚠️  Build Tools: $installed_count/${#build_tools[@]} installed"
    fi
}

function check_ides_status() {
    # Define core IDEs list - matches install_core_ides_editors()
    local core_ides=(
        "visual-studio-code:Visual Studio Code.app:VS Code"
        "intellij-idea-ce:IntelliJ IDEA CE.app:IntelliJ IDEA CE"
        "pycharm-ce:PyCharm CE.app:PyCharm CE" 
        "cursor:Cursor.app:Cursor"
    )
    
    # Check GUI IDEs based on actual installation list
    local installed_ides=()
    local total_ides=${#core_ides[@]}
    
    for ide_info in "${core_ides[@]}"; do
        local cask_name="${ide_info%%:*}"
        local app_name="${ide_info#*:}"
        app_name="${app_name%%:*}"
        local display_name="${ide_info##*:}"
        
        # Check both /Applications and $HOME/Applications
        if [[ -d "/Applications/$app_name" ]] || [[ -d "$HOME/Applications/$app_name" ]]; then
            installed_ides+=("$display_name")
        fi
    done
    
    if [[ ${#installed_ides[@]} -gt 0 ]]; then
        echo "   ✅ Core IDEs ${#installed_ides[@]}/${total_ides}: ${installed_ides[*]}"
    else
        echo "   ❌ No core IDEs installed 0/${total_ides}"
    fi
    
    # Check VS Code extensions if VS Code is installed
    check_vscode_extensions_status
    
    # Check CLI editors
    local cli_editors=("vim" "nvim" "emacs" "nano")
    local installed_editors=()
    
    for editor in "${cli_editors[@]}"; do
        if command -v "$editor" &>/dev/null; then
            installed_editors+=("$editor")
        fi
    done
    
    if [[ ${#installed_editors[@]} -gt 0 ]]; then
        echo "   ✅ CLI Editors ${#installed_editors[@]}/${#cli_editors[@]}: ${installed_editors[*]}"
    else
        echo "   ❌ No CLI editors installed 0/${#cli_editors[@]}"
    fi
    
    # Check Jupyter and pipx
    if command -v jupyter &>/dev/null; then
        if pipx list 2>/dev/null | grep -q jupyterlab; then
            echo "   ✅ JupyterLab installed via pipx (isolated environment)"
        else
            echo "   ✅ JupyterLab installed (method unknown)"
        fi
    elif command -v pipx &>/dev/null; then
        # Check if JupyterLab is already installed via pipx
        if pipx list 2>/dev/null | grep -q jupyterlab; then
            echo "   ✅ JupyterLab already installed via pipx (isolated environment)"
        else
            echo "   ⚠️  pipx available - can install JupyterLab with: pipx install jupyterlab"
        fi
    else
        echo "   ❌ JupyterLab not installed (install pipx first)"
    fi
}

function check_vscode_extensions_status() {
    # Check if VS Code is installed and CLI is available
    if command -v code &>/dev/null; then
        local extensions_file="$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt"
        local installed_count=$(code --list-extensions 2>/dev/null | wc -l | tr -d ' ')
        local configured_count=0
        
        # Count configured extensions (excluding comments and empty lines)
        if [[ -f "$extensions_file" ]]; then
            configured_count=$(grep -v '^#' "$extensions_file" | grep -v '^$' | wc -l | tr -d ' ')
        fi
        
        if [[ $installed_count -gt 0 ]]; then
            if [[ $configured_count -gt 0 ]]; then
                if [[ $installed_count -eq $configured_count ]]; then
                    echo "   ✅ VS Code Extensions ${installed_count}/${configured_count}: Fully synced"
                elif [[ $installed_count -gt $configured_count ]]; then
                    echo "   ⚠️  VS Code Extensions ${installed_count}/${configured_count}: $((installed_count - configured_count)) uncaptured"
                else
                    echo "   ⚠️  VS Code Extensions ${installed_count}/${configured_count}: $((configured_count - installed_count)) missing"
                fi
            else
                echo "   ⚠️  VS Code Extensions ${installed_count}/0: Not managed (run: ./conf/vscode/manage-extensions.sh capture)"
            fi
        else
            echo "   ❌ VS Code Extensions 0/${configured_count}: None installed"
        fi
    elif [[ -d "/Applications/Visual Studio Code.app" ]] || [[ -d "$HOME/Applications/Visual Studio Code.app" ]]; then
        echo "   ⚠️  VS Code installed but CLI not available (Cmd+Shift+P → Install 'code' command)"
    fi
}

function check_productivity_apps_status() {
    # Define productivity apps list - matches install_productivity_apps()
    local productivity_apps=(
        "notion:Notion.app:Notion"
        "obsidian:Obsidian.app:Obsidian"
        "figma:Figma.app:Figma"
        "slack:Slack.app:Slack"
        "github:GitHub Desktop.app:GitHub Desktop"
        "postman:Postman.app:Postman"
        "insomnia:Insomnia.app:Insomnia"
        "dbeaver-community:DBeaver.app:DBeaver"
        "pgadmin4:pgAdmin 4.app:pgAdmin 4"
        "rapidapi:RapidAPI.app:RapidAPI"
        "microsoft-edge:Microsoft Edge.app:Microsoft Edge"
    )
    
    # Check installed productivity apps
    local installed_apps=()
    local total_apps=${#productivity_apps[@]}
    
    for app_info in "${productivity_apps[@]}"; do
        local cask_name="${app_info%%:*}"
        local app_name="${app_info#*:}"
        app_name="${app_name%%:*}"
        local display_name="${app_info##*:}"
        
        # Check both /Applications and $HOME/Applications
        if [[ -d "/Applications/$app_name" ]] || [[ -d "$HOME/Applications/$app_name" ]]; then
            installed_apps+=("$display_name")
        fi
    done
    
    if [[ ${#installed_apps[@]} -gt 0 ]]; then
        echo "   ✅ Productivity Apps ${#installed_apps[@]}/${total_apps}: ${installed_apps[*]}"
    else
        echo "   ❌ No productivity apps installed 0/${total_apps}"
    fi
    
    # Check commented out apps that require sudo rights
    local sudo_apps=()
    [[ -d "/Applications/VirtualBox.app" ]] && sudo_apps+=("VirtualBox")
    [[ -d "/Applications/zoom.us.app" ]] && sudo_apps+=("Zoom")
    
    if [[ ${#sudo_apps[@]} -gt 0 ]]; then
        echo "   ✅ Additional Apps manual install: ${sudo_apps[*]}"
    fi
}

function check_app_cli_symlinks_status() {
    local bin_dir="$SBRN_HOME/sys/bin"
    
    if [[ ! -d "$bin_dir" ]]; then
        echo "   ❌ CLI symlinks directory not created: $bin_dir"
        return
    fi
    
    # Define CLI symlinks that should be created - matches create_app_cli_symlinks()
    local expected_symlinks=(
        "code:Visual Studio Code.app"
        "idea:IntelliJ IDEA CE.app"
        "cursor:Cursor.app"
        "dbeaver:DBeaver.app"
        "figma:Figma.app"
        "obsidian:Obsidian.app"
        "notion:Notion.app"
        "github:GitHub Desktop.app"
        "insomnia:Insomnia.app"
        "postman:Postman.app"
        "rapidapi:RapidAPI.app"
        "slack:Slack.app"
        "pgadmin:pgAdmin 4.app"
    )
    
    local created_symlinks=()
    local missing_apps=()
    
    for symlink_info in "${expected_symlinks[@]}"; do
        local cli_name="${symlink_info%%:*}"
        local app_name="${symlink_info#*:}"
        
        # Check if app is installed
        if [[ -d "/Applications/$app_name" ]] || [[ -d "$HOME/Applications/$app_name" ]]; then
            # Check if symlink exists
            if [[ -L "$bin_dir/$cli_name" ]]; then
                created_symlinks+=("$cli_name")
            else
                missing_apps+=("$cli_name")
            fi
        fi
    done
    
    if [[ ${#created_symlinks[@]} -gt 0 ]]; then
        echo "   ✅ CLI Symlinks Created: ${created_symlinks[*]}"
    fi
    
    if [[ ${#missing_apps[@]} -gt 0 ]]; then
        echo "   ⚠️  Missing CLI Symlinks: ${missing_apps[*]}"
    fi
    
    if [[ ${#created_symlinks[@]} -eq 0 ]] && [[ ${#missing_apps[@]} -eq 0 ]]; then
        echo "   ❌ No CLI symlinks available - no apps installed"
    fi
    
    # Check if bin directory is in PATH
    if [[ ":$PATH:" == *":$bin_dir:"* ]]; then
        echo "   ✅ CLI symlinks directory added to PATH"
    else
        echo "   ⚠️  CLI symlinks directory not in PATH: $bin_dir"
    fi
}

function check_git_status() {
    if command -v git &>/dev/null; then
        echo "   ✅ Git: $(git --version)"
        
        # Check Git configuration
        if git config --global user.name &>/dev/null; then
            echo "   ✅ Git user.name: $(git config --global user.name)"
        else
            echo "   ❌ Git user.name not configured"
        fi
        
        if git config --global user.email &>/dev/null; then
            echo "   ✅ Git user.email: $(git config --global user.email)"
        else
            echo "   ❌ Git user.email not configured"
        fi
        
        # Check SSH key
        if [[ -f ~/.ssh/id_ed25519 ]]; then
            echo "   ✅ SSH key exists"
        else
            echo "   ❌ SSH key not generated"
        fi
        
        # Check GitHub CLI
        if command -v gh &>/dev/null; then
            if gh auth status &>/dev/null; then
                echo "   ✅ GitHub CLI authenticated"
            else
                echo "   ❌ GitHub CLI not authenticated"
            fi
        else
            echo "   ❌ GitHub CLI not installed"
        fi
    else
        echo "   ❌ Git not installed"
    fi
}

# Function to show usage
show_usage() {
    local script_name="${0##*/}"
    echo "Usage: $script_name [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  --skip-cask-apps, -c    Skip Homebrew Cask app installations - recommend manual install"
    echo "  --skip-iterm-setup, -i  Skip iTerm2 profile and color setup (avoids interactive prompts)"
    echo "  --status, -s            Show current system and tools status without running setup"
    echo "  --help, -h              Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  $script_name                      Run the full developer environment setup"
    echo "  $script_name --skip-cask-apps     Skip GUI app installations"
    echo "  $script_name --skip-iterm-setup   Skip iTerm2 setup to avoid popups"
    echo "  $script_name --status             Check current status of tools and environment"
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --skip-cask-apps|-c)
                SKIP_CASK_APPS=true
                shift
                ;;
            --skip-iterm-setup|-i)
                SKIP_ITERM_SETUP=true
                shift
                ;;
            --status|-s)
                show_system_summary
                exit 0
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
            brew install --cask --appdir=~/Applications "$cask"
        else
            log_success "$description already installed"
        fi
    else
        log_info "Skipping cask installation: $description - manual install recommended"

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
    echo "Proceed with developer environment setup? [y/N]: "
    read -r REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        main
        echo ""
        show_system_summary
    else
        log_info "Installation cancelled"
        exit 0
    fi
fi
