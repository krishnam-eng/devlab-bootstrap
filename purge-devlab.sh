#!/bin/zsh

################################################################################
# Developer Laboratory Purge Script for macOS
# 
# Author: Balamurugan Krishnamoorthy
# This script removes most components installed by provision-devlab.sh
# while preserving prerequisites (Second Brain structure & Homebrew)
#
# Usage:
#   ./purge-devlab.sh                 # Interactive purge with confirmations
#   ./purge-devlab.sh --dry-run       # Show what would be removed without doing it
#   ./purge-devlab.sh --yes           # Automated purge (use with caution!)
#   ./purge-devlab.sh --selective     # Choose specific categories to purge
#   ./purge-devlab.sh --help          # Show usage options
################################################################################

# Global variables
DRY_RUN=false
AUTO_YES=false
SELECTIVE_MODE=false
SCRIPT_NAME="purge-devlab.sh"

# Path to the Python brew helper utility module
BREW_UTIL_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/scripts/util/brew_helper.py"

# Colors for output (consistent with provision script)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
DIM='\033[2m'
GREY='\033[37m'
NC='\033[0m' # No Color

# Maven-style logging functions
log_info() { printf "${GREY}[INFO]${NC} %s\n" "$1"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }
log_phase() { 
    printf "${GREY}[INFO] ${RED}------------------------------< ${CYAN}PURGE${RED} >-----------------------------------${NC}\n"
    printf "${RED}[PURGE]${NC}  ${1}\n"
    printf "${GREY}[INFO] ${RED}------------------------------------------------------------------------${NC}\n"
}
log_dry_run() { printf "${BLUE}[DRY-RUN]${NC} %s\n" "$1"; }

################################################################################
# Main execution flow
################################################################################
function main() {
    printf "\n${RED}[INIT]${NC} 🧨 Initializing Developer Laboratory Purge Protocol...${NC}\n"
    printf "${RED}[SCAN]${NC} 🔍 Analyzing system for installed devlab components...${NC}\n"
    printf "${GREY}[INFO]${NC} ${RED}========================================================================${NC}\n"
    printf "${GREY}[INFO]${NC} 💥 Developer Laboratory Environment Destruction Sequence v1.0${NC}\n"
    printf "${GREY}[INFO]${NC} 🧹 Cleaning Your Development Environment (Preserving Prerequisites)${NC}\n"
    printf "${GREY}[INFO]${NC} ${RED}========================================================================${NC}\n"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        printf "${BLUE}[DRY-RUN]${NC} Simulation mode: No actual changes will be made${NC}\n"
    fi
    
    printf "${RED}[WARNING]${NC} This will remove most devlab installations except prerequisites!${NC}\n"
    printf "${YELLOW}[PRESERVED]${NC} The following will be kept:${NC}\n"
    printf "  • Second Brain directory structure ($SBRN_HOME)${NC}\n"
    printf "  • Homebrew package manager${NC}\n"
    printf "  • HRT repository and core configurations${NC}\n"
    printf "  • User-created content in PARA directories${NC}\n"
    
    if [[ "$AUTO_YES" != "true" ]] && [[ "$SELECTIVE_MODE" != "true" ]]; then
        printf "\n${BOLD}${RED}[CONFIRM]${NC} Continue with purge? This action will remove development tools! [y/N]: "
        read -r REPLY
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Purge cancelled by user"
            exit 0
        fi
    fi
    
    # Set SBRN_HOME if not already set
    if [[ -z "$SBRN_HOME" ]]; then
        export SBRN_HOME="$HOME/sbrn"
        log_info "Setting SBRN_HOME to default: $SBRN_HOME"
    fi
    
    # Set XDG paths for cleanup
    export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
    export XDG_DATA_HOME="$SBRN_HOME/sys/local/share"
    export XDG_STATE_HOME="$SBRN_HOME/sys/local/state"
    export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"
    
    if [[ "$SELECTIVE_MODE" == "true" ]]; then
        run_selective_purge
    else
        run_full_purge
    fi
    
    # Completion message
    printf "\n${BOLD}${GREEN}------------------------------------------------------------------------${NC}\n"
    printf "${BOLD}${GREEN}PURGE COMPLETED${NC}\n"
    printf "${BOLD}${GREEN}------------------------------------------------------------------------${NC}\n"
    printf "${DIM}[INFO]${NC} Total time: $(( SECONDS / 60 ))m $(( SECONDS % 60 ))s\n"
    printf "${DIM}[INFO]${NC} Finished at: $(date)\n"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        printf "${BLUE}[DRY-RUN]${NC} No actual changes were made - this was a simulation\n"
    else
        printf "${BOLD}${GREEN}[INFO]${NC} Developer Environment purge completed successfully!\n"
        printf "${YELLOW}[NOTE]${NC} Prerequisites (Second Brain & Homebrew) have been preserved\n"
        printf "${CYAN}[HINT]${NC} To re-setup devlab: cd $SBRN_HOME/sys/hrt && ./provision-devlab.sh\n"
    fi
}

function run_selective_purge() {
    log_phase "Selective Purge Mode - Choose categories to remove"
    
    local categories=(
        "ai_development:🤖 AI Development Environment (Phase 7)"
        "ides_gui:📝 IDEs and GUI Productivity Tools (Phase 6)" 
        "programming_languages:💻 Programming Languages & Runtimes (Phase 5)"
        "development_tools:🔧 Development Tools (Phase 4)"
        "cli_tools:🛠️ Essential CLI Tools (Phase 3)"
        "zsh_environment:🐚 Zsh Environment (Phase 2)"
        "directory_cleanup:📁 Directory Structure Cleanup (Phase 1)"
    )
    
    printf "\nSelect categories to purge (separate multiple with spaces):\n"
    for i in "${!categories[@]}"; do
        local category="${categories[$i]}"
        local key="${category%%:*}"
        local description="${category#*:}"
        printf "  %d) %s\n" $((i+1)) "$description"
    done
    
    printf "\nEnter category numbers (e.g., '1 3 5') or 'all' for everything: "
    read -r selection
    
    if [[ "$selection" == "all" ]]; then
        run_full_purge
        return
    fi
    
    for num in $selection; do
        case $num in
            1) confirm_and_run_purge "AI Development Environment" purge_ai_development ;;
            2) confirm_and_run_purge "IDEs and GUI Tools" purge_ides_and_gui_tools ;;
            3) confirm_and_run_purge "Programming Languages" purge_programming_languages ;;
            4) confirm_and_run_purge "Development Tools" purge_development_tools ;;
            5) confirm_and_run_purge "CLI Tools" purge_cli_tools ;;
            6) confirm_and_run_purge "Zsh Environment" purge_zsh_environment ;;
            7) confirm_and_run_purge "Directory Cleanup" purge_directory_structure ;;
            *) log_warning "Invalid selection: $num" ;;
        esac
    done
}

function run_full_purge() {
    log_phase "Full Purge Mode - Removing all devlab components except prerequisites"
    
    # Purge in reverse order of installation (Phase 7 -> 1)
    confirm_and_run_purge "AI Development Environment (Phase 7)" purge_ai_development
    confirm_and_run_purge "IDEs and GUI Productivity Tools (Phase 6)" purge_ides_and_gui_tools  
    confirm_and_run_purge "Programming Languages & Runtimes (Phase 5)" purge_programming_languages
    confirm_and_run_purge "Development Tools (Phase 4)" purge_development_tools
    confirm_and_run_purge "Essential CLI Tools (Phase 3)" purge_cli_tools
    confirm_and_run_purge "Zsh Environment (Phase 2)" purge_zsh_environment
    confirm_and_run_purge "Directory Structure Cleanup (Phase 1)" purge_directory_structure
}

function confirm_and_run_purge() {
    local step_description="$1"
    local step_function="$2"
    
    if [[ "$AUTO_YES" == "true" ]]; then
        printf "${RED}[AUTO]${NC} Auto-executing purge: %s\n" "$step_description"
        REPLY="y"
    else
        printf "${YELLOW}[CONFIRM]${NC} Purge %s? [y/N]: " "$step_description"
        read -r REPLY
    fi
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        $step_function
        if [[ "$DRY_RUN" == "true" ]]; then
            printf "${BLUE}[DRY-RUN]${NC} %s ${BLUE}SIMULATED${NC}\n" "$step_description"
        else
            printf "${GREEN}[INFO]${NC} %s ${GREEN}PURGED${NC}\n" "$step_description"
        fi
    else
        printf "${BLUE}[INFO]${NC} %s ${YELLOW}SKIPPED${NC}\n" "$step_description"
    fi
}

################################################################################
# Phase-specific purge functions
################################################################################

function purge_ai_development() {
    log_info "Purging AI Development Environment (Phase 7)..."
    
    # Remove AI/ML tools installed via brew
    local ai_tools=(
        "ollama" "huggingface-cli" "duckdb" "datasette" 
        "sqlite-utils"
    )
    
    log_info "Removing AI/ML CLI tools..."
    brew_uninstall_batch "${ai_tools[@]}"
    
    # Remove pipx-installed AI tools
    local pipx_ai_tools=("mlflow" "chromadb" "jupyterlab" "notebook")
    
    if command -v pipx &>/dev/null; then
        log_info "Removing pipx-installed AI tools..."
        for tool in "${pipx_ai_tools[@]}"; do
            if pipx list | grep -q "^$tool "; then
                safe_remove "pipx uninstall $tool" "Remove $tool via pipx"
            fi
        done
    fi
    
    # Remove uv AI environments
    local uv_projects=("agentic-ai" "ml-dev")
    if [[ -d "$XDG_DATA_HOME/python-projects" ]]; then
        log_info "Removing uv AI project environments..."
        for project in "${uv_projects[@]}"; do
            local project_path="$XDG_DATA_HOME/python-projects/$project"
            if [[ -d "$project_path" ]]; then
                safe_remove "rm -rf \"$project_path\"" "Remove $project uv environment"
            fi
        done
    fi
    
    # Remove Jupyter kernels
    if [[ -d "$XDG_DATA_HOME/jupyter/kernels" ]]; then
        log_info "Removing custom Jupyter kernels..."
        local kernels=("agentic-ai" "ml-dev")
        for kernel in "${kernels[@]}"; do
            local kernel_path="$XDG_DATA_HOME/jupyter/kernels/$kernel"
            if [[ -d "$kernel_path" ]]; then
                safe_remove "rm -rf \"$kernel_path\"" "Remove $kernel Jupyter kernel"
            fi
        done
    fi
    
    # Clean AI-related XDG directories (but preserve config links)
    local ai_data_dirs=(
        "$XDG_DATA_HOME/ollama"
        "$XDG_DATA_HOME/vector-databases"
        "$XDG_DATA_HOME/mlflow"
        "$XDG_CACHE_HOME/huggingface"
        "$XDG_CACHE_HOME/torch"
        "$XDG_CACHE_HOME/langchain"
        "$XDG_CACHE_HOME/wandb"
        "$XDG_DATA_HOME/wandb"
        "$XDG_DATA_HOME/tensorboard"
    )
    
    log_info "Cleaning AI-related data directories..."
    for dir in "${ai_data_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            safe_remove "rm -rf \"$dir\"" "Remove AI data directory: $(basename "$dir")"
        fi
    done
    
    # Stop Ollama service if running
    if pgrep -f ollama &>/dev/null; then
        safe_remove "pkill -f ollama" "Stop Ollama service"
    fi
    
    # Remove llamafile if installed
    local llamafile_path="$SBRN_HOME/sys/bin/llamafile"
    if [[ -f "$llamafile_path" ]]; then
        safe_remove "rm -f \"$llamafile_path\"" "Remove llamafile binary"
    fi
    
    log_success "AI Development Environment purged"
}

function purge_ides_and_gui_tools() {
    log_info "Purging IDEs and GUI Productivity Tools (Phase 6)..."
    
    # GUI Applications (casks)
    local gui_apps=(
        "visual-studio-code" "intellij-idea-ce" "pycharm-ce" "cursor" "zed" "iterm2"
        "notion" "obsidian" "figma" "slack" "github"
        "postman" "insomnia" "dbeaver-community" "pgadmin4" "rapidapi"
        "hammerspoon" "rectangle" "karabiner-elements" "alfred" "bartender"
    )
    
    log_info "Removing GUI applications..."
    brew_cask_uninstall_batch "${gui_apps[@]}"
    
    # CLI tools related to GUI productivity
    local gui_cli_tools=("terminal-notifier" "mas" "duti" "trash")
    
    log_info "Removing GUI-related CLI tools..."
    brew_uninstall_batch "${gui_cli_tools[@]}"
    
    # Remove VSCode settings symlinks
    local vscode_user_dir="$HOME/Library/Application Support/Code/User"
    if [[ -L "$vscode_user_dir" ]]; then
        safe_remove "unlink \"$vscode_user_dir\"" "Remove VSCode settings symlink"
    fi
    
    # Remove application CLI symlinks
    local bin_dir="$SBRN_HOME/sys/bin"
    if [[ -d "$bin_dir" ]]; then
        log_info "Removing application CLI symlinks..."
        local cli_tools=(
            "code" "idea" "idea-ultimate" "pycharm" "cursor" "dbeaver" 
            "figma" "obsidian" "notion" "github" "insomnia" "postman" 
            "slack" "zoom"
        )
        
        for tool in "${cli_tools[@]}"; do
            if [[ -L "$bin_dir/$tool" ]]; then
                safe_remove "unlink \"$bin_dir/$tool\"" "Remove $tool symlink"
            fi
        done
    fi
    
    # Remove iTerm2 profiles and colors
    local iterm_profiles_dir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    if [[ -d "$iterm_profiles_dir" ]]; then
        safe_remove "rm -rf \"$iterm_profiles_dir\"" "Remove iTerm2 dynamic profiles"
    fi
    
    log_success "IDEs and GUI Tools purged"
}

function purge_programming_languages() {
    log_info "Purging Programming Languages & Runtimes (Phase 5)..."
    
    # Core programming languages
    local languages=(
        "openjdk@17" "openjdk@21" "python@3.13" "perl" 
        "node" "go" "rust"
    )
    
    log_info "Removing core programming languages..."
    brew_uninstall_batch "${languages[@]}"
    
    # Runtime environment managers
    local runtime_managers=("jenv" "uv" "nvm" "pipx")
    
    log_info "Removing runtime environment managers..."
    brew_uninstall_batch "${runtime_managers[@]}"
    
    # Build automation tools
    local build_tools=("maven" "gradle" "poetry" "yarn")
    
    log_info "Removing build automation tools..."
    brew_uninstall_batch "${build_tools[@]}"
    
    # Clean runtime-specific directories
    local runtime_dirs=(
        "$XDG_DATA_HOME/jenv"
        "$XDG_DATA_HOME/nvm"
        "$XDG_DATA_HOME/uv"
        "$XDG_DATA_HOME/pipx"
        "$XDG_DATA_HOME/pyenv"
        "$HOME/.jenv"
        "$XDG_DATA_HOME/android"
        "$XDG_DATA_HOME/gradle"
    )
    
    log_info "Cleaning runtime environment directories..."
    for dir in "${runtime_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            safe_remove "rm -rf \"$dir\"" "Remove runtime directory: $(basename "$dir")"
        fi
    done
    
    log_success "Programming Languages & Runtimes purged"
}

function purge_development_tools() {
    log_info "Purging Development Tools (Phase 4)..."
    
    # VCS tools
    local git_tools=(
        "git-extras" "git-lfs" "gh" "ghq" "diff-so-fancy" 
        "delta" "tig" "lazygit" "git-gui" "gibo"
    )
    
    log_info "Removing VCS tools (keeping core git)..."
    brew_uninstall_batch "${git_tools[@]}"
    
    # Cloud & container tools
    local cloud_tools=(
        "docker" "docker-compose" "colima" "kubernetes-cli" "helm" 
        "awscli" "dive" "dockviz" "k9s" "kubecolor" "kompose" "krew" 
        "kube-ps1" "kubebuilder" "kustomize" "istioctl" "minikube" 
        "terraform" "pulumi" "railway" "vercel-cli" "ctop"
    )
    
    log_info "Removing cloud & container tools..."
    brew_uninstall_batch "${cloud_tools[@]}"
    
    # Graphics and libraries
    local graphics_tools=(
        "librsvg" "gtk+3" "ghostscript" "graphviz" "guile" 
        "pcre" "xerces-c" "pygobject3"
    )
    
    log_info "Removing graphics and UI libraries..."
    brew_uninstall_batch "${graphics_tools[@]}"
    
    # Development editors
    local dev_editors=("vim" "neovim" "ripgrep" "ack")
    
    log_info "Removing development editors..."
    brew_uninstall_batch "${dev_editors[@]}"
    
    # API development tools
    local api_tools=("jwt-cli" "newman" "openapi-generator" "hugo")
    
    log_info "Removing API development tools..."
    brew_uninstall_batch "${api_tools[@]}"
    
    # Backend services
    local data_services=("postgresql@15" "redis" "etcd")
    local server_tools=("nginx" "sftpgo" "operator-sdk" "logrotate" "rtmpdump")
    
    log_info "Removing backend services..."
    brew_uninstall_batch "${data_services[@]}"
    brew_uninstall_batch "${server_tools[@]}"
    
    # Remove git configuration symlink (but preserve the original config files)
    if [[ -L "$XDG_CONFIG_HOME/git" ]]; then
        safe_remove "unlink \"$XDG_CONFIG_HOME/git\"" "Remove git config symlink (preserving original)"
    fi
    
    log_success "Development Tools purged"
}

function purge_cli_tools() {
    log_info "Purging Essential CLI Tools (Phase 3)..."
    
    # Shell productivity tools
    local shell_tools=(
        "tree" "fzf" "tmux" "screen" "htop" "bat" "fd" "tldr" 
        "eza" "zoxide" "watch" "ncdu" "glances" "lsd" "autoenv" 
        "atuin" "direnv" "broot" "figlet" "lolcat" "ranger" 
        "as-tree" "agedu" "zsh-autosuggestions" "zsh-completions" 
        "bash-completion" "fish" "starship"
    )
    
    log_info "Removing shell productivity tools (keeping coreutils)..."
    brew_uninstall_batch "${shell_tools[@]}"
    
    # Networking and security tools
    local network_tools=("curl" "wget" "httpie" "netcat" "gnupg" "certbot" "telnet")
    
    log_info "Removing networking & security tools..."
    brew_uninstall_batch "${network_tools[@]}"
    
    # Text processing tools
    local text_tools=("emacs" "nano" "grep" "colordiff" "base64" "base91" "ccat")
    
    log_info "Removing text processing tools..."
    brew_uninstall_batch "${text_tools[@]}"
    
    # Remove ripgrep config symlink
    if [[ -L "$XDG_CONFIG_HOME/ripgrep" ]]; then
        safe_remove "unlink \"$XDG_CONFIG_HOME/ripgrep\"" "Remove ripgrep config symlink"
    fi
    
    log_success "Essential CLI Tools purged"
}

function purge_zsh_environment() {
    log_info "Purging Zsh Environment (Phase 2)..."
    
    # Remove Oh My Zsh installation
    local oh_my_zsh_dir="$SBRN_HOME/sys/etc/oh-my-zsh"
    if [[ -d "$oh_my_zsh_dir" ]]; then
        safe_remove "rm -rf \"$oh_my_zsh_dir\"" "Remove Oh My Zsh installation"
    fi
    
    # Remove Powerlevel10k theme
    local p10k_themes_dir="$oh_my_zsh_dir/custom/themes"
    if [[ -d "$p10k_themes_dir/powerlevel10k" ]]; then
        safe_remove "rm -rf \"$p10k_themes_dir/powerlevel10k\"" "Remove Powerlevel10k theme"
    fi
    
    # Remove Zsh plugins
    local plugins_dir="$oh_my_zsh_dir/custom/plugins"
    local zsh_plugins=(
        "zsh-autosuggestions" "zsh-syntax-highlighting" 
        "history-substring-search" "zsh-autoswitch-virtualenv"
    )
    
    if [[ -d "$plugins_dir" ]]; then
        log_info "Removing custom Zsh plugins..."
        for plugin in "${zsh_plugins[@]}"; do
            if [[ -d "$plugins_dir/$plugin" ]]; then
                safe_remove "rm -rf \"$plugins_dir/$plugin\"" "Remove $plugin plugin"
            fi
        done
    fi
    
    # Remove Meslo Nerd Font
    local font_dir="$HOME/Library/Fonts"
    if [[ -f "$font_dir/MesloLGS NF Regular.ttf" ]]; then
        log_info "Removing Meslo Nerd Font files..."
        safe_remove "rm -f \"$font_dir\"/MesloLGS*" "Remove Meslo Nerd Font"
    fi
    
    # Remove Zsh configuration symlinks (but preserve original files in HRT)
    if [[ -L ~/.zshenv ]]; then
        safe_remove "unlink ~/.zshenv" "Remove .zshenv symlink (preserving original)"
    fi
    
    if [[ -L "$XDG_CONFIG_HOME/zsh" ]]; then
        safe_remove "unlink \"$XDG_CONFIG_HOME/zsh\"" "Remove Zsh config symlink (preserving original)"
    fi
    
    if [[ -L "$XDG_CONFIG_HOME/p10k" ]]; then
        safe_remove "unlink \"$XDG_CONFIG_HOME/p10k\"" "Remove p10k config symlink (preserving original)"
    fi
    
    # Clean Zsh XDG directories
    local zsh_dirs=(
        "$XDG_STATE_HOME/zsh"
        "$XDG_CACHE_HOME/zsh"
    )
    
    log_info "Cleaning Zsh XDG directories..."
    for dir in "${zsh_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            safe_remove "rm -rf \"$dir\"" "Remove Zsh directory: $(basename "$dir")"
        fi
    done
    
    log_success "Zsh Environment purged"
}

function purge_directory_structure() {
    log_info "Purging Directory Structure (Phase 1) - Cleaning non-essential parts..."
    
    # Unhide standard user folders that were hidden
    local user_folders=("Movies" "Music" "Desktop" "Public" "Pictures" "Library")
    
    log_info "Unhiding standard user folders..."
    for folder in "${user_folders[@]}"; do
        if [[ -d "$HOME/$folder" ]]; then
            safe_remove "chflags nohidden \"$HOME/$folder\"" "Unhide $folder"
        fi
    done
    
    # Clean XDG directories but preserve the structure
    log_info "Cleaning XDG cache and temporary data..."
    if [[ -d "$XDG_CACHE_HOME" ]]; then
        # Remove cache contents but keep directory structure
        find "$XDG_CACHE_HOME" -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \; 2>/dev/null || true
        log_info "Cleaned XDG cache directory contents"
    fi
    
    # Clean up empty directories in sys/bin
    local bin_dir="$SBRN_HOME/sys/bin"
    if [[ -d "$bin_dir" ]]; then
        # Remove any remaining symlinks or files
        find "$bin_dir" -type l -delete 2>/dev/null || true
        find "$bin_dir" -type f -delete 2>/dev/null || true
        
        # Remove directory if empty
        if [[ -z "$(ls -A "$bin_dir" 2>/dev/null)" ]]; then
            safe_remove "rmdir \"$bin_dir\"" "Remove empty bin directory"
        fi
    fi
    
    # Note: We preserve the core PARA structure and HRT repository
    log_info "Preserving core PARA structure: proj, area, rsrc, arch"
    log_info "Preserving HRT repository and essential configurations"
    
    log_success "Directory Structure cleaned (core structure preserved)"
}

################################################################################
# Utility Functions
################################################################################

function safe_remove() {
    local command="$1"
    local description="$2"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_dry_run "$description: $command"
    else
        log_info "$description"
        eval "$command" 2>/dev/null || log_warning "Failed to execute: $command"
    fi
}

function brew_uninstall() {
    local package="$1"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        if brew list "$package" &>/dev/null; then
            log_dry_run "Would uninstall brew package: $package"
        fi
    else
        if brew list "$package" &>/dev/null; then
            log_info "Uninstalling brew package: $package"
            brew uninstall "$package" 2>/dev/null || log_warning "Failed to uninstall $package"
        fi
    fi
}

function brew_uninstall_batch() {
    local packages=("$@")
    
    for package in "${packages[@]}"; do
        brew_uninstall "$package"
    done
}

function brew_cask_uninstall() {
    local cask="$1"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        if brew list --cask "$cask" &>/dev/null; then
            log_dry_run "Would uninstall brew cask: $cask"
        fi
    else
        if brew list --cask "$cask" &>/dev/null; then
            log_info "Uninstalling brew cask: $cask"
            brew uninstall --cask "$cask" 2>/dev/null || log_warning "Failed to uninstall cask $cask"
        fi
    fi
}

function brew_cask_uninstall_batch() {
    local casks=("$@")
    
    for cask in "${casks[@]}"; do
        brew_cask_uninstall "$cask"
    done
}

################################################################################
# Argument Parsing
################################################################################
function parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                DRY_RUN=true
                log_info "Dry-run mode enabled: No actual changes will be made"
                shift
                ;;
            -y|--yes)
                AUTO_YES=true
                log_info "Auto-mode enabled: All confirmations will be automatically accepted"
                shift
                ;;
            -s|--selective)
                SELECTIVE_MODE=true
                log_info "Selective mode enabled: Choose specific categories to purge"
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
    echo "Developer Laboratory Purge Script for macOS"
    echo "Removes most components installed by provision-devlab.sh while preserving prerequisites"
    echo ""
    echo "PRESERVED COMPONENTS:"
    echo "  • Second Brain directory structure (\$SBRN_HOME)"
    echo "  • Homebrew package manager"
    echo "  • HRT repository and core configurations"
    echo "  • User-created content in PARA directories"
    echo ""
    echo "Options:"
    echo "  --dry-run            Show what would be removed without making changes"
    echo "  -s, --selective      Choose specific categories to purge (interactive)"
    echo "  -y, --yes           Auto-accept all confirmations (use with caution!)"
    echo "  -h, --help          Show this help message and exit"
    echo ""
    echo "Examples:"
    echo "  $SCRIPT_NAME --dry-run          # Simulate purge to see what would be removed"
    echo "  $SCRIPT_NAME --selective        # Choose specific categories to remove"
    echo "  $SCRIPT_NAME                    # Interactive purge with confirmations"
    echo "  $SCRIPT_NAME --yes              # Automated purge (dangerous!)"
    echo ""
    echo "CATEGORIES (when using --selective):"
    echo "  1) AI Development Environment (Phase 7)"
    echo "  2) IDEs and GUI Productivity Tools (Phase 6)"
    echo "  3) Programming Languages & Runtimes (Phase 5)"
    echo "  4) Development Tools (Phase 4)"
    echo "  5) Essential CLI Tools (Phase 3)"
    echo "  6) Zsh Environment (Phase 2)"
    echo "  7) Directory Structure Cleanup (Phase 1)"
}

################################################################################
# Script Entry Point
################################################################################

# Parse command line arguments
parse_arguments "$@"

# Track purge time
SECONDS=0

# Check if running on macOS
if [[ $(uname) != "Darwin" ]]; then
    log_error "This script is designed for macOS only"
    exit 1
fi

# Start the main purge process
main