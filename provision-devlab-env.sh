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

    confirm_and_run_step "Setup Directory Structure Hierarchy" setup_dir_struct_hierarchy show_directory_impact
    confirm_and_run_step "Install Homebrew" install_macos_package_manager show_homebrew_impact
    confirm_and_run_step "Setup Zsh Environment" setup_zsh_environment show_zsh_impact
    confirm_and_run_step "Install Essential CLI Tools" install_essential_cli_tools show_cli_tools_impact
    confirm_and_run_step "Install Development Tools" install_development_tools show_dev_tools_impact
    confirm_and_run_step "Install Programming Languages & Runtimes" install_programming_languages show_languages_impact
    confirm_and_run_step "Install IDEs and Editors" install_ides_and_editors show_ides_impact
    # confirm_and_run_step "Setup Git and GitHub" setup_git_and_github show_git_impact
    
    log_success "🎉 Developer Environment Setup completed successfully!"
}

function confirm_and_run_step() {
    local step_description="$1"
    local step_function="$2"
    local summary_function="${3:-}"

    echo "Proceed with $step_description? (y/N): "
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
    mkdir -p "$SBRN_HOME/sys"/{config,local/share,local/state,cache,bin}

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
    
    # Setup non-Zsh configuration symlinks if conf directory exists
    if [[ -d "$SBRN_HOME/sys/hrt/conf" ]]; then
        log_info "Setting up configuration symlinks..."
        
        # Symlink git configuration
        if [[ -d "$SBRN_HOME/sys/hrt/conf/git" ]]; then
            ln -sf "$SBRN_HOME/sys/hrt/conf/git" "$XDG_CONFIG_HOME/git"
            log_success "Linked Git configuration"
        fi
    fi
    
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
    brew upgrade
    
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
        echo "$leaves" | while read -r package; do
            [[ -n "$package" ]] && echo "   • $package"
        done
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
            ln -sf "$SBRN_HOME/sys/hrt/conf/zsh" "$XDG_CONFIG_HOME/zsh"
            log_success "Linked Zsh configuration directory"
        fi
        
        # Symlink .zshenv if it exists
        if [[ -f "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ]]; then
            ln -sf "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ~/.zshenv
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
    )
    
    for tool_info in "${text_tools[@]}" "${cli_editors[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done

    ln -sf "$SBRN_HOME/sys/hrt/conf/ripgrep" "$XDG_CONFIG_HOME/ripgrep/config"
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
        "gibo: Fast access to .gitignore boilerplates"
        "ghq: Remote repository management made easy"
        "lazygit: Simple terminal UI for git commands"
        "tig: Text-mode interface for git"
        "diff-so-fancy: Good-lookin' diffs with diff-highlight and more"
    )
    
    for tool_info in "${git_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
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
    )
    
    for tool_info in "${cloud_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_graphics_ocr_libraries() {
    log_info "Installing 🎨 Fonts, Graphics, Images libraries..."
    
    local graphics_tools=(
        "librsvg: Library to render SVG files using Cairo"
        "gtk+3: Toolkit for creating graphical user interfaces"
        "ghostscript: Interpreter for PostScript and PDF"
    )
    
    for tool_info in "${graphics_tools[@]}"; do
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
    
    local version_managers=(
        "jenv: Java version management"
        "uv: python virtual environment management"
        "nvm: Node Version Manager"
    )
    # Currently, jenv does not natively support using the XDG Base Directory Specification
    # Move existing jenv configuration to XDG config directory if it exists
    # This at least keeps the data physically away from your $HOME, but jenv itself still expects to “see” `~/.jenv`
    [[ -d ~/.jenv ]] && {
        mv ~/.jenv $XDG_CONFIG_HOME/jenv
        ln -s $XDG_CONFIG_HOME/jenv ~/.jenv
    }

    for vm_info in "${version_managers[@]}"; do
        local vm="${vm_info%%:*}"
        local description="${vm_info#*:}"
        brew_install "$vm" "$description"
    done
    
    # Configure jenv with Java versions
    if command -v jenv &>/dev/null; then
        log_info "Configuring jenv with Java versions..."
        
        # Initialize jenv
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
    else
        log_warning "jenv not found, skipping Java version management setup"
    fi
}

function install_build_automation_tools() {
    log_info "Installing additional build and automation tools..."
    
    local build_tools=(
        "maven: Java-based project management"
        "gradle: Build automation tool based on Groovy and Kotlin"        
        "poetry: Python package and dependency manager"
        "yarn: JavaScript package manager"
        "terraform: Tool to build, change, and version infrastructure"
        "ansible: Automate deployment, configuration, and upgrading"
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
    
    # Core IDEs and Editors
    install_core_ides_editors
    
    # Productivity and Development Support Apps
    install_productivity_apps
    
    # Development Environment Tools
    install_development_environment_tools
    
    # Create symbolic links for command-line access
    create_ide_symlinks
    
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
    )
    
    for ide_info in "${ides[@]}"; do
        local ide="${ide_info%%:*}"
        local description="${ide_info#*:}"
        brew_cask_install "$ide" "$description"
    done
}

function install_productivity_apps() {
    log_info "Installing productivity and development support applications..."
    
    # Productivity and Development Support Apps via Homebrew Cask
    local productivity_apps=(
        "notion: Notion - All-in-one workspace for notes, docs, and collaboration"
        "obsidian: Obsidian - Knowledge management and note-taking app"
        "figma: Figma - Collaborative interface design tool"
        "slack: Slack - Team communication and collaboration"
        "zoom: Zoom - Video conferencing and online meetings"
        "github: GitHub Desktop - Git GUI client for GitHub"
        "postman: Postman - API development and testing platform"
        "insomnia: Insomnia - REST API client and testing tool"
        "dbeaver-community: DBeaver Community - Universal database tool"
        "pgadmin4: pgAdmin 4 - PostgreSQL administration and development platform"
        "rapidapi: RapidAPI - API testing and development tool"
        "virtualbox: VirtualBox - Virtual machine software"
        "microsoft-edge: Microsoft Edge - Web browser"
    )
    
    for app_info in "${productivity_apps[@]}"; do
        local app="${app_info%%:*}"
        local description="${app_info#*:}"
        brew_cask_install "$app" "$description"
    done
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
        "microsoft-edge: Microsoft Edge - Web browser"
        # "virtualbox: VirtualBox - Virtual machine software" # Sudoer rights needed
        # "zoom: Zoom - Video conferencing and online meetings" # Sudoer rights needed
    )
    
    for app_info in "${productivity_apps[@]}"; do
        local app="${app_info%%:*}"
        local description="${app_info#*:}"
        brew_cask_install "$app" "$description"
    done
}

function install_development_environment_tools() {
    log_info "Installing development environment and data science tools..."
    
    # Install Jupyter Lab and related tools
    if command -v pip3 &>/dev/null; then
        local jupyter_packages=(
            "jupyterlab"
            "notebook"
            "ipywidgets"
            "jupyter-console"
            "nbconvert"
            "ipykernel"
        )
        
        for package in "${jupyter_packages[@]}"; do
            if ! pip3 list | grep -q "^$package "; then
                log_info "Installing $package..."
                pip3 install "$package"
            else
                log_success "$package already installed"
            fi
        done
    else
        log_warning "pip3 not found, skipping Jupyter installation"
    fi
    
    # Install additional development environment tools
    local env_tools=(
        "screen: Terminal multiplexer with VT100/ANSI terminal emulation"
        "git-gui: Tcl/Tk based graphical user interface to Git"
        "gitk: The Git repository browser"
    )
    
    for tool_info in "${env_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
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
    
    # GitHub Desktop CLI (if available)
    if [[ -d "/Applications/GitHub Desktop.app" ]] && [[ ! -L "$bin_dir/github-desktop" ]]; then
        if [[ -f "/Applications/GitHub Desktop.app/Contents/MacOS/GitHub Desktop" ]]; then
            ln -sf "/Applications/GitHub Desktop.app/Contents/MacOS/GitHub Desktop" "$bin_dir/github-desktop"
            log_success "Created symlink for GitHub Desktop"
        fi
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
    echo "✅ Oh My Zsh installed at: $SBRN_HOME/sys/oh-my-zsh"
    echo "✅ Powerlevel10k theme installed for enhanced prompt"
    echo "✅ Essential plugins installed:"
    echo "   • zsh-autosuggestions (command completion)"
    echo "   • zsh-syntax-highlighting (syntax highlighting)"
    echo "   • history-substring-search (better history search)"
    echo "   • zsh-autoswitch-virtualenv (auto Python venv switch)"
    echo "✅ Meslo Nerd Font installed for terminal icons"
    echo "✅ Zsh configuration setup:"
    echo "   • ZDOTDIR set to: $XDG_CONFIG_HOME/zsh"
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
    echo "✅ 🌐 Networking, Security, & Transfer tools:"
    echo "   • curl (command-line data transfer tool)"
    echo "   • wget (internet file retriever)"
    echo "   • httpie (user-friendly HTTP client)"
    echo "   • netcat (networking utility)"
    echo "✅ 📊 Text, Regex, JSON, Data tools & CLI Editors:"
    echo "   • jq (lightweight JSON processor)"
    echo "   • ripgrep (fast text search tool with configuration and aliases)"
    echo "   • grep (GNU grep, egrep and fgrep with color aliases)"
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
    echo "   • Git configured to use diff-so-fancy for enhanced diffs"
    echo "✅ ☁️ Cloud & Containers:"
    echo "   • docker (platform for developing, shipping, and running applications)"
    echo "   • docker-compose (isolated development environments using Docker)"
    echo "   • colima (container runtimes on macOS with minimal setup)"
    echo "   • kubernetes-cli (Kubernetes command-line interface)"
    echo "   • helm (Kubernetes package manager)"
    echo "   • awscli (official Amazon AWS command-line interface)"
    echo "✅ 🎨 Graphics, OCR, and UI Libraries:"
    echo "   • librsvg (library to render SVG files using Cairo)"
    echo "   • gtk+3 (toolkit for creating graphical user interfaces)"
    echo "   • ghostscript (interpreter for PostScript and PDF)"
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
    echo "   • nvm (Node Version Manager - custom install)"
    echo "✅ Build & Automation Tools:"
    echo "   • maven (Java-based project management)"
    echo "   • gradle (build automation tool based on Groovy and Kotlin)"
    echo "   • terraform (tool to build, change, and version infrastructure)"
    echo "   • ansible (automate deployment, configuration, and upgrading)"
    echo "   • poetry (Python package and dependency manager)"
    echo "   • pipenv (Python development workflow for humans)"
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
        echo "   • JupyterLab with full data science stack (ipywidgets, nbconvert)"
    fi
    echo "   • screen (terminal multiplexer)"
    echo "   • git-gui, gitk (Git graphical tools)"
    echo "✅ Command-line shortcuts created in: $SBRN_HOME/sys/bin"
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

function show_vscode_impact() {
    if command -v code &>/dev/null; then
        local ext_count=$(code --list-extensions | wc -l)
        echo "✅ VS Code extensions installed: $ext_count total"
        echo "   • AI: GitHub Copilot, Copilot Chat"
        echo "   • Languages: Python, Java, TypeScript, YAML, Markdown"
        echo "   • Tools: Docker, Kubernetes, Git, Remote SSH"
        echo "   • Themes: Material Icons, GitHub Theme, Dracula"
    else
        echo "⚠️  VS Code not found, extensions skipped"
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
function show_system_summary() {
    log_info "🖥️  Developer Environment Status Check"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # System Information
    echo "📊 System Information:"
    echo "   • macOS Version: $(sw_vers -productVersion)"
    echo "   • Hardware: $(sysctl -n hw.model)"
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
    
    # Git Configuration Status
    echo "🔗 Git Configuration:"
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
            if [[ -d "$sbrn_home/sys/oh-my-zsh" ]]; then
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
    if [[ -d "$sbrn_home/sys/oh-my-zsh" ]]; then
        echo "   ✅ Oh My Zsh installed"
        
        # Check Powerlevel10k theme
        if [[ -d "$sbrn_home/sys/oh-my-zsh/custom/themes/powerlevel10k" ]]; then
            echo "   ✅ Powerlevel10k theme installed"
        else
            echo "   ❌ Powerlevel10k theme not installed"
        fi
        
        # Check essential plugins
        local plugins=("zsh-autosuggestions" "zsh-syntax-highlighting" "history-substring-search" "zsh-autoswitch-virtualenv")
        for plugin in "${plugins[@]}"; do
            if [[ -d "$sbrn_home/sys/oh-my-zsh/custom/plugins/$plugin" ]]; then
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
    # Shell productivity tools - matches install_shell_productivity_tools()
    local shell_tools=("coreutils" "tree" "fzf" "tmux" "htop" "bat" "fd" "tldr" "eza" "zoxide" "watch" "ncdu" "glances" "lsd" "ctop" "autoenv")
    # Network tools - matches install_networking_security_tools()
    local network_tools=("curl" "wget" "httpie" "netcat")
    # Text/data tools and CLI editors - matches install_text_data_tools()
    local text_tools=("jq" "ripgrep" "grep" "vim" "neovim" "emacs" "nano")
    
    # Check shell productivity tools
    local installed_count=0
    local total_count=${#shell_tools[@]}
    
    for tool in "${shell_tools[@]}"; do
        # Special case for coreutils - check for gls which is part of coreutils
        if [[ "$tool" == "coreutils" ]]; then
            if command -v "gls" &>/dev/null; then
                installed_count=$((installed_count + 1))
            fi
        elif command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Shell Tools: $installed_count/$total_count installed"
    
    # Check networking tools
    installed_count=0
    total_count=${#network_tools[@]}
    
    for tool in "${network_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Network Tools: $installed_count/$total_count installed"
    
    # Check text/data tools
    installed_count=0
    total_count=${#text_tools[@]}
    
    for tool in "${text_tools[@]}"; do
        # Special case for neovim - command is 'nvim'
        if [[ "$tool" == "neovim" ]]; then
            if command -v "nvim" &>/dev/null; then
                installed_count=$((installed_count + 1))
            fi
        elif command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Text/Data Tools: $installed_count/$total_count installed"
}

function check_dev_tools_status() {
    local git_tools=("git" "git-extras" "git-lfs" "gh" "gibo" "ghq" "lazygit" "tig" "diff-so-fancy")
    local cloud_tools=("docker" "docker-compose" "colima" "kubectl" "helm" "aws")
    
    # Check Git/VCS tools
    local installed_count=0
    local total_count=${#git_tools[@]}
    
    for tool in "${git_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Git/VCS Tools: $installed_count/$total_count installed"
    
    # Check cloud/container tools
    installed_count=0
    total_count=${#cloud_tools[@]}
    
    for tool in "${cloud_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Cloud/Container Tools: $installed_count/$total_count installed"
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
    echo "   Version Managers: $installed_count/${#version_managers[@]} installed"
    
    # Check build tools
    local build_tools=("maven" "gradle" "terraform" "ansible" "poetry" "pipenv" "yarn")
    installed_count=0
    
    for tool in "${build_tools[@]}"; do
        if command -v "$tool" &>/dev/null; then
            installed_count=$((installed_count + 1))
        fi
    done
    echo "   Build Tools: $installed_count/${#build_tools[@]} installed"
}

function check_ides_status() {
    # Check GUI IDEs
    local gui_ides=()
    [[ -d "/Applications/Visual Studio Code.app" ]] && gui_ides+=("VS Code")
    [[ -d "/Applications/IntelliJ IDEA CE.app" ]] && gui_ides+=("IntelliJ IDEA CE")
    [[ -d "/Applications/PyCharm CE.app" ]] && gui_ides+=("PyCharm CE")
    [[ -d "/Applications/Cursor.app" ]] && gui_ides+=("Cursor")
    
    if [[ ${#gui_ides[@]} -gt 0 ]]; then
        echo "   ✅ GUI IDEs: ${gui_ides[*]}"
    else
        echo "   ❌ No GUI IDEs installed"
    fi
    
    # Check CLI editors
    local cli_editors=("vim" "nvim" "emacs" "nano")
    local installed_editors=()
    
    for editor in "${cli_editors[@]}"; do
        if command -v "$editor" &>/dev/null; then
            installed_editors+=("$editor")
        fi
    done
    
    if [[ ${#installed_editors[@]} -gt 0 ]]; then
        echo "   ✅ CLI Editors: ${installed_editors[*]}"
    else
        echo "   ❌ No CLI editors installed"
    fi
    
    # Check Jupyter
    if command -v jupyter &>/dev/null; then
        echo "   ✅ JupyterLab installed"
    else
        echo "   ❌ JupyterLab not installed"
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
            brew install --cask --appdir=~/Applications "$cask"
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
    echo "Proceed with developer environment setup? (y/N): "
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
