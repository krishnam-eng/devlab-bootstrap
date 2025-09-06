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
    confirm_and_run_step "Install Homebrew" install_package_manager show_homebrew_impact
    confirm_and_run_step "Setup Zsh Environment" setup_zsh_environment show_zsh_impact
    confirm_and_run_step "Install Essential CLI Tools" install_essential_cli_tools show_cli_tools_impact
    confirm_and_run_step "Install Development Tools" install_development_tools show_dev_tools_impact
    confirm_and_run_step "Install Programming Languages & Runtimes" install_programming_languages show_languages_impact
    confirm_and_run_step "Install IDEs and Editors" install_ides_and_editors show_ides_impact
    confirm_and_run_step "Setup Git and GitHub" setup_git_and_github show_git_impact
    confirm_and_run_step "Configure VS Code Extensions" configure_vscode_extensions show_vscode_impact
    confirm_and_run_step "Final Configuration" final_configuration show_final_config_impact
    
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
function install_package_manager() {
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
    log_info "📦 Currently installed Homebrew packages:"
    
    # Detect Homebrew installation path
    local BREW
    BREW="$(command -v brew || true)"
    [[ -z "$BREW" ]] && [[ -x /opt/homebrew/bin/brew ]] && BREW=/opt/homebrew/bin/brew
    [[ -z "$BREW" ]] && [[ -x /usr/local/bin/brew ]] && BREW=/usr/local/bin/brew || true
    
    if [[ -z "$BREW" ]]; then
        log_warning "Homebrew not found in standard locations"
        return 1
    fi
    
    local CELLAR
    CELLAR="$("$BREW" --cellar)"
    
    # Generate package list with installation timestamps
    {
        /usr/bin/printf "Formula\tVersion\tInstalledAt\tDescription\n"
        "$BREW" info --json=v2 --installed --formula \
        | jq -r '
            .formulae[]
            | [
                .name,
                (([.installed[]?.version] | select(length>0) | join(", "))
                  // .versions.stable // "n/a"),
                (.desc // "—")
              ] | @tsv
          ' \
        | while IFS=$'\t' read -r name ver desc; do
            local latest
            latest=$(/bin/ls -dt "$CELLAR/$name"/* 2>/dev/null | /usr/bin/head -1)

            local epoch human
            if [[ -n "$latest" ]] && [[ -f "$latest/INSTALL_RECEIPT.json" ]]; then
                epoch=$(/usr/bin/stat -f "%m" "$latest/INSTALL_RECEIPT.json")
                human=$(/usr/bin/stat -f "%SB" -t "%Y-%m-%d %H:%M:%S" "$latest/INSTALL_RECEIPT.json")
            elif [[ -n "$latest" ]]; then
                epoch=$(/usr/bin/stat -f "%m" "$latest")
                human=$(/usr/bin/stat -f "%SB" -t "%Y-%m-%d %H:%M:%S" "$latest")
            else
                local f
                f=$("$BREW" list --verbose "$name" 2>/dev/null | /usr/bin/head -1)
                epoch=$([ -n "$f" ] && /usr/bin/stat -f "%m" "$f" 2>/dev/null || echo 0)
                human=$([ -n "$f" ] && /usr/bin/stat -f "%SB" -t "%Y-%m-%d %H:%M:%S" "$f" 2>/dev/null || echo "—")
            fi

            /usr/bin/printf "%s\t%s\t%s\t%s\t%s\n" "$epoch" "$name" "$ver" "$human" "$desc"
        done
    } \
    | /usr/bin/sort -n -k1,1 \
    | /usr/bin/awk 'BEGIN{FS=OFS="\t"} NR==1{print "Formula","Version","InstalledAt","Description"; next} {print $2,$3,$4,$5}' \
    | /usr/bin/column -t -s $'\t'
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
            # Create parent directory if it doesn't exist
            mkdir -p "$(dirname "$ZDOTDIR")"
            ln -sf "$SBRN_HOME/sys/hrt/conf/zsh" "$ZDOTDIR"
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
    
    # 🗜️ Compression, Archiving, & Storage Tools
    install_compression_storage_tools
    
    # 📊 Text, Regex, JSON, Data Tools
    install_text_data_tools
    
    # Configure Git to use diff-so-fancy
    if command -v diff-so-fancy &>/dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" 2>/dev/null || true
    fi
    
    log_success "Essential CLI tools installation completed"
}

function install_shell_productivity_tools() {
    log_info "Installing 🖥️ Shell Enhancements & CLI Productivity tools..."
    
    # Core shell enhancement tools (ordered by popularity)
    local shell_tools=(
        "fzf: Command-line fuzzy finder"
        "tmux: Terminal multiplexer"
        "htop: Interactive process viewer"
        "tree: Directory tree visualization"
        "bat: Cat clone with syntax highlighting and Git integration"
        "zsh-autosuggestions: Command autosuggestions for zsh"
        "zsh-syntax-highlighting: Syntax highlighting for zsh commands"
        "fd: Simple, fast and user-friendly alternative to find"
        "tldr: Simplified and community-driven man pages"
        "eza: Modern replacement for ls with colors and icons"
        "zoxide: Smarter cd command with frecency"
        "watch: Execute a program periodically, showing output fullscreen"
        "ncdu: NCurses Disk Usage - disk usage analyzer"
        "glances: System monitoring tool"
        "lsd: LSd (LSDeluxe) - next gen ls command"
        "ctop: Top-like interface for container metrics"
        "readline: Library for command-line editing"
        "autoenv: Directory-based environments"
    )
    
    for tool_info in "${shell_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
    
    # Install zsh plugins if Oh My Zsh is available
    if [[ -n "${ZSH:-}" ]] && [[ -d "$ZSH" ]]; then
        install_zsh_productivity_plugins
    fi
}

function install_zsh_productivity_plugins() {
    log_info "Installing additional Zsh productivity plugins..."
    
    local custom_dir="${ZSH}/custom/plugins"
    
    # zsh-autosuggestions (if not already installed)
    if [[ ! -d "$custom_dir/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$custom_dir/zsh-autosuggestions"
        log_success "Installed zsh-autosuggestions"
    fi
    
    # zsh-syntax-highlighting (if not already installed)
    if [[ ! -d "$custom_dir/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/zsh-syntax-highlighting"
        log_success "Installed zsh-syntax-highlighting"
    fi
}

function install_networking_security_tools() {
    log_info "Installing 🌐 Networking, Security, & Transfer tools..."
    
    local network_tools=(
        "curl: Command-line tool for transferring data with URL syntax"
        "wget: Internet file retriever"
        "httpie: User-friendly command-line HTTP client"
        "openssl@3: Cryptography and SSL/TLS Toolkit"
        "libsodium: Modern, portable, easy-to-use crypto library"
        "libssh2: C library implementing the SSH2 protocol"
        "libevent: Asynchronous event library"
        "libb2: C library providing BLAKE2b, BLAKE2s, BLAKE2bp, BLAKE2sp"
        "ca-certificates: Common CA certificates PEM files"
        "certifi: Python package for providing Mozilla's CA Bundle"
        "libnghttp2: HTTP/2 C Library"
        "libnghttp3: HTTP/3 library written in C"
        "libngtcp2: Implementation of QUIC and HTTP/3"
        "netcat: Utility for reading/writing network connections"
        "rtmpdump: Tool for downloading RTMP streaming media"
    )
    
    for tool_info in "${network_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_compression_storage_tools() {
    log_info "Installing 🗜️ Compression, Archiving, & Storage tools..."
    
    local compression_tools=(
        "xz: General-purpose data compression with high compression ratio"
        "lz4: Extremely Fast Compression algorithm"
        "zstd: Zstandard - Fast real-time compression algorithm"
        "brotli: Generic-purpose lossless compression algorithm by Google"
        "lzo: Real-time data compression library"
        "libarchive: Multi-format archive and compression library"
        "libzip: C library for reading, creating, and modifying zip archives"
        "sqlite: Command-line interface for SQLite"
        "berkeley-db@5: High performance, embedded database library"
        "gdbm: GNU database manager"
        "mpdecimal: Library for general decimal arithmetic"
    )
    
    for tool_info in "${compression_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_text_data_tools() {
    log_info "Installing 📊 Text, Regex, JSON, Data tools..."
    
    local text_tools=(
        "jq: Lightweight and flexible command-line JSON processor"
        "ripgrep: Search tool like grep and The Silver Searcher"
        "gettext: GNU internationalization (i18n) and localization (l10n) library"
        "libunistring: C string library for manipulating Unicode strings"
        "utf8proc: Clean C library for processing UTF-8 Unicode data"
        "icu4c@77: C/C++ and Java libraries for Unicode and locale support"
        "libidn: International domain name library"
        "libidn2: International domain name library (IDNA2008, Punycode, TR46)"
        "fribidi: Implementation of the Unicode Bidirectional Algorithm"
        "oniguruma: Regular expressions library"
        "pcre2: Perl compatible regular expressions library with a new API"
    )
    
    for tool_info in "${text_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
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
    
    # 🎨 Graphics, Fonts, and UI Libraries
    install_graphics_font_libraries
    
    # 👓 OCR & Document Processing
    install_ocr_document_tools
    
    # 🖥️ System & Desktop Libraries
    install_system_desktop_libraries
    
    log_success "Development tools installation completed"
}

function install_git_and_vcs_tools() {
    log_info "Installing 🔧 Developer Tools (VCS, Repos, Git Helpers)..."
    
    local git_tools=(
        "git: Distributed revision control system"
        "git-lfs: Git extension for versioning large files"
        "gh: GitHub command-line tool"
        "libgit2: C library for Git core methods"
        "git-extras: Small git utilities"
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
        "docker-completion: Bash, Zsh and Fish completion for Docker"
        "colima: Container runtimes on macOS (and Linux) with minimal setup"
        "lima: Linux virtual machines (on macOS, in most cases)"
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

function install_graphics_font_libraries() {
    log_info "Installing 🎨 Fonts, Graphics, Images libraries..."
    
    local graphics_tools=(
        "freetype: Software library to render fonts"
        "fontconfig: XML-based font configuration API for X Windows"
        "harfbuzz: OpenType text shaping engine"
        "pango: Framework for layout and rendering of i18n text"
        "graphite2: Smart font technology"
        "cairo: Vector graphics library with cross-device output support"
        "pixman: Low-level library for pixel manipulation"
        "glib: Core application library for C"
        "gdk-pixbuf: Toolkit for image loading and pixel buffer manipulation"
        "librsvg: Library to render SVG files using Cairo"
        "gtk+3: Toolkit for creating graphical user interfaces"
        "libepoxy: Library for handling OpenGL function pointer management"
        "libpng: Library for manipulating PNG images"
        "jpeg-turbo: JPEG image codec that uses SIMD instructions"
        "giflib: Library and utilities for processing GIFs"
        "libtiff: TIFF library and utilities"
        "little-cms2: Color management engine supporting ICC profiles"
        "jbig2dec: JBIG2 decoder library (for monochrome documents)"
        "openjpeg: Library for JPEG-2000 image manipulation"
        "webp: Image format providing lossless and lossy compression"
        "leptonica: Image processing and image analysis library"
    )
    
    for tool_info in "${graphics_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_ocr_document_tools() {
    log_info "Installing 👓 OCR & Document Processing tools..."
    
    local ocr_tools=(
        "tesseract: OCR (Optical Character Recognition) engine"
        "ghostscript: Interpreter for PostScript and PDF"
    )
    
    for tool_info in "${ocr_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_system_desktop_libraries() {
    log_info "Installing 🖥️ System & Desktop libraries..."
    
    local system_tools=(
        "dbus: Message bus system, providing inter-application communication"
        "at-spi2-core: Protocol definitions and daemon for D-Bus at-spi"
        "gsettings-desktop-schemas: GSettings schemas for desktop components"
        "hicolor-icon-theme: Fallback theme for FreeDesktop.org icon themes"
        "ncurses: Text-based UI library"
        "libx11: X.Org: Core X11 protocol client library"
        "libxcb: X.Org: Interface to the X Window System protocol"
        "libxext: X.Org: Library for common extensions to the X11 protocol"
        "libxrender: X.Org: Library for the Render Extension to the X11 protocol"
        "libxau: X.Org: A Sample Authorization Protocol for X"
        "libxdmcp: X.Org: X Display Manager Control Protocol library"
        "libxfixes: X.Org: Header files for the XFIXES extension"
        "libxi: X.Org: Library for the Input extension to the X11 protocol"
        "libxtst: X.Org: Client API for the XTEST & RECORD extensions"
        "xorgproto: X.Org: Protocol Headers"
    )
    
    for tool_info in "${system_tools[@]}"; do
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
    
    # 📦 Package, Env, and Build Tools
    install_package_env_build_tools
    
    # Core Programming Languages & Runtimes
    install_core_programming_languages
    
    # Version Managers
    install_version_managers
    
    # Additional Build and Automation Tools
    install_build_automation_tools
    
    log_success "Programming languages and runtimes installation completed"
}

function install_package_env_build_tools() {
    log_info "Installing 📦 Package, Env, and Build Tools..."
    
    local package_tools=(
        "nvm: Node.js version manager"
        "python@3.13: Python 3.13 programming language"
        "perl: Highly capable, feature-rich programming language"
        "ruby: Powerful, clean, object-oriented scripting language"
        "lua: Powerful, lightweight programming language"
        "openjdk: Open-source implementation of Java Platform, Standard Edition"
        "openjdk@17: Open-source implementation of Java Platform, Standard Edition (v17)"
        "maven: Java-based project management"
        "gradle: Build automation tool based on Groovy and Kotlin"
        "certifi: Mozilla CA Bundle in Python"
        "libyaml: YAML Parser"
    )
    
    for tool_info in "${package_tools[@]}"; do
        local tool="${tool_info%%:*}"
        local description="${tool_info#*:}"
        brew_install "$tool" "$description"
    done
}

function install_core_programming_languages() {
    log_info "Installing core programming languages and runtimes..."
    
    local languages=(
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
        "pyenv: Python version management"
        "jenv: Java version management"
        "rbenv: Ruby version management"
    )
    
    for vm_info in "${version_managers[@]}"; do
        local vm="${vm_info%%:*}"
        local description="${vm_info#*:}"
        brew_install "$vm" "$description"
    done
    
    # Install NVM manually if not already installed (Homebrew version has issues)
    install_nvm_manually
}

function install_nvm_manually() {
    local nvm_dir="$SBRN_HOME/sys/nvm"
    
    if [[ ! -d "$nvm_dir" ]]; then
        log_info "Installing NVM (Node Version Manager) manually..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | NVM_DIR="$nvm_dir" bash
        
        # Source NVM
        export NVM_DIR="$nvm_dir"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        
        log_success "NVM installed to $nvm_dir"
    else
        log_success "NVM already installed at $nvm_dir"
    fi
}

function install_build_automation_tools() {
    log_info "Installing additional build and automation tools..."
    
    local build_tools=(
        "terraform: Tool to build, change, and version infrastructure"
        "ansible: Automate deployment, configuration, and upgrading"
        "poetry: Python package and dependency manager"
        "pipenv: Python development workflow for humans"
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
    
    # Core IDEs and Editors
    install_core_ides_editors
    
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
        "sublime-text: Sublime Text - sophisticated text editor for code, markup and prose"
        "zed: Zed - high-performance, multiplayer code editor"
    )
    
    for ide_info in "${ides[@]}"; do
        local ide="${ide_info%%:*}"
        local description="${ide_info#*:}"
        brew_cask_install "$ide" "$description"
    done
    
    # CLI editors via Homebrew
    local cli_editors=(
        "vim: Vi IMproved - enhanced version of the vi editor"
        "neovim: Ambitious Vim-fork focused on extensibility and agility"
        "emacs: GNU Emacs text editor"
        "nano: Free (GNU) replacement for the Pico text editor"
    )
    
    for editor_info in "${cli_editors[@]}"; do
        local editor="${editor_info%%:*}"
        local description="${editor_info#*:}"
        brew_install "$editor" "$description"
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
    echo "   • zsh-autosuggestions, zsh-syntax-highlighting (shell quality of life)"
    echo "   • fzf, zoxide, tldr, tree, bat, fd, lsd, eza (navigation & search)"
    echo "   • watch, ncdu, htop, glances, ctop (system monitoring)"
    echo "   • tmux, readline (terminal multiplexing & editing)"
    echo "✅ 🌐 Networking, Security, & Transfer tools:"
    echo "   • curl, wget, httpie (HTTP clients)"
    echo "   • openssl@3, libsodium, libssh2, libevent, libb2 (crypto & networking)"
    echo "   • ca-certificates, certifi (root certificates)"
    echo "   • libnghttp2, libnghttp3, libngtcp2 (HTTP/2, HTTP/3, QUIC)"
    echo "   • netcat, rtmpdump (networking & streaming)"
    echo "✅ 🗜️ Compression, Archiving, & Storage:"
    echo "   • xz, lz4, zstd, brotli, lzo (compression libraries)"
    echo "   • libarchive, libzip (archive handling)"
    echo "   • sqlite, berkeley-db@5, gdbm (databases & storage)"
    echo "✅ 📊 Text, Regex, JSON, Data tools:"
    echo "   • jq, ripgrep (JSON and text search)"
    echo "   • gettext, libunistring, utf8proc, icu4c@77 (i18n & Unicode)"
    echo "   • oniguruma, pcre2 (regex engines)"
}

function show_dev_tools_impact() {
    echo "✅ 🔧 Developer Tools (VCS, Repos, Git Helpers):"
    echo "   • git, git-lfs, gh, libgit2 (core Git tooling)"
    echo "   • git-extras, gibo, ghq (Git workflow helpers)"
    echo "   • lazygit, tig, diff-so-fancy (Git TUI and pretty diffs)"
    echo "   • Git configured to use diff-so-fancy for enhanced diffs"
    echo "✅ ☁️ Cloud & Containers:"
    echo "   • docker, docker-compose, docker-completion (container runtime)"
    echo "   • colima, lima (container/VM backends for macOS)"
    echo "   • kubernetes-cli, helm (Kubernetes control)"
    echo "   • awscli (AWS management)"
    echo "✅ 🎨 Fonts, Graphics, Images libraries:"
    echo "   • freetype, fontconfig, harfbuzz, pango (font rendering)"
    echo "   • cairo, pixman, glib, gdk-pixbuf, librsvg (graphics/UI)"
    echo "   • libpng, jpeg-turbo, giflib, libtiff, webp (image codecs)"
    echo "✅ 👓 OCR & Document Processing:"
    echo "   • tesseract (OCR engine)"
    echo "   • ghostscript (PDF & PostScript interpreter)"
    echo "✅ 🖥️ System & Desktop libraries:"
    echo "   • dbus, at-spi2-core, gsettings-desktop-schemas (desktop IPC)"
    echo "   • ncurses (TUI base library)"
    echo "   • libx11, libxcb, libxext, libxrender (X11 components)"
}

function show_languages_impact() {
    echo "✅ 📦 Package, Env, and Build Tools:"
    echo "   • nvm (Node.js version manager)"
    echo "   • python@3.13, perl, ruby, lua (language runtimes)"
    echo "   • openjdk, openjdk@17, maven, gradle (Java ecosystem)"
    echo "   • certifi, libyaml (Python ecosystem dependencies)"
    echo "✅ Core Programming Languages:"
    echo "   • Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "   • Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
    echo "   • Java: $(java --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "   • Go: $(go version 2>/dev/null || echo 'Not installed')"
    echo "   • Rust: $(rustc --version 2>/dev/null || echo 'Not installed')"
    echo "   • Ruby: $(ruby --version 2>/dev/null || echo 'Not installed')"
    echo "   • Perl: $(perl --version 2>/dev/null | head -2 | tail -1 || echo 'Not installed')"
    echo "   • Lua: $(lua -v 2>/dev/null || echo 'Not installed')"
    echo "✅ Version Managers: pyenv, nvm (custom install), jenv, rbenv"
    echo "✅ Build & Automation: terraform, ansible, poetry, pipenv, yarn"
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
    if [[ -d "/Applications/Sublime Text.app" ]]; then
        echo "   • Sublime Text"
    fi
    if [[ -d "/Applications/Zed.app" ]]; then
        echo "   • Zed (high-performance, multiplayer code editor)"
    fi
    echo "   • CLI editors: vim, neovim, emacs, nano"
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
    echo "✅ PATH updated to include: $SBRN_HOME/sys/bin"
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
