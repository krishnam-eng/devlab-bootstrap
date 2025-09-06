#!/bin/zsh

# Test script for development environment setup functions

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Global variables
SKIP_CASK_APPS=false

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1"; }

# Source the main script functions without executing the entry point
# We'll manually define the functions we need for testing

# Test SBRN directory structure setup
function setup_sbrn_structure() {
    log_step "📁 Setting up SBRN (Second Brain) directory structure..."

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

# Test the directory setup function
case "${1:-}" in
    "test-dirs")
        export SBRN_HOME="$HOME/sbrn"
        setup_sbrn_structure
        echo ""
        log_info "Verifying directory structure:"
        tree "$SBRN_HOME" -d -L 3 2>/dev/null || find "$SBRN_HOME" -type d | head -20
        ;;
    *)
        echo "Usage: $0 [test-dirs]"
        echo ""
        echo "COMMANDS:"
        echo "  test-dirs    Test SBRN directory structure creation"
        ;;
esac
