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

# Global variables - Default to skip optional GUI features
SKIP_CASK_APPS=true
SKIP_ITERM_SETUP=true
AUTO_YES=false
SCRIPT_NAME="provision-devlab.sh"

# Path to the Python brew helper utility module
BREW_UTIL_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/scripts/util/brew_helper.py"

# Colors for output (Maven-style)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'  # Changed to bright/bold blue for better visibility
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
GREY='\033[37m'    # Light grey color
NC='\033[0m' # No Color

# Maven-style logging functions
log_info() { printf "${GREY}[INFO]${NC} %s\n" "$1"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }
log_phase() { 
    # Check if message already contains [PHASE X/Y] pattern
    if [[ "$1" =~ ^\[PHASE\ [0-9]+/[0-9]+\] ]]; then
        # Extract phase number and description
        local phase_part=$(echo "$1" | sed 's/\[PHASE \([0-9]*\/[0-9]*\)\] \(.*\)/\1/')
        local description=$(echo "$1" | sed 's/\[PHASE \([0-9]*\/[0-9]*\)\] \(.*\)/\2/')
        
        printf "${GREY}[INFO] ${GREEN}------------------------------< ${CYAN}$phase_part${GREEN} >-----------------------------------${NC}\n"
        printf "${CYAN}[PHASE]${NC}  ${description}\n"
        printf "${GREY}[INFO] ${GREEN}------------------------------------------------------------------------${NC}\n"
    else
        printf "${GREY}[INFO] ${BOLD}${CYAN}[PHASE]${NC} %s\n" "$1"
    fi
}
log_phase_summary() {
    local phase_num="$1"
    local phase_title="$2"
    shift 2
    local accomplishments=("$@")
    
    printf "\n${BOLD}${GREEN}✅ PHASE ${phase_num} COMPLETED: ${phase_title}${NC}\n"
    printf "${DIM}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    for accomplishment in "${accomplishments[@]}"; do
        printf "${CYAN}  ▶ ${accomplishment}${NC}\n"
    done
    printf "${DIM}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}
log_goal() { 
    # Check if message already contains [X.Y/Z.W] pattern  
    if [[ "$1" =~ ^\[[0-9]+\.[0-9]+/[0-9]+\.[0-9]+\] ]]; then
        # Extract goal number and description
        local goal_part=$(echo "$1" | sed 's/\[\([0-9]*\.[0-9]*\/[0-9]*\.[0-9]*\)\] \(.*\)/\1/')
        local description=$(echo "$1" | sed 's/\[\([0-9]*\.[0-9]*\/[0-9]*\.[0-9]*\)\] \(.*\)/\2/')
        printf "${BLUE}[GOAL] ${GREEN}--- ${description} ${BLUE}(${goal_part})${GREEN} ---${NC}\n"
    else
        printf "${BLUE}[GOAL]${NC} %s\n" "$1"
    fi
}
log_build_success() { printf "\n${BOLD}${GREEN}------------------------------------------------------------------------\n"; printf "BUILD SUCCESS\n"; printf "------------------------------------------------------------------------${NC}\n"; }
log_build_failure() { printf "\n${BOLD}${RED}------------------------------------------------------------------------\n"; printf "BUILD FAILURE\n"; printf "------------------------------------------------------------------------${NC}\n"; }

################################################################################
# Main execution flow
function main() {
    # Opening sequence
    printf "\n${BLUE}[INIT]${NC} 🧪 Initializing Developer Laboratory Setup Protocol...${NC}\n"
    printf "${BLUE}[SCAN]${NC} 🔍 Analyzing system configuration and requirements...${NC}\n"
    printf "${GREY}[INFO]${NC} ${GREEN}========================================================================${NC}\n"
    printf "${GREY}[INFO]${NC} 🚀 Developer Laboratory Environment Construction Sequence v1.0${NC}\n"
    printf "${GREY}[INFO]${NC} 🧬 Crafting Your Ultimate Development DNA (CLI-Focused Setup)${NC}\n"
    printf "${GREY}[INFO]${NC} ${GREEN}========================================================================${NC}\n"
    printf "${BLUE}[STATUS]${NC} System ready for enhancement. Commencing CLI-focused setup sequence...${NC}\n"
    if [[ $SKIP_CASK_APPS == true || $SKIP_ITERM_SETUP == true ]]; then
        printf "${DIM}[NOTE]${NC} For GUI apps and iTerm themes, use: $SCRIPT_NAME -c -i${NC}\n"
    fi

    # Prerequisites: Essential setup steps
    confirm_and_run_step "Setup Prerequisites (Second Brain & Homebrew)" setup_prerequisites "0"
    
    # Main setup phases (7 phases)
    confirm_and_run_step "Setup Developer Laboratory Directory Structure" setup_dir_struct_hierarchy "1"
    confirm_and_run_step "Setup Zsh Environment" setup_zsh_environment "2"
    confirm_and_run_step "Install Essential CLI Tools" install_essential_cli_tools "3"
    confirm_and_run_step "Install Development Tools" install_development_tools "4"
    confirm_and_run_step "Install Programming Languages" install_programming_languages "5"
    confirm_and_run_step "Install IDEs and GUI Productivity Tools" install_ides_and_gui_productivity_tools "6"
    confirm_and_run_step "Setup AI Development Environment" setup_agentic_ai_development "7"
    
    # Maven-style build success
    log_build_success
    printf "${DIM}[INFO]${NC} Total time: $(( SECONDS / 60 ))m $(( SECONDS % 60 ))s\n"
    printf "${DIM}[INFO]${NC} Finished at: $(date)\n"
    printf "${DIM}[INFO]${NC} Final Memory: $(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')K\n"
    printf "${BOLD}${GREEN}[INFO]${NC} Developer Environment Setup completed successfully!\n"
}

function confirm_and_run_step() {
    local step_description="$1"
    local step_function="$2"
    local phase_number="${3:-0}"  # Default to 0 if not provided
    
    # Map step functions to phase emojis and descriptions
    local emoji
    local phase_desc
    case "$step_function" in
        setup_prerequisites)
            emoji="🏗️"
            phase_desc="Foundation Phase"
            ;;
        setup_dir_struct_hierarchy)
            emoji="📁"
            phase_desc="Directory Structure Phase"
            ;;
        setup_zsh_environment)
            emoji="🐚"
            phase_desc="Shell Environment Phase"
            ;;
        install_essential_cli_tools)
            emoji="🛠️"
            phase_desc="CLI Tools Phase"
            ;;
        install_development_tools)
            emoji="🔧"
            phase_desc="Development Tools Phase"
            ;;
        install_programming_languages)
            emoji="💻"
            phase_desc="Programming Languages Phase"
            ;;
        install_ides_and_gui_productivity_tools)
            emoji="📝"
            phase_desc="IDEs & GUI Tools Phase"
            ;;
        setup_agentic_ai_development)
            emoji="🤖"
            phase_desc="AI Development Phase"
            ;;
        *)
            emoji="⚡"
            phase_desc="Setup Phase"
            ;;
    esac

    if [[ "$AUTO_YES" == "true" ]]; then
        printf "${BOLD}${CYAN}[PHASE ${phase_number}/7]${NC} ${BOLD}${emoji} Initiating %s...${NC}\n" "${phase_desc}"
        printf "[AUTO]${NC} Auto-executing: %s\n" "$step_description"
        REPLY="y"
    else
        printf "${BOLD}${CYAN}[PHASE ${phase_number}/7]${NC} ${BOLD}${emoji} Prepare to enter %s${NC}\n" "${phase_desc}"
        printf "${YELLOW}[CONFIRM]${NC} Ready to proceed with %s? [y/N]: " "$step_description"
        read -r REPLY
    fi
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $step_function
        printf "${GREEN}[INFO]${NC} %s ${GREEN}SUCCESS${NC}\n" "$step_description"
    else
        printf "${BLUE}[INFO]${NC} %s ${YELLOW}SKIPPED${NC}\n" "$step_description"
    fi
}

################################################################################
# Prerequisites: Setup Second Brain Directory Root with HRT Repository
################################################################################
function setup_prerequisites() {
    log_phase "[PHASE 0/7] 🏗️ Setting up prerequisites (Second Brain directory & Homebrew package manager)..."
    
    # Goal 1: Setup Second Brain Directory
    log_goal "[0.1/0.2] Setting up Second Brain directory & HRT repository..."
    
    # Prompt user for second brain directory name
    local sbrn_name="sbrn"

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
    
    # Goal 2: Install Homebrew Package Manager
    log_goal "[0.2/0.2] Installing Homebrew package manager..."
    
    if ! python3 "$BREW_UTIL_SCRIPT" --check-homebrew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_info "Homebrew PATH configuration is managed by HRT .zprofile"
    else
        log_success "Homebrew already installed"
    fi
    python3 "$BREW_UTIL_SCRIPT" --update
    
    generate_phase_summary "0" "Prerequisites Setup"
    
    log_success "Prerequisites setup completed"
}


#################################################################################
# Step 1: Setup Developer Laboratory Directory Structure
#################################################################################
function setup_dir_struct_hierarchy() {
    log_phase "[PHASE 1/7] 📁 Setting up SBRN (Second Brain) directory structure..."

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
 
   generate_phase_summary "1" "Directory Structure"
   
   log_success "SBRN directory structure setup completed"
}

################################################################################
# Step 2: Setup Zsh Environment
################################################################################
function setup_zsh_environment() {
    log_phase "[PHASE 2/7] 🐚 Setting up Zsh environment with My Zsh..."
    
    # Set Zsh configuration directory (must be set before Oh My Zsh installation)
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
    
    # Goal 1: Create XDG-compliant directories for Zsh files
    log_goal "[2.1/2.6] Creating XDG-compliant directories for Zsh files..."
    create_zsh_xdg_directories
    
    # Goal 2: Install Oh My Zsh
    log_goal "[2.2/2.6] Installing Oh My Zsh to custom directory..."
    install_oh_my_zsh
    
    # Goal 3: Install Powerlevel10k theme
    log_goal "[2.3/2.6] Installing Powerlevel10k theme..."
    install_powerlevel10k_theme
    
    # Goal 4: Install essential plugins
    log_goal "[2.4/2.6] Installing essential Zsh plugins that are not part of Oh My Zsh repo..."
    install_zsh_plugins
    
    # Goal 5: Install Meslo Nerd Font
    log_goal "[2.5/2.6] Installing Meslo Nerd Font..."
    install_meslo_font
    
    # Goal 6: Setup Zsh configuration links from HRT
    log_goal "[2.6/2.6] Setting up Zsh configuration links from HRT..."
    setup_zsh_configuration_links
    
    generate_phase_summary "2" "Zsh Environment"
    
    log_success "Zsh environment setup completed"
}

function create_zsh_xdg_directories() {
    mkdir -p "$XDG_STATE_HOME/zsh/sessions"
    mkdir -p "$XDG_CACHE_HOME/zsh"
    log_success "Created Zsh XDG directories (state, cache, sessions)"
}

function install_oh_my_zsh() {
    local zsh_dir="$SBRN_HOME/sys/etc/oh-my-zsh"
    
    if [[ ! -d "$zsh_dir" ]]; then
        export ZSH="$zsh_dir"
        log_goal "[2.2/2.6] Installing Oh My Zsh to $zsh_dir..."
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
        log_goal "[2.3/2.6] Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
        ln -sfn "$SBRN_HOME/sys/hrt/conf/p10k" "$XDG_CONFIG_HOME/p10k"
        log_success "Powerlevel10k theme installed"
    else
        log_success "Powerlevel10k already installed"
    fi
}

function install_zsh_plugins() {
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
    log_phase "[PHASE 3/7] 🛠️ Installing essential CLI tools..."
    
    # Shell Enhancements & CLI Productivity
    install_shell_productivity_tools
    
    # Networking, Security, & Transfer Tools
    install_networking_security_tools
    
    # Text, Regex, JSON, Data Tools
    install_text_data_tools
    
    # Generate phase summary using utility function
    generate_phase_summary "3" "Essential CLI Tools"
    
    log_success "Essential CLI tools installation completed"
}

function install_shell_productivity_tools() {
    log_goal "[3.1/3.3] Installing shell enhancement & productivity tools..."
    
    local shell_tools=(
        "coreutils" "tree" "fzf" "tmux" "screen" "htop" "bat" "fd" "tldr" 
        "eza" "zoxide" "watch" "ncdu" "glances" "lsd" "autoenv" 
        "atuin" "direnv" "broot" "figlet" "lolcat" "ranger" 
        "as-tree" "agedu" "zsh-autosuggestions" "zsh-completions" 
        "bash-completion" "fish" "starship"
    )
    
    brew_install_batch "${shell_tools[@]}"
}


function install_networking_security_tools() {
    log_goal "[3.2/3.3] Installing Networking, Security, & Transfer tools..."
    
    local network_tools=(
        "curl" "wget" "httpie" "netcat" "gnupg" "certbot" "telnet"
    )
    
    brew_install_batch "${network_tools[@]}"
}

function install_text_data_tools() {
    log_goal "[3.3/3.3] Installing basic text processing tools..."
    
    local text_tools=(
        "emacs" "nano" "grep" "colordiff" "base64" "base91" "ccat" "pygments"
    )
    
    brew_install_batch "${text_tools[@]}"

    # Create ripgrep config directory and link configuration
    ln -sfn "$SBRN_HOME/sys/hrt/conf/ripgrep" "$XDG_CONFIG_HOME/ripgrep"
}

################################################################################
# Step 4: Install Development Tools
################################################################################
function install_development_tools() {
    log_phase "[PHASE 4/7] 🔧 Installing developer CLI tools..."
    
    # Developer Tools (VCS, Repos, Git Helpers)
    install_vcs_tools
    
    # Cloud & Containers
    install_cloud_container_tools
    
    # Graphics, OCR, and UI Libraries
    install_graphics_ocr_libraries

    # Code Editors and Development Tools
    install_code_editors_and_tools
    
    # API Development Tools
    install_api_development_tools
    
    # Backend Services and Data Stores
    install_backend_services

    # Configure Git to use diff-so-fancy
    if command -v diff-so-fancy &>/dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX" 2>/dev/null || true
    fi
        
    generate_phase_summary "4" "Development Tools"
    
    log_success "Development tools installation completed"
}

function install_vcs_tools() {
    log_goal "[4.1/4.4] Installing VCS tools..."
    
    local git_tools=(
        "git" "git-extras" "git-lfs" "gh" "ghq" "diff-so-fancy" 
        "delta" "tig" "lazygit" "git-gui" "gibo"
    )
    
    brew_install_batch "${git_tools[@]}"
    
    ln -sfn "$SBRN_HOME/sys/hrt/conf/git" "$XDG_CONFIG_HOME/git"
}

function install_cloud_container_tools() {
    log_goal "[4.2/4.4] Installing cloud & containers tools..."
    
    local cloud_tools=(
        "docker" "docker-compose" "colima" "kubernetes-cli" "helm" 
        "awscli" "dive" "dockviz" "k9s" "kubecolor" "kompose" "krew" 
        "kube-ps1" "kubebuilder" "kustomize" "istioctl" "minikube" 
        "terraform" "pulumi" "railway" "vercel-cli" "ctop"
    )
    
    brew_install_batch "${cloud_tools[@]}"
}

function install_graphics_ocr_libraries() {
    log_goal "[4.3/4.4] Installing graphics, images, and UI libraries..."
    
    local graphics_tools=(
        "librsvg" "gtk+3" "ghostscript" "graphviz" "guile" 
        "pcre" "xerces-c" "pygobject3"
    )
    
    brew_install_batch "${graphics_tools[@]}"
}

function install_code_editors_and_tools() {
    log_goal "[4.4/4.6] Installing development editors and code tools..."
    
    local dev_editors=(
        "vim" "neovim" "ripgrep" "ack"
    )
    
    brew_install_batch "${dev_editors[@]}"
}

function install_api_development_tools() {
    log_goal "[4.5/4.6] Installing API development and documentation tools..."
    
    local api_tools=(
        "jwt-cli" "newman" "openapi-generator" "hugo"
    )
    
    brew_install_batch "${api_tools[@]}"
}

function install_backend_services() {
    log_goal "[4.6/4.6] Installing backend services and data stores..."
    
    # Database and caching services
    local data_services=(
        "postgresql@15" "redis" "etcd"
    )
    
    log_info "Installing database and caching services..."
    brew_install_batch "${data_services[@]}"
    
    # Server and service tools
    local server_tools=(
        "nginx" "sftpgo" "operator-sdk" 
        "logrotate" "rtmpdump"
    )
    
    log_info "Installing server and service tools..."
    brew_install_batch "${server_tools[@]}"
}

################################################################################
# Step 5: Install Core Programming Languages & Runtimes
################################################################################
function install_programming_languages() {
    log_phase "[PHASE 5/7] 💻 Installing core programming languages, runtime environment managers, and build tools..."

    # Core Programming Languages & Runtimes
    install_core_programming_languages
    
    # Runtime Environment Managers
    install_runtime_environment_managers
    
    # Build Automation Tools
    install_build_automation_tools
    
    generate_phase_summary "5" "Programming Languages & Runtimes"
    
    log_success "Programming languages, runtime environment managers, and build tools installation completed"
}

function install_core_programming_languages() {
    log_goal "[5.1/5.3] Installing core programming languages and runtimes..."
    
    local languages=(
        "openjdk@17" "openjdk@21" "python@3.13" "perl" 
        "node" "go" "rust"
    )
    
    brew_install_batch "${languages[@]}"
}

function install_runtime_environment_managers() {
    log_goal "[5.2/5.3] Installing runtime environment managers..."
    
    local runtime_managers=(
        "jenv" "uv" "nvm" "pipx"
    )
    
    brew_install_batch "${runtime_managers[@]}"
    
    # Configure runtime environment managers
    configure_jenv
    configure_uv
    configure_nvm
    configure_pipx
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
    # Check if any Node.js versions exist by looking at the versions directory
    if [[ ! -d "$NVM_DIR/versions/node" ]] || [[ -z "$(ls -A "$NVM_DIR/versions/node" 2>/dev/null)" ]]; then
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
        log_info "Installing Python 3.13 via uv for optimal AI/ML compatibility..."
        uv python install 3.13 2>/dev/null || log_info "Python 3.13 installation skipped (already exist)"
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
    log_goal "[7.2/7.5] Creating ML development environment using uv..."
    
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
    log_goal "[5.3/5.3] Installing build automation tools..."
    
    local build_tools=("maven" "gradle" "poetry" "yarn")
    
    brew_install_batch "${build_tools[@]}"
}

################################################################################
# Step 6: Install GUI Tools like IDE, and Productivity Apps
################################################################################
function install_ides_and_gui_productivity_tools() {
    log_phase "[PHASE 6/7] 📝 Installing IDEs, editors, and GUI productivity tools..."
    
    # Core IDEs and Editors
    install_core_ides_editors
    
    # Productivity, Communication, and Development Support Apps
    install_productivity_and_communication_apps
    
    # Automation, Window Management, and System Tools
    install_automation_and_system_tools
    
    # Development Environment for Data Science and Notebooks
    install_python_notebook_env_tools
    
    # Create symbolic links for command-line access
    create_app_cli_symlinks
    
    generate_phase_summary "6" "IDEs & Productivity Tools"
    
    log_success "IDEs, editors, and GUI productivity tools installation completed"
}

function install_core_ides_editors() {
    log_goal "[6.1/6.5] Installing core IDEs and editors..."
    
    local ides=(
        "visual-studio-code" "intellij-idea-ce" "pycharm-ce" "cursor" "windsurf" "zed" "iterm2"
    )
    
    brew_cask_install_batch "${ides[@]}"

    # Windsurf might not be available via brew, provide manual installation info
    if [[ ! -d "/Applications/Windsurf.app" ]] && [[ ! -d "$HOME/Applications/Windsurf.app" ]]; then
        log_info "Windsurf not found - manual installation required"
        log_info "  → Download from: https://codeium.com/windsurf"
    fi

    # Link VSCode settings from HRT configuration if available
    mkdir -p "$SBRN_HOME/sys/config/code/user"
    ln -sfn $SBRN_HOME/sys/hrt/conf/vscode/settings.json $SBRN_HOME/sys/config/code/user/settings.json
    ln -sfn "${XDG_CONFIG_HOME:-$HOME/.config}/code/user" "$HOME/Library/Application Support/Code/User"
    
    # Install VSCode extensions using Python utility
    setup_vscode_extensions
    setup_iterm_profiles
}

function install_productivity_and_communication_apps() {
    log_goal "[6.2/6.5] Installing productivity, communication, and development support applications..."
    
    # Productivity and communication applications
    local productivity_apps=(
        "notion" "obsidian" "figma" "slack" "github"
    )
    
    # Development and API tools
    local dev_support_apps=(
        "postman" "insomnia" "dbeaver-community" "pgadmin4" "rapidapi"
    )
    
    log_info "Installing productivity and communication apps..."
    brew_cask_install_batch "${productivity_apps[@]}"
    
    log_info "Installing development support applications..."
    brew_cask_install_batch "${dev_support_apps[@]}"
}

function install_automation_and_system_tools() {
    log_goal "[6.3/6.5] Installing automation, window management, and system tools..."
    
    # GUI automation and window management applications (casks)
    local automation_gui_apps=(
        "hammerspoon" "rectangle" "karabiner-elements" "alfred" "bartender"
    )
    
    log_info "Installing GUI automation and window management tools..."
    brew_cask_install_batch "${automation_gui_apps[@]}"
    
    # Command-line system management and notification tools (regular brew packages)
    local system_cli_tools=(
        "terminal-notifier" "mas" "duti" "trash"
    )
    
    log_info "Installing system management CLI tools..."
    brew_install_batch "${system_cli_tools[@]}"
    
    # Handle brew-services (it's already available with Homebrew)
    if python3 "$BREW_UTIL_SCRIPT" --check-homebrew &>/dev/null; then
        log_success "brew-services: Manage background services via Homebrew (available via brew services command)"
    else
        log_warning "Homebrew not available - brew-services requires Homebrew"
    fi
}

function install_python_notebook_env_tools() {
    log_goal "[6.4/6.5] Installing development environment and data science tools..."
    
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

function setup_vscode_extensions() {
    # Skip VSCode extensions setup if cask apps are disabled
    if [[ "$SKIP_CASK_APPS" == "true" ]]; then
        log_info "Skipping VSCode extensions setup (SKIP_CASK_APPS=true)"
        return 0
    fi
    
    # Check if VSCode is installed and available
    if ! command -v code &>/dev/null; then
        log_info "VSCode not found in PATH - skipping extensions setup"
        return 0
    fi
    
    log_info "Installing VSCode extensions using Python utility..."
    
    # Use Python utility for extension management
    python3 "$SBRN_HOME/sys/hrt/scripts/util/vscode_helper.py" \
        --install \
        --extensions-file "$SBRN_HOME/sys/hrt/conf/vscode/extensions.txt" \
        --backup-dir "$SBRN_HOME/sys/hrt/scripts"
}

function setup_iterm_profiles() {
    # Skip iTerm setup if disabled
    if [[ "$SKIP_ITERM_SETUP" == "true" ]]; then
        log_info "Skipping iTerm2 profiles setup (SKIP_ITERM_SETUP=true)"
        return 0
    fi
    
    # Check if iTerm2 is installed
    if [[ ! -d "/Applications/iTerm.app" ]] && [[ ! -d "$HOME/Applications/iTerm.app" ]]; then
        log_info "iTerm2 not found - skipping profiles setup"
        return 0
    fi
    
    log_info "Setting up iTerm2 profiles and color schemes..."
    
    # Create iTerm2 DynamicProfiles directory
    local iterm_profiles_dir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    mkdir -p "$iterm_profiles_dir"
    
    # Install color schemes from HRT configuration
    local colors_dir="$SBRN_HOME/sys/hrt/conf/terminal/colors"
    
    if [[ -d "$colors_dir" ]]; then
        log_info "Installing color schemes from: $colors_dir"
        
        # Install all .itermcolors files silently
        for color_file in "$colors_dir"/*.itermcolors; do
            if [[ -f "$color_file" ]]; then
                local color_name=$(basename "$color_file" .itermcolors)
                log_info "Installing color scheme: $color_name"
                
                # Use open -g to prevent iTerm2 from coming to foreground
                open -g "$color_file" 2>/dev/null || log_warning "Failed to install $color_name"
                
                # Small delay to ensure proper installation
                sleep 1
            fi
        done
        
        log_success "Color schemes installed from HRT configuration"
    else
        log_warning "Color schemes directory not found: $colors_dir"
    fi
    
    # Install profiles from HRT configuration
    local profiles_dir="$SBRN_HOME/sys/hrt/conf/terminal/profiles"
    
    log_info "Installing iTerm2 profiles from: $profiles_dir"
    
    # Install all .json profile files
    for profile_file in "$profiles_dir"/*.json; do
        if [[ -f "$profile_file" ]]; then
            local profile_name=$(basename "$profile_file" .json)
            local dest_file="$iterm_profiles_dir/$profile_name.json"
            
            log_info "Installing profile: $profile_name"
            
            # Copy profile to iTerm2 DynamicProfiles directory
            cp "$profile_file" "$dest_file" 2>/dev/null && {
                log_success "Installed profile: $profile_name"
            } || {
                log_warning "Failed to install profile: $profile_name"
            }
            
            # Small delay to ensure proper installation
            sleep 1
        fi
    done
    
    log_success "All profiles installed from HRT configuration"
    
    # Run additional iTerm management script if it exists in HRT
    local iterm_script="$SBRN_HOME/sys/hrt/scripts/manage-iterm-profiles.sh"
    if [[ -f "$iterm_script" ]] && [[ -x "$iterm_script" ]]; then
        log_info "Running additional iTerm configuration from HRT..."
        "$iterm_script" || log_warning "HRT iTerm script completed with warnings"
    fi
    
    log_success "iTerm2 profiles and color schemes setup completed"
    log_info "Restart iTerm2 to see the new profiles and color schemes"
}

function create_app_cli_symlinks() {
    # Skip CLI symlinks creation if cask apps are disabled
    if [[ "$SKIP_CASK_APPS" == "true" ]]; then
        log_info "Skipping application CLI symlinks setup (SKIP_CASK_APPS=true)"
        return 0
    fi
    
    log_goal "[6.5/6.5] Creating symbolic links for Application command-line access..."

    local bin_dir="$SBRN_HOME/sys/bin"
    mkdir -p "$bin_dir"

    # App symlink definitions: app_name|cli_name|executable_path
    local app_definitions=(
        "Visual Studio Code.app|code|Contents/Resources/app/bin/code"
        "IntelliJ IDEA.app|idea-ultimate|Contents/MacOS/idea"
        "IntelliJ IDEA CE.app|idea|Contents/MacOS/idea"
        "PyCharm.app|pycharm|Contents/MacOS/pycharm"
        "Cursor.app|cursor|Contents/MacOS/Cursor"
        "DBeaver.app|dbeaver|Contents/MacOS/dbeaver"
        "DevToys.app|devtoys|Contents/MacOS/DevToys"
        "LM Studio.app|lmstudio|Contents/MacOS/LM Studio"
        "Figma.app|figma|Contents/MacOS/Figma"
        "Framer.app|framer|Contents/MacOS/Framer"
        "Obsidian.app|obsidian|Contents/MacOS/Obsidian"
        "Notion.app|notion|Contents/MacOS/Notion"
        "GitHub Desktop.app|github|Contents/MacOS/GitHub Desktop"
        "Insomnia.app|insomnia|Contents/MacOS/Insomnia"
        "Postman.app|postman|Contents/MacOS/Postman"
        "Rancher Desktop.app|rancher|Contents/MacOS/Rancher Desktop"
        "RapidAPI.app|rapidapi|Contents/MacOS/RapidAPI"
        "Slack.app|slack|Contents/MacOS/Slack"
        "VirtualBox.app|vbox|Contents/MacOS/VirtualBoxVM"
        "pgAdmin 4.app|pgadmin|Contents/MacOS/pgAdmin 4"
        "zoom.us.app|zoom|Contents/MacOS/zoom.us"
    )

    # Check both /Applications and $HOME/Applications
    for app_def in "${app_definitions[@]}"; do
        local app_name="${app_def%%|*}"
        local remaining="${app_def#*|}"
        local cli_name="${remaining%%|*}"
        local exec_rel_path="${remaining#*|}"
        local found_app_path=""
        
        for base_dir in "/Applications" "$HOME/Applications"; do
            local app_path="$base_dir/$app_name"
            local exec_path="$app_path/$exec_rel_path"
            if [[ -d "$app_path" ]] && [[ -f "$exec_path" ]]; then
                found_app_path="$exec_path"
                break
            fi
        done
        
        if [[ -n "$found_app_path" ]] && [[ ! -L "$bin_dir/$cli_name" ]]; then
            ln -sf "$found_app_path" "$bin_dir/$cli_name"
            log_success "Created symlink for $cli_name -> $found_app_path"
        fi
    done

    # Add bin directory to PATH if not already there
    if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
        export PATH="$bin_dir:$PATH"
        log_success "Added $bin_dir to PATH"
    fi
}

################################################################################
# Step 7: Setup Agentic AI Development Environment
################################################################################
function setup_agentic_ai_development() {
    log_phase "[PHASE 7/7] 🤖 Setting up Agentic AI Development Environment..."
    
    # AI/ML Core Tools & Frameworks
    install_ai_development_tools
    
    # ML Development Environment Setup
    create_ml_dev_environment
    
    # AI Agent Development Frameworks
    install_ai_agent_frameworks
    
    # Local LLM Capabilities
    setup_local_llm 
    
    # Vector Databases & Search
    install_vector_databases
    
    generate_phase_summary "7" "AI Development Environment"
    
    log_success "Agentic AI Development Environment setup completed"
}


function install_ai_development_tools() {
    log_goal "[7.1/7.5] Installing AI/ML Core Tools & Frameworks..."
    
    mkdir -p "$XDG_CONFIG_HOME/ai-tools" "$XDG_DATA_HOME/ai-tools" "$XDG_CACHE_HOME/ai-tools" "$XDG_STATE_HOME/ai-tools"
    
    # Note: pipx configuration is handled in configure_pipx()
    
    local ai_tools=(
        "ollama" "huggingface-cli" "duckdb" "datasette" 
        "sqlite-utils" "uv" "pyenv"
    )
    
    brew_install_batch "${ai_tools[@]}"
    
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
    log_goal "[7.3/7.5] Installing 🤖 AI Agent Development Frameworks via uv environments..."
    
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
        
        # Initialize uv project with Python 3.13
        if ! uv init --python 3.13 .; then
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
    log_goal "[7.4/7.5] Setting up 🧠 Local LLM Capabilities with XDG compliance..."
    
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


function install_vector_databases() {
    log_goal "[7.5/7.5] Installing 🔍 Vector Databases & Search Engines with XDG compliance..."
    
    # Create XDG-compliant directories for vector databases
    mkdir -p "$XDG_DATA_HOME/vector-databases"
    mkdir -p "$XDG_CONFIG_HOME/vector-databases"
    mkdir -p "$XDG_CACHE_HOME/vector-databases"
    
    local vector_tools=(
        "qdrant: Vector search engine for AI applications"
        "chroma: AI-native open-source embedding database (CLI + Python library)"
        "weaviate: Cloud-native vector database (Python library in AI environments)"
        "pinecone: Managed vector database service (Python library in AI environments)"
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
                    if [[ "$tool" == "chroma" ]]; then
                        log_info "Installing $description via pipx..."
                        pipx install chromadb || {
                            log_warning "Failed to install chromadb via pipx"
                            log_info "ChromaDB will be available in AI development environments instead"
                        }
                        
                        # Configure XDG paths for ChromaDB
                        local chroma_config="$XDG_CONFIG_HOME/vector-databases/chromadb.conf"
                        cat > "$chroma_config" << EOF
# ChromaDB XDG-compliant configuration
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/vector-databases/chromadb"
EOF
                        mkdir -p "$XDG_DATA_HOME/vector-databases/chromadb"
                        log_success "$description installed with XDG data dir: $XDG_DATA_HOME/vector-databases/chromadb"
                    else
                        log_info "$description will be available in AI development environments"
                        log_info "Note: pinecone-client is a Python library and will be available in AI development environments"
                        log_success "$description client configured for AI environments"
                    fi
                else
                    if [[ "$tool" == "chroma" ]]; then
                        log_success "$description already installed"
                    else
                        log_success "$description will be available in AI environments"
                    fi
                fi
                ;;
            "weaviate")
                log_info "$description will be available in AI development environments"
                # Create XDG-compliant configuration for Weaviate
                local weaviate_config="$XDG_CONFIG_HOME/vector-databases/weaviate.conf"
                cat > "$weaviate_config" << EOF
# Weaviate XDG-compliant configuration
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"
EOF
                mkdir -p "$XDG_DATA_HOME/vector-databases/weaviate"
                log_success "$description client configured with XDG configuration"
                log_info "Note: weaviate-client is a Python library and will be available in AI development environments"
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

################################################################################
# Utility Functions
################################################################################

# Helper function to install Homebrew packages using Python module
function brew_install() {
    local package="$1"
    python3 "$BREW_UTIL_SCRIPT" --install-formulas "$package"
}

# Optimized batch function to install multiple Homebrew packages using Python module
function brew_install_batch() {
    local packages=("$@")
    python3 "$BREW_UTIL_SCRIPT" --install-formulas "${packages[@]}"
}

# Helper function to install Homebrew Cask applications using Python module
function brew_cask_install() {
    local cask="$1"
    local description="${2:-$cask}"
    
    if [[ $SKIP_CASK_APPS == true ]]; then
        python3 "$BREW_UTIL_SCRIPT" --skip-cask-apps --install-casks "$cask"
    else
        python3 "$BREW_UTIL_SCRIPT" --install-casks "$cask"
    fi
}

# Optimized batch function to install multiple Homebrew Cask applications using Python module
function brew_cask_install_batch() {
    local casks=("$@")
    
    if [[ $SKIP_CASK_APPS == true ]]; then
        python3 "$BREW_UTIL_SCRIPT" --skip-cask-apps --install-casks "${casks[@]}"
    else
        python3 "$BREW_UTIL_SCRIPT" --install-casks "${casks[@]}"
    fi
}

# Helper function to generate phase summaries using Python utility
function generate_phase_summary() {
    local phase_number="$1"
    local phase_title="$2"
    local script_dir="$(dirname "${BASH_SOURCE[0]}")/scripts"
    local summary_lines=()
    
    # Import and call the Python utility
    while IFS= read -r line; do
        summary_lines+=("$line")
    done < <(python3 "$script_dir/devlab_summary.py" "$phase_number")
    
    # Call the original log_phase_summary with imported content
    log_phase_summary "$phase_number/7" "$phase_title" "${summary_lines[@]}"
}

################################################################################
# Argument Parsing
################################################################################
function parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -c|--enable-cask-apps)
                SKIP_CASK_APPS=false
                shift
                ;;
            -i|--enable-iterm-setup)
                SKIP_ITERM_SETUP=false
                shift
                ;;
            -y|--yes)
                AUTO_YES=true
                log_info "Auto-mode enabled: All confirmations will be automatically accepted"
                shift
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
    echo "Usage: $SCRIPT_NAME [OPTIONS]"
    echo ""
    echo "Portable Replicatable Scalable Developer Laboratory Setup for macOS"
    echo ""
    echo "By default, GUI applications and iTerm setup are SKIPPED for faster CLI-focused setup."
    echo "Use the flags below to enable these optional features:"
    echo ""
    echo "Options:"
    echo "  -c, --enable-cask-apps   Enable GUI application installations (VSCode, IDEs, etc.)"
    echo "  -i, --enable-iterm-setup Enable iTerm2 profiles and color schemes setup"
    echo "  -y, --yes               Auto-accept all confirmations (non-interactive mode)"
    echo "  -h, --help              Show this help message and exit"
    echo ""
    echo "Examples:"
    echo "  $SCRIPT_NAME                      # CLI-focused setup (skips GUI apps and iTerm setup)"
    echo "  $SCRIPT_NAME --yes               # Automated CLI-focused setup"
    echo "  $SCRIPT_NAME -c -i               # Full setup with GUI apps and iTerm profiles"
    echo "  $SCRIPT_NAME -c -i -y            # Automated full setup with all features"
    echo "  $SCRIPT_NAME -c                  # Setup with GUI apps, but skip iTerm setup"
}



################################################################################
# Script Entry Point - Only execute when script is run directly, not sourced
################################################################################
# Parse command line arguments
parse_arguments "$@"

# Track build time
SECONDS=0
    
# Check if running on macOS
if [[ $(uname) != "Darwin" ]]; then
    log_error "This script is designed for macOS only"
    exit 1
fi

# Show configuration info and available options
if [[ $SKIP_CASK_APPS == true ]]; then
    printf "${BOLD}${BLUE}[INFO]${NC} CLI-focused setup: GUI applications will be skipped\n"
    printf "${DIM}[HINT]${NC} To include GUI apps (IDEs, productivity tools), use: $SCRIPT_NAME -c\n"
fi

if [[ $SKIP_ITERM_SETUP == true ]]; then
    printf "${BOLD}${BLUE}[INFO]${NC} Basic terminal setup: iTerm2 profiles and colors will be skipped\n"
    printf "${DIM}[HINT]${NC} To include iTerm2 customization, use: $SCRIPT_NAME -i\n"
fi

if [[ $SKIP_CASK_APPS == true && $SKIP_ITERM_SETUP == true ]]; then
    printf "${DIM}[HINT]${NC} For full setup with all features, use: $SCRIPT_NAME -c -i\n"
fi

# Start the main setup process
if [[ "$AUTO_YES" == "true" ]]; then
    printf "${BOLD}[INFO]${NC} Auto-mode enabled: Starting full developer environment setup...\n"
fi

main
