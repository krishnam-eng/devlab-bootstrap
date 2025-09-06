#!/bin/zsh

################################################################################
# BIOS-for-macOS: Comprehensive System Initialization and Setup Script
# 
# This script mimics the BIOS boot sequence but adapted for macOS:
# 1. Power-On Self-Test (POST) equivalent - System health checks
# 2. Device enumeration - Hardware and peripheral detection  
# 3. System resource configuration - Environment and settings
# 4. Boot device selection - Development environment setup
# 5. Bootloader core - Load essential development tools and configs
################################################################################

set -euo pipefail

# Global variables
DRY_RUN=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_dry_run() { echo -e "${PURPLE}[DRY-RUN]${NC} $1"; }

# Dry-run helper functions
dry_run_command() {
    local cmd="$1"
    local description="${2:-}"
    if [[ $DRY_RUN == true ]]; then
        if [[ -n "$description" ]]; then
            log_dry_run "Would run: $description"
        fi
        log_dry_run "Command: $cmd"
    else
        eval "$cmd"
    fi
}

dry_run_mkdir() {
    local dirs="$1"
    if [[ $DRY_RUN == true ]]; then
        log_dry_run "Would create directories: $dirs"
    else
        mkdir -p "$dirs"
    fi
}

dry_run_brew_install() {
    local package="$1"
    if [[ $DRY_RUN == true ]]; then
        log_dry_run "Would install via Homebrew: $package"
    else
        if ! command -v "$package" &>/dev/null; then
            brew install "$package"
        fi
    fi
}

dry_run_defaults_write() {
    local domain="$1"
    local key="$2" 
    local value="$3"
    if [[ $DRY_RUN == true ]]; then
        log_dry_run "Would set defaults: $domain $key $value"
    else
        defaults write "$domain" "$key" "$value"
    fi
}

# Main execution flow
function main() {
    if [[ $DRY_RUN == true ]]; then
        log_info "🔍 DRY-RUN MODE: Showing what would be executed..."
        log_info "💡 This preview shows planned actions without making changes"
        echo ""
    fi
    
    log_info "Starting BIOS-equivalent initialization for macOS..."
    
    # Stage 1: Power-On Self-Test (POST)
    post_system_checks
    
    # Stage 2: Device Enumeration
    enumerate_devices
    
    # Stage 3: System Resource Configuration
    configure_system_resources
    
    # Stage 4: Boot Device Selection (Development Environment)
    select_boot_environment
    
    # Stage 5: Load Bootloader Core (Essential Tools)
    load_bootloader_core
    
    if [[ $DRY_RUN == true ]]; then
        echo ""
        log_info "🔍 DRY-RUN SUMMARY:"
        log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        log_dry_run "No actual changes were made to your system"
        log_dry_run "To execute the real installation, run: $0"
        log_dry_run "To see this preview again, run: $0 --dry-run"
        echo ""
    fi
    log_success "BIOS-equivalent initialization completed successfully!"
}

################################################################################
# Stage 1: Power-On Self-Test (POST) - System Health Checks
################################################################################
function post_system_checks() {
    log_info "🔍 Stage 1: Performing Power-On Self-Test (POST) equivalent..."
    
    _check_system_integrity

    _check_cpu_and_memory
    _check_storage_devices
    _check_network_connectivity
    
    _check_peripherals
    
    log_success "POST checks completed successfully"
}

function _check_system_integrity() {
    log_info "Checking system integrity..."
    
    # Check macOS version and system info
    sw_vers
    
    # Check system uptime and load
    uptime
    
    # Check disk usage
    df -h
    
    # Check system logs for critical errors
    /usr/bin/log show --predicate 'eventType == logEvent AND (category == "kernel" OR category == "system")' --info --last 1h | tail -20
}

function _check_cpu_and_memory() {
    log_info "Checking CPU and Memory..."
    
    # CPU information
    sysctl -n machdep.cpu.brand_string
    sysctl -n hw.ncpu
    sysctl -n hw.physicalcpu
    sysctl -n hw.logicalcpu
    
    # Memory information
    memory_pressure
    vm_stat
    
    # System activity
    top -l 1 -n 10 | head -20
}

function _check_storage_devices() {
    log_info "Checking storage devices..."
    
    # List all mounted volumes
    mount | grep -E '^/dev/'
    
    # Disk utility information
    diskutil list
    
    # Check disk health
    diskutil verifyVolume /
    
    # Check available space
    df -h
}

function _check_peripherals() {
    log_info "Checking peripherals and hardware..."
    
    # USB devices
    system_profiler SPUSBDataType | grep -E "(Product ID|Vendor ID|Product Name)" | head -20
    
    # Audio devices
    system_profiler SPAudioDataType | grep -E "Device Name:" | head -10
    
    # Camera devices
    system_profiler SPCameraDataType | grep -E "Model ID:" | head -5
    
    # Bluetooth devices
    system_profiler SPBluetoothDataType | grep -E "Device Name|Address" | head -10
}

function _check_network_connectivity() {
    log_info "Checking network connectivity..."
    
    # Network interfaces
    ifconfig | grep -E "^[a-z]" | cut -d: -f1
    
    # Active network connections
    netstat -rn | head -10
    
    # DNS resolution test
    nslookup google.com | head -5
    
    # Internet connectivity test
    ping -c 3 8.8.8.8 || log_warning "Internet connectivity issues detected"
}

################################################################################
# Stage 2: Device Enumeration
################################################################################
function enumerate_devices() {
    log_info "🔍 Stage 2: Enumerating devices and hardware..."
    
    _enumerate_cpu_memory
    _enumerate_storage
    _enumerate_network_devices
    _enumerate_peripherals
    _set_hostname
    
    log_success "Device enumeration completed"
}

function _enumerate_cpu_memory() {
    log_info "Enumerating CPU and Memory..."
    
    # Detailed CPU info
    sysctl -a | grep machdep.cpu | head -15
    
    # Memory details
    sysctl -a | grep hw.mem | head -10
}

function _enumerate_storage() {
    log_info "Enumerating storage devices..."
    
    # Detailed disk information
    system_profiler SPStorageDataType
    
    # SMART status (if available)
    diskutil info / | grep -E "(SMART|Solid State)"
}

function _enumerate_network_devices() {
    log_info "Enumerating network devices..."
    
    # Network hardware
    networksetup -listallhardwareports
    
    # Wi-Fi information
    networksetup -getairportnetwork en0 2>/dev/null || log_info "Wi-Fi not connected or not available"
    
    # Ethernet status
    networksetup -getinfo "Ethernet" 2>/dev/null || log_info "Ethernet not configured"
}

function _enumerate_peripherals() {
    log_info "Enumerating peripherals..."
    
    # Complete hardware overview
    system_profiler SPHardwareDataType
    
    # External displays
    system_profiler SPDisplaysDataType | grep -E "Display Type|Resolution"
}

function _set_hostname() {
    log_info "Setting/verifying hostname..."
    
    current_hostname=$(hostname)
    log_info "Current hostname: $current_hostname"
    
    # Optionally set a new hostname (uncomment and modify as needed)
    # sudo scutil --set HostName "new-hostname"
    # sudo scutil --set LocalHostName "new-hostname"
    # sudo scutil --set ComputerName "new-hostname"
}

################################################################################
# Stage 3: System Resource Configuration
################################################################################
function configure_system_resources() {
    log_info "🔧 Stage 3: Configuring system resources..."
    
    _configure_environment
    _configure_security
    _configure_performance
    _configure_development_settings
    
    log_success "System resource configuration completed"
}

function _configure_environment() {
    log_info "Configuring environment variables..."
    
    # Ensure SBRN_HOME is set
    if [[ -z "${SBRN_HOME:-}" ]]; then
        if [[ $DRY_RUN == true ]]; then
            log_dry_run "Would set SBRN_HOME to $HOME/sbrn"
        else
            export SBRN_HOME="$HOME/sbrn"
            log_info "Set SBRN_HOME to $SBRN_HOME"
        fi
    fi
    
    # Create essential directories
    dry_run_mkdir "$SBRN_HOME/{sys,proj,areas,res,arch}"
    
    # Set up XDG directories
    dry_run_mkdir "$SBRN_HOME/sys/config"
    dry_run_mkdir "$SBRN_HOME/sys/local/share"
    dry_run_mkdir "$SBRN_HOME/sys/local/state"
    dry_run_mkdir "$SBRN_HOME/sys/cache"
}

function _configure_security() {
    log_info "Configuring security settings..."
    
    # Check and configure firewall
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
    
    # Check FileVault status
    fdesetup status
    
    # Check Gatekeeper status
    spctl --status
    
    # Check System Integrity Protection
    csrutil status
}

function _configure_performance() {
    log_info "Configuring performance settings..."
    
    # Set energy saver preferences for optimal performance
    dry_run_command "sudo pmset -a hibernatemode 0" "Disable hibernation"
    dry_run_command "sudo pmset -a standby 0" "Disable standby"
    dry_run_command "sudo pmset -a powernap 0" "Disable Power Nap"
    
    # Configure spotlight indexing (exclude certain directories)
    dry_run_command "sudo mdutil -i off \"$SBRN_HOME/arch\" 2>/dev/null || true" "Exclude archive directory from Spotlight"
    dry_run_command "sudo mdutil -i off \"$SBRN_HOME/sys/cache\" 2>/dev/null || true" "Exclude cache directory from Spotlight"
}

function _configure_development_settings() {
    log_info "Configuring development environment settings..."
    
    # Show hidden files in Finder
    dry_run_defaults_write "com.apple.finder" "AppleShowAllFiles" "-bool true"
    
    # Show file extensions in Finder
    dry_run_defaults_write "NSGlobalDomain" "AppleShowAllExtensions" "-bool true"
    
    # Disable automatic capitalization and smart quotes (useful for coding)
    dry_run_defaults_write "NSGlobalDomain" "NSAutomaticCapitalizationEnabled" "-bool false"
    dry_run_defaults_write "NSGlobalDomain" "NSAutomaticQuoteSubstitutionEnabled" "-bool false"
    dry_run_defaults_write "NSGlobalDomain" "NSAutomaticDashSubstitutionEnabled" "-bool false"
    
    # Speed up Mission Control animations
    dry_run_defaults_write "com.apple.dock" "expose-animation-duration" "-float 0.1"
    
    # Restart Finder and Dock to apply changes
    dry_run_command "killall Finder 2>/dev/null || true" "Restart Finder"
    dry_run_command "killall Dock 2>/dev/null || true" "Restart Dock"
}

################################################################################
# Stage 4: Boot Device Selection (Development Environment Setup)
################################################################################
function select_boot_environment() {
    log_info "🚀 Stage 4: Selecting boot environment (Development setup)..."
    
    _setup_package_managers
    _setup_shell_environment
    _setup_git_environment
    
    log_success "Boot environment selection completed"
}

function _setup_package_managers() {
    log_info "Setting up package managers..."
    
    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        if [[ $DRY_RUN == true ]]; then
            log_dry_run "Would install Homebrew via:"
            log_dry_run "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            # Add Homebrew to PATH for Apple Silicon
            if [[ $(uname -m) == "arm64" ]]; then
                log_dry_run "Would add Homebrew to PATH in ~/.zprofile for Apple Silicon"
            fi
        else
            log_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for Apple Silicon
            if [[ $(uname -m) == "arm64" ]]; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
        fi
    else
        log_success "Homebrew already installed"
        if [[ $DRY_RUN == false ]]; then
            brew --version
        fi
    fi
    
    # Update Homebrew
    dry_run_command "brew update" "Update Homebrew package lists"
}

function _setup_shell_environment() {
    log_info "Setting up shell environment..."
    
    # Ensure zsh is the default shell
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        log_info "Setting zsh as default shell..."
        chsh -s /bin/zsh
    fi
    
    # Link configuration files if they exist
    if [[ -f "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ]]; then
        ln -sf "$SBRN_HOME/sys/hrt/conf/zsh/.zshenv" ~/.zshenv
        log_success "Linked .zshenv configuration"
    fi
}

function _setup_git_environment() {
    log_info "Setting up Git environment..."
    
    # Install Git if not present
    if ! command -v git &>/dev/null; then
        brew install git
    fi
    
    # Install GitHub CLI
    if ! command -v gh &>/dev/null; then
        brew install gh
        log_success "Installed GitHub CLI"
    fi
    
    # Check Git configuration
    if ! git config --global user.name &>/dev/null; then
        log_warning "Git user.name not configured. Please run: git config --global user.name 'Your Name'"
    fi
    
    if ! git config --global user.email &>/dev/null; then
        log_warning "Git user.email not configured. Please run: git config --global user.email 'your.email@example.com'"
    fi
}

################################################################################
# Stage 5: Load Bootloader Core (Essential Development Tools)
################################################################################
function load_bootloader_core() {
    log_info "🔧 Stage 5: Loading bootloader core (Essential tools)..."
    
    _install_essential_tools
    _setup_development_directories
    _clone_essential_repositories
    _configure_ssh_keys
    
    log_success "Bootloader core loaded successfully"
}

function _install_essential_tools() {
    log_info "Installing essential development tools..."
    
    # Essential CLI tools
    local essential_tools=(
        "tree"              # Directory tree visualization
        "wget"              # File downloader
        "curl"              # Data transfer tool
        "jq"                # JSON processor
        "htop"              # System monitor
        "vim"               # Text editor
        "tmux"              # Terminal multiplexer
        "fzf"               # Fuzzy finder
        "ripgrep"           # Fast text search
        "bat"               # Better cat
        "exa"               # Better ls
        "fd"                # Better find
        "tldr"              # Simplified man pages
    )
    
    for tool in "${essential_tools[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            if [[ $DRY_RUN == true ]]; then
                log_dry_run "Would install: $tool"
            else
                log_info "Installing $tool..."
                brew install "$tool"
            fi
        else
            log_success "$tool already installed"
        fi
    done
}

function _setup_development_directories() {
    log_info "Setting up development directory structure..."
    
    # Create PARA structure if not exists
    dry_run_mkdir "$SBRN_HOME/{proj/{corp,oss,learn,lab,exp},areas/{work,personal,community,academic},res/{notes,templates,refs},arch/{proj,area},sys}"
    
    # Create development-specific directories
    dry_run_mkdir "$HOME/Development/{Tools,Libraries,Workspace}"
    
    log_success "Development directories created"
}

function _clone_essential_repositories() {
    log_info "Cloning essential repositories..."
    
    # Only clone if GitHub authentication is set up
    if gh auth status &>/dev/null; then
        # Clone notes repository if it doesn't exist
        if [[ ! -d "$SBRN_HOME/res/notes/learning-journal" ]]; then
            gh repo clone krishnam-eng/sbrain-res-notes-learning-journal "$SBRN_HOME/res/notes/learning-journal" 2>/dev/null || log_warning "Could not clone notes repository"
        fi
    else
        log_warning "GitHub CLI not authenticated. Run 'gh auth login' to clone repositories"
    fi
}

function _configure_ssh_keys() {
    log_info "Configuring SSH keys..."
    
    # Generate SSH key if it doesn't exist
    if [[ ! -f ~/.ssh/id_ed25519 ]]; then
        if [[ $DRY_RUN == true ]]; then
            log_dry_run "Would generate SSH key:"
            log_dry_run "ssh-keygen -t ed25519 -C \"$(whoami)@$(hostname)\" -f ~/.ssh/id_ed25519 -N \"\""
            log_dry_run "Would start SSH agent and add key"
            log_dry_run "Would display public key for GitHub account setup"
        else
            log_info "Generating SSH key..."
            ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)" -f ~/.ssh/id_ed25519 -N ""
            
            # Start SSH agent and add key
            eval "$(ssh-agent -s)"
            ssh-add ~/.ssh/id_ed25519
            
            log_success "SSH key generated. Add the following public key to your GitHub account:"
            echo ""
            cat ~/.ssh/id_ed25519.pub
            echo ""
        fi
    else
        log_success "SSH key already exists"
    fi
    
    # Ensure SSH agent is running and key is loaded
    if [[ $DRY_RUN == true ]]; then
        log_dry_run "Would ensure SSH agent is running and key is loaded"
    else
        if ! ssh-add -l &>/dev/null; then
            eval "$(ssh-agent -s)"
            ssh-add ~/.ssh/id_ed25519 2>/dev/null || true
        fi
    fi
}

################################################################################
# Utility Functions
################################################################################
function show_system_summary() {
    log_info "System Summary:"
    echo "=================="
    echo "macOS Version: $(sw_vers -productVersion)"
    echo "Hardware: $(sysctl -n hw.model)"
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
    echo "Hostname: $(hostname)"
    echo "Shell: $SHELL"
    echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "Git: $(git --version 2>/dev/null || echo 'Not installed')"
    echo "SBRN_HOME: ${SBRN_HOME:-'Not set'}"
    echo "=================="
}

################################################################################
# Script Entry Point
################################################################################

# Function to show usage
show_usage() {
    local script_name="${0##*/}"
    echo "Usage: $script_name [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  --dry-run, -n    Show what would be executed without making changes"
    echo "  --help, -h       Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  $script_name               Run the full BIOS initialization"
    echo "  $script_name --dry-run     Preview what would be executed"
    echo "  $script_name -n            Same as --dry-run"
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run|-n)
                DRY_RUN=true
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

if [[ "${BASH_SOURCE[0]:-$0}" == "${0}" ]]; then
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
    
    # Show dry-run warning if applicable
    if [[ $DRY_RUN == true ]]; then
        log_warning "DRY-RUN MODE: No changes will be made to your system"
        echo ""
    fi
    
    # Ask for confirmation (skip in dry-run mode)
    if [[ $DRY_RUN == true ]]; then
        main
    else
        read -p "Proceed with BIOS-equivalent initialization? (y/N): " -n 1 -r
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
fi
