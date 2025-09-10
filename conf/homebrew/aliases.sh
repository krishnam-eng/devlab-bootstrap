#!/bin/zsh

################################################################################
# Homebrew Configuration and Aliases
# 
# This file provides convenient aliases and functions for Homebrew package
# management with semantic version filtering capabilities.
#
# Usage: Source this file in your .zshrc or .bashrc
#   source $SBRN_HOME/sys/hrt/conf/homebrew/aliases.sh
################################################################################

# Make brew-selective-upgrade script executable
chmod +x "$SBRN_HOME/sys/hrt/scripts/brew-selective-upgrade.sh"

# Aliases for selective Homebrew upgrades
alias brew-upgrade-major='$SBRN_HOME/sys/hrt/scripts/brew-selective-upgrade.sh major'
alias brew-upgrade-minor='$SBRN_HOME/sys/hrt/scripts/brew-selective-upgrade.sh major-minor'
alias brew-upgrade-selective='$SBRN_HOME/sys/hrt/scripts/brew-selective-upgrade.sh'
alias brew-upgrade-all='brew update && brew upgrade'

# Enhanced brew outdated with better formatting
alias brew-outdated='brew outdated --verbose'

# Homebrew maintenance aliases
alias brew-cleanup='brew cleanup && brew autoremove'
alias brew-doctor='brew doctor'
alias brew-update='brew update'

# Function to show brew upgrade options
function brew-help-upgrade() {
    echo "Homebrew Upgrade Options:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Standard Commands:"
    echo "  brew-update              Update package lists"
    echo "  brew-outdated            Show outdated packages with versions"
    echo "  brew-upgrade-all         Upgrade all packages (standard 'brew upgrade')"
    echo ""
    echo "Selective Upgrade Commands:"
    echo "  brew-upgrade-selective   Interactive mode - choose upgrade strategy"
    echo "  brew-upgrade-minor       Upgrade major and minor versions only (skip patches)"
    echo "  brew-upgrade-major       Upgrade major versions only (skip minor/patch)"
    echo ""
    echo "Maintenance Commands:"
    echo "  brew-cleanup             Remove old versions and unused dependencies"
    echo "  brew-doctor              Check for common issues"
    echo ""
    echo "Examples:"
    echo "  brew-upgrade-minor       # 1.2.3 → 1.3.0 ✓, 1.2.3 → 1.2.4 ✗"
    echo "  brew-upgrade-major       # 1.x.x → 2.0.0 ✓, 1.2.x → 1.3.x ✗"
}

# Function to create a brew upgrade profile
function brew-create-upgrade-profile() {
    local profile_name="$1"
    local upgrade_type="$2"
    
    if [[ -z "$profile_name" || -z "$upgrade_type" ]]; then
        echo "Usage: brew-create-upgrade-profile <profile_name> <upgrade_type>"
        echo "  upgrade_type: major, major-minor, or all"
        return 1
    fi
    
    local profile_dir="$SBRN_HOME/sys/config/homebrew/profiles"
    mkdir -p "$profile_dir"
    
    cat > "$profile_dir/$profile_name.conf" << EOF
# Homebrew Upgrade Profile: $profile_name
# Created: $(date)
UPGRADE_TYPE="$upgrade_type"
AUTO_UPDATE=true
AUTO_CLEANUP=false

# Package exclusions (space-separated list)
EXCLUDE_PACKAGES=""

# Include only these packages (empty = all packages)
INCLUDE_ONLY=""
EOF
    
    echo "Created upgrade profile: $profile_dir/$profile_name.conf"
    echo "Edit the file to customize package inclusions/exclusions"
}

# Function to run upgrade with a profile
function brew-upgrade-with-profile() {
    local profile_name="$1"
    local profile_file="$SBRN_HOME/sys/config/homebrew/profiles/$profile_name.conf"
    
    if [[ ! -f "$profile_file" ]]; then
        echo "Profile not found: $profile_file"
        echo "Create it with: brew-create-upgrade-profile $profile_name <upgrade_type>"
        return 1
    fi
    
    source "$profile_file"
    echo "Running upgrade with profile: $profile_name (type: $UPGRADE_TYPE)"
    
    # Run the upgrade with the specified type
    "$SBRN_HOME/sys/hrt/scripts/brew-selective-upgrade.sh" "$UPGRADE_TYPE"
    
    # Cleanup if configured
    if [[ "$AUTO_CLEANUP" == "true" ]]; then
        echo "Running cleanup as configured in profile..."
        brew cleanup
    fi
}

# Export functions so they're available in subshells
export -f brew-help-upgrade
export -f brew-create-upgrade-profile  
export -f brew-upgrade-with-profile

echo "Homebrew selective upgrade aliases loaded:"
echo "  • brew-upgrade-selective (interactive)"
echo "  • brew-upgrade-minor (major/minor only)"  
echo "  • brew-upgrade-major (major only)"
echo "  • brew-help-upgrade (show all options)"