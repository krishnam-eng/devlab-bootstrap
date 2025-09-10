#!/bin/zsh

################################################################################
# Homebrew Selective Upgrade Script
# 
# This script allows you to upgrade Homebrew packages with semantic version
# filtering to skip patch-only updates or minor version updates.
#
# Usage:
#   ./brew-selective-upgrade.sh [major|major-minor|all]
#
# Options:
#   major       - Only upgrade packages with major version changes
#   major-minor - Upgrade packages with major or minor version changes (default)
#   all         - Upgrade all packages (same as 'brew upgrade')
#
# Author: Balamurugan Krishnamoorthy
################################################################################

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

function show_usage() {
    echo "Usage: ${0##*/} [OPTION]"
    echo ""
    echo "Selectively upgrade Homebrew packages based on semantic versioning."
    echo ""
    echo "OPTIONS:"
    echo "  major         Only upgrade packages with major version changes (1.x.x → 2.x.x)"
    echo "  major-minor   Upgrade packages with major or minor changes (1.2.x → 1.3.x or 2.x.x)"
    echo "  all           Upgrade all packages (equivalent to 'brew upgrade')"
    echo "  --help, -h    Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  ${0##*/}                 # Interactive mode - choose upgrade strategy"
    echo "  ${0##*/} major-minor     # Upgrade major and minor versions only"
    echo "  ${0##*/} major           # Upgrade major versions only"
    echo "  ${0##*/} all             # Upgrade all packages"
}

function selective_brew_upgrade() {
    local upgrade_type="$1"
    
    log_info "Running selective upgrade: $upgrade_type"
    
    # Check if Homebrew is installed
    if ! command -v brew &>/dev/null; then
        log_error "Homebrew not found. Please install Homebrew first."
        exit 1
    fi
    
    # Update Homebrew first
    log_info "Updating Homebrew package lists..."
    brew update
    
    # Get list of outdated packages with version info
    local outdated_packages
    outdated_packages=$(brew outdated --verbose 2>/dev/null)
    
    if [[ -z "$outdated_packages" ]]; then
        log_success "All packages are up to date"
        return 0
    fi
    
    local upgraded_count=0
    local skipped_count=0
    local packages_to_upgrade=()
    
    echo ""
    log_info "Analyzing packages for $upgrade_type upgrades..."
    echo ""
    
    # Parse each outdated package and check version difference
    while IFS= read -r line; do
        # Skip header lines
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^"Name" ]] && continue
        
        # Extract package name and versions
        local package_name current_version latest_version
        package_name=$(echo "$line" | awk '{print $1}')
        current_version=$(echo "$line" | awk '{print $2}')
        latest_version=$(echo "$line" | awk '{print $4}')
        
        # Skip if we can't parse versions
        [[ -z "$package_name" || -z "$current_version" || -z "$latest_version" ]] && continue
        
        local should_upgrade
        should_upgrade=$(should_upgrade_package "$current_version" "$latest_version" "$upgrade_type")
        
        if [[ "$should_upgrade" == "true" ]]; then
            packages_to_upgrade+=("$package_name")
            printf "   ${GREEN}✓${NC} %-25s %s → %s\n" "$package_name" "$current_version" "$latest_version"
            upgraded_count=$((upgraded_count + 1))
        else
            local skip_reason
            case "$upgrade_type" in
                "major-only") skip_reason="minor/patch update" ;;
                "major-minor") skip_reason="patch-only update" ;;
                *) skip_reason="filtered" ;;
            esac
            printf "   ${YELLOW}⏭${NC} %-25s %s → %s (skipped: %s)\n" "$package_name" "$current_version" "$latest_version" "$skip_reason"
            skipped_count=$((skipped_count + 1))
        fi
    done <<< "$outdated_packages"
    
    echo ""
    
    # Perform the upgrades
    if [[ ${#packages_to_upgrade[@]} -gt 0 ]]; then
        log_info "Upgrading ${#packages_to_upgrade[@]} packages..."
        echo ""
        
        for package in "${packages_to_upgrade[@]}"; do
            printf "   ${CYAN}↗${NC} Upgrading $package...\n"
            if brew upgrade "$package" >/dev/null 2>&1; then
                printf "   ${GREEN}✓${NC} $package upgraded successfully\n"
            else
                printf "   ${RED}✗${NC} Failed to upgrade $package\n"
            fi
        done
        
        echo ""
        log_success "Selective upgrade completed: $upgraded_count upgraded, $skipped_count skipped"
    else
        log_info "No packages meet the upgrade criteria ($upgrade_type)"
        log_info "All available updates are $([[ "$upgrade_type" == "major-only" ]] && echo "minor/patch" || echo "patch-only") versions"
    fi
}

function should_upgrade_package() {
    local current_version="$1"
    local latest_version="$2"
    local upgrade_type="$3"
    
    # Extract semantic version components (handle various version formats)
    local current_major current_minor current_patch
    local latest_major latest_minor latest_patch
    
    # Remove common prefixes and suffixes, extract x.y.z pattern
    current_version=$(echo "$current_version" | sed -E 's/^[vV]?([0-9]+\.[0-9]+(\.[0-9]+)?).*/\1/')
    latest_version=$(echo "$latest_version" | sed -E 's/^[vV]?([0-9]+\.[0-9]+(\.[0-9]+)?).*/\1/')
    
    # Parse current version
    IFS='.' read -r current_major current_minor current_patch <<< "$current_version"
    current_major=${current_major:-0}
    current_minor=${current_minor:-0}
    current_patch=${current_patch:-0}
    
    # Parse latest version
    IFS='.' read -r latest_major latest_minor latest_patch <<< "$latest_version"
    latest_major=${latest_major:-0}
    latest_minor=${latest_minor:-0}
    latest_patch=${latest_patch:-0}
    
    # Compare based on upgrade type
    case "$upgrade_type" in
        "major-only")
            # Only upgrade if major version is different
            if [[ $latest_major -gt $current_major ]]; then
                echo "true"
            else
                echo "false"
            fi
            ;;
        "major-minor")
            # Upgrade if major or minor version is different
            if [[ $latest_major -gt $current_major ]] || 
               [[ $latest_major -eq $current_major && $latest_minor -gt $current_minor ]]; then
                echo "true"
            else
                echo "false"
            fi
            ;;
        *)
            # Default: upgrade everything
            echo "true"
            ;;
    esac
}

function interactive_mode() {
    echo "Homebrew Selective Upgrade Tool"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Choose upgrade strategy:"
    echo "  1. All updates (equivalent to 'brew upgrade')"
    echo "  2. Major/Minor only (skip patch updates) [recommended]"
    echo "  3. Major only (skip minor and patch updates)"
    echo "  4. Show outdated packages and exit"
    echo "  5. Exit"
    echo ""
    echo "Enter choice [1-5]: "
    read -r CHOICE
    
    case "$CHOICE" in
        1)
            log_info "Running 'brew upgrade' for all packages..."
            brew update && brew upgrade
            ;;
        2)
            selective_brew_upgrade "major-minor"
            ;;
        3)
            selective_brew_upgrade "major-only"
            ;;
        4)
            log_info "Showing outdated packages..."
            brew outdated --verbose
            ;;
        5|*)
            log_info "Exiting without changes"
            exit 0
            ;;
    esac
}

# Main execution
case "${1:-}" in
    "major")
        selective_brew_upgrade "major-only"
        ;;
    "major-minor")
        selective_brew_upgrade "major-minor"
        ;;
    "all")
        log_info "Running 'brew upgrade' for all packages..."
        brew update && brew upgrade
        ;;
    "--help"|"-h")
        show_usage
        exit 0
        ;;
    "")
        interactive_mode
        ;;
    *)
        log_error "Unknown option: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac