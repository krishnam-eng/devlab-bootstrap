#!/usr/bin/env zsh
# Homebrew selective upgrade functions
# ==========================================================================
# DEBUG MODE CONTROL
# ==========================================================================
# Set BREW_UPGRADE_DEBUG=1 to enable debug output showing variable assignments
# Example: BREW_UPGRADE_DEBUG=1 brew-upgrade-minor-only
# ==========================================================================

# Toggle function for brew debug output
brew-debug-toggle() {
    if [[ -n "$BREW_UPGRADE_DEBUG" ]]; then
        unset BREW_UPGRADE_DEBUG
        echo "🔇 Brew debug output disabled"
    else
        export BREW_UPGRADE_DEBUG=1
        echo "🔊 Brew debug output enabled"
    fi
}

# Quick fix for shell tracing that causes redundant variable output
brew-quiet-mode() {
    if [[ $- =~ x ]]; then
        set +x
        echo "🔇 Shell tracing disabled (was causing redundant variable output)"
    else
        echo "ℹ️  Shell tracing is already disabled"
    fi
}

# ==========================================================================
# USAGE GUIDE
# ==========================================================================
#
# Available Functions:
#
# 1. brew-upgrade-minor-only (alias: bumin)
#    Usage: brew-upgrade-minor-only
#    Purpose: Upgrades only packages with minor version changes (e.g., 1.2.x → 1.3.x)
#    Example: brew-upgrade-minor-only
#    Alias: bumin
#
# 2. brew-upgrade-major-only (alias: bumaj, bupM)
#    Usage: brew-upgrade-major-only
#    Purpose: Upgrades only packages with major version changes (e.g., 1.x.x → 2.x.x)
#    Example: brew-upgrade-major-only
#    Aliases: bumaj, bupM
#
# 3. brew-upgrade-minor-major (alias: bupm)
#    Usage: brew-upgrade-minor-major
#    Purpose: Upgrades packages with minor or major version changes (skips patch-only)
#    Example: brew-upgrade-minor-major
#    Alias: bupm
#
# 4. brew-show-outdated-analysis (alias: bshow)
#    Usage: brew-show-outdated-analysis
#    Purpose: Shows detailed analysis of outdated packages with version change types
#    Example: brew-show-outdated-analysis
#    Alias: bshow
#
# ==========================================================================

# Debug helper function
_brew_debug() {
    [[ -n "$BREW_UPGRADE_DEBUG" ]] && echo "🐛 DEBUG: $*" >&2
}

# Helper function to run commands without shell tracing
_brew_quiet_exec() {
    local xtrace_was_set=""
    [[ $- =~ x ]] && xtrace_was_set="true"
    set +x
    "$@"
    local result=$?
    [[ -n "$xtrace_was_set" ]] && set -x
    return $result
}

# brew-upgrade-minor-only - Upgrade packages with minor version changes only
# Upgrades only packages where minor version has changed (skips patch and major changes)
# Usage: brew-upgrade-minor-only
# Example: brew-upgrade-minor-only (upgrades 1.2.x → 1.3.x but not 1.2.1 → 1.2.2 or 1.x.x → 2.x.x)
# Alias: bumin
brew-upgrade-minor-only() {
    # Temporarily disable shell tracing to avoid redundant debug output
    local xtrace_was_set=""
    [[ $- =~ x ]] && xtrace_was_set="true" && set +x
    
    _brew_upgrade_minor_only_impl "$@"
    local result=$?
    
    # Restore shell tracing if it was originally set
    [[ -n "$xtrace_was_set" ]] && set -x
    return $result
}

_brew_upgrade_minor_only_impl() {
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Error: Homebrew is not installed"
        echo "   Install with: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    echo "🍺 Starting minor version upgrade process..."
    echo "   Strategy: Only upgrade packages with minor version changes"
    echo "   Skips: patch updates (1.2.1 → 1.2.2) and major updates (1.x.x → 2.x.x)"
    echo
    
    # Update Homebrew first
    echo "🔄 Updating Homebrew package lists..."
    if ! brew update >/dev/null 2>&1; then
        echo "❌ Error: Failed to update Homebrew"
        return 1
    fi
    
    # Get list of outdated packages
    local outdated_packages
    outdated_packages=$(brew outdated --verbose 2>/dev/null)
    
    if [[ -z "$outdated_packages" ]]; then
        echo "✅ All packages are up to date"
        return 0
    fi
    
    local packages_to_upgrade=()
    local skipped_packages=()
    
    echo "🔍 Analyzing packages for minor version upgrades..."
    echo
    
    # Parse each outdated package
    while IFS= read -r line; do
        # Skip header lines and empty lines
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^"Name" ]] && continue
        
        # Extract package name and versions (suppress shell tracing for cleaner output)
        {
            local package_name current_version latest_version
            package_name=$(echo "$line" | awk '{print $1}')
            current_version=$(echo "$line" | awk '{print $2}' | sed 's/[()]//g')
            latest_version=$(echo "$line" | awk '{print $4}')
        } 2>/dev/null
        
        # Skip if we can't parse versions
        [[ -z "$package_name" || -z "$current_version" || -z "$latest_version" ]] && continue
        
        local should_upgrade
        should_upgrade=$(_brew_should_upgrade_minor_only "$current_version" "$latest_version")
        
        if [[ "$should_upgrade" == "true" ]]; then
            packages_to_upgrade+=("$package_name")
            printf "   ✅ %-25s %s → %s (minor upgrade)\n" "$package_name" "$current_version" "$latest_version"
        else
            skipped_packages+=("$package_name:$current_version:$latest_version")
            local change_type
            change_type=$(_brew_get_change_type "$current_version" "$latest_version")
            printf "   ⏭️  %-25s %s → %s (skipped: %s)\n" "$package_name" "$current_version" "$latest_version" "$change_type"
        fi
    done <<< "$outdated_packages"
    
    echo
    
    # Perform the upgrades
    if [[ ${#packages_to_upgrade[@]} -gt 0 ]]; then
        echo "🚀 Upgrading ${#packages_to_upgrade[@]} packages with minor version changes..."
        echo
        
        for package in "${packages_to_upgrade[@]}"; do
            echo "   📦 Upgrading $package..."
            if brew upgrade "$package" >/dev/null 2>&1; then
                echo "   ✅ $package upgraded successfully"
            else
                echo "   ❌ Failed to upgrade $package"
            fi
        done
        
        echo
        echo "📊 Summary:"
        echo "   Upgraded: ${#packages_to_upgrade[@]} packages"
        echo "   Skipped: ${#skipped_packages[@]} packages"
        echo "✅ Minor version upgrade completed"
    else
        echo "ℹ️  No packages found with minor version changes"
        echo "   All available updates are either patch-only or major version changes"
    fi
}

# brew-upgrade-major-only - Upgrade packages with major version changes only
# Upgrades only packages where major version has changed (skips patch and minor changes)
# Usage: brew-upgrade-major-only
# Example: brew-upgrade-major-only (upgrades 1.x.x → 2.x.x but not 1.2.x → 1.3.x or 1.2.1 → 1.2.2)
# Alias: bumaj
brew-upgrade-major-only() {
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Error: Homebrew is not installed"
        echo "   Install with: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    echo "🍺 Starting major version upgrade process..."
    echo "   Strategy: Only upgrade packages with major version changes"
    echo "   Skips: patch updates (1.2.1 → 1.2.2) and minor updates (1.2.x → 1.3.x)"
    echo
    
    # Update Homebrew first
    echo "🔄 Updating Homebrew package lists..."
    if ! brew update >/dev/null 2>&1; then
        echo "❌ Error: Failed to update Homebrew"
        return 1
    fi
    
    # Get list of outdated packages
    local outdated_packages
    outdated_packages=$(brew outdated --verbose 2>/dev/null)
    
    if [[ -z "$outdated_packages" ]]; then
        echo "✅ All packages are up to date"
        return 0
    fi
    
    local packages_to_upgrade=()
    local skipped_packages=()
    
    echo "🔍 Analyzing packages for major version upgrades..."
    echo
    
    # Parse each outdated package
    while IFS= read -r line; do
        # Skip header lines and empty lines
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^"Name" ]] && continue
        
        # Extract package name and versions
        local package_name current_version latest_version
        package_name=$(echo "$line" | awk '{print $1}')
        current_version=$(echo "$line" | awk '{print $2}' | sed 's/[()]//g')
        latest_version=$(echo "$line" | awk '{print $4}')
        
        # Skip if we can't parse versions
        [[ -z "$package_name" || -z "$current_version" || -z "$latest_version" ]] && continue
        
        local should_upgrade
        should_upgrade=$(_brew_should_upgrade_major_only "$current_version" "$latest_version")
        
        if [[ "$should_upgrade" == "true" ]]; then
            packages_to_upgrade+=("$package_name")
            printf "   ✅ %-25s %s → %s (major upgrade)\n" "$package_name" "$current_version" "$latest_version"
        else
            skipped_packages+=("$package_name:$current_version:$latest_version")
            local change_type
            change_type=$(_brew_get_change_type "$current_version" "$latest_version")
            printf "   ⏭️  %-25s %s → %s (skipped: %s)\n" "$package_name" "$current_version" "$latest_version" "$change_type"
        fi
    done <<< "$outdated_packages"
    
    echo
    
    # Perform the upgrades
    if [[ ${#packages_to_upgrade[@]} -gt 0 ]]; then
        echo "🚀 Upgrading ${#packages_to_upgrade[@]} packages with major version changes..."
        echo
        
        for package in "${packages_to_upgrade[@]}"; do
            echo "   📦 Upgrading $package..."
            if brew upgrade "$package" >/dev/null 2>&1; then
                echo "   ✅ $package upgraded successfully"
            else
                echo "   ❌ Failed to upgrade $package"
            fi
        done
        
        echo
        echo "📊 Summary:"
        echo "   Upgraded: ${#packages_to_upgrade[@]} packages"
        echo "   Skipped: ${#skipped_packages[@]} packages"
        echo "✅ Major version upgrade completed"
    else
        echo "ℹ️  No packages found with major version changes"
        echo "   All available updates are either patch-only or minor version changes"
    fi
}

# brew-show-outdated-analysis - Show detailed analysis of outdated packages
# Shows all outdated packages with categorization of version change types
# Usage: brew-show-outdated-analysis
# Example: brew-show-outdated-analysis
# Alias: bshow
brew-show-outdated-analysis() {
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Error: Homebrew is not installed"
        echo "   Install with: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    echo "🍺 Analyzing outdated Homebrew packages..."
    echo
    
    # Update Homebrew first
    echo "🔄 Updating Homebrew package lists..."
    if ! brew update >/dev/null 2>&1; then
        echo "❌ Error: Failed to update Homebrew"
        return 1
    fi
    
    # Get list of outdated packages
    local outdated_packages
    outdated_packages=$(brew outdated --verbose 2>/dev/null)
    
    if [[ -z "$outdated_packages" ]]; then
        echo "✅ All packages are up to date"
        return 0
    fi
    
    local major_upgrades=()
    local minor_upgrades=()
    local patch_upgrades=()
    local unknown_upgrades=()
    
    echo "📊 Package Analysis:"
    echo
    
    # Parse each outdated package
    while IFS= read -r line; do
        # Skip header lines and empty lines
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^"Name" ]] && continue
        
        # Extract package name and versions
        local package_name current_version latest_version
        package_name=$(echo "$line" | awk '{print $1}')
        current_version=$(echo "$line" | awk '{print $2}' | sed 's/[()]//g')
        latest_version=$(echo "$line" | awk '{print $4}')
        
        # Skip if we can't parse versions
        [[ -z "$package_name" || -z "$current_version" || -z "$latest_version" ]] && continue
        
        local change_type
        change_type=$(_brew_get_change_type "$current_version" "$latest_version")
        
        case "$change_type" in
            "major update")
                major_upgrades+=("$package_name:$current_version:$latest_version")
                printf "   🔴 %-25s %s → %s (MAJOR)\n" "$package_name" "$current_version" "$latest_version"
                ;;
            "minor update")
                minor_upgrades+=("$package_name:$current_version:$latest_version")
                printf "   🟡 %-25s %s → %s (MINOR)\n" "$package_name" "$current_version" "$latest_version"
                ;;
            "patch update")
                patch_upgrades+=("$package_name:$current_version:$latest_version")
                printf "   🟢 %-25s %s → %s (PATCH)\n" "$package_name" "$current_version" "$latest_version"
                ;;
            *)
                unknown_upgrades+=("$package_name:$current_version:$latest_version")
                printf "   ⚪ %-25s %s → %s (UNKNOWN)\n" "$package_name" "$current_version" "$latest_version"
                ;;
        esac
    done <<< "$outdated_packages"
    
    echo
    echo "📈 Summary by Version Change Type:"
    echo "   🔴 Major updates: ${#major_upgrades[@]} packages (breaking changes possible)"
    echo "   🟡 Minor updates: ${#minor_upgrades[@]} packages (new features)"
    echo "   🟢 Patch updates: ${#patch_upgrades[@]} packages (bug fixes)"
    if [[ ${#unknown_upgrades[@]} -gt 0 ]]; then
        echo "   ⚪ Unknown: ${#unknown_upgrades[@]} packages (non-standard versioning)"
    fi
    echo
    echo "💡 Upgrade Commands:"
    echo "   bumin  - Upgrade minor versions only"
    echo "   bumaj  - Upgrade major versions only"
    echo "   bupm   - Upgrade minor and major versions (skip patches)"
    echo "   brew upgrade - Upgrade all packages"
}

# brew-upgrade-minor-major - Upgrade packages with minor or major version changes
# Upgrades packages where minor or major version has changed (skips patch-only changes)
# Usage: brew-upgrade-minor-major
# Example: brew-upgrade-minor-major (upgrades 1.2.x → 1.3.x and 1.x.x → 2.x.x but not 1.2.1 → 1.2.2)
# Alias: bupm
brew-upgrade-minor-major() {
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Error: Homebrew is not installed"
        echo "   Install with: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        return 1
    fi
    
    echo "🍺 Starting minor/major version upgrade process..."
    echo "   Strategy: Upgrade packages with minor or major version changes"
    echo "   Skips: patch updates only (1.2.1 → 1.2.2)"
    echo
    
    # Update Homebrew first
    echo "🔄 Updating Homebrew package lists..."
    if ! brew update >/dev/null 2>&1; then
        echo "❌ Error: Failed to update Homebrew"
        return 1
    fi
    
    # Get list of outdated packages
    local outdated_packages
    outdated_packages=$(brew outdated --verbose 2>/dev/null)
    
    if [[ -z "$outdated_packages" ]]; then
        echo "✅ All packages are up to date"
        return 0
    fi
    
    local packages_to_upgrade=()
    local skipped_packages=()
    
    echo "🔍 Analyzing packages for minor/major version upgrades..."
    echo
    
    # Parse each outdated package
    while IFS= read -r line; do
        # Skip header lines and empty lines
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue
        [[ "$line" =~ ^"Name" ]] && continue
        
        # Extract package name and versions
        local package_name current_version latest_version
        package_name=$(echo "$line" | awk '{print $1}')
        current_version=$(echo "$line" | awk '{print $2}' | sed 's/[()]//g')
        latest_version=$(echo "$line" | awk '{print $4}')
        
        # Skip if we can't parse versions
        [[ -z "$package_name" || -z "$current_version" || -z "$latest_version" ]] && continue
        
        local should_upgrade
        should_upgrade=$(_brew_should_upgrade_minor_major "$current_version" "$latest_version")
        
        if [[ "$should_upgrade" == "true" ]]; then
            packages_to_upgrade+=("$package_name")
            local change_type
            change_type=$(_brew_get_change_type "$current_version" "$latest_version")
            printf "   ✅ %-25s %s → %s (%s)\n" "$package_name" "$current_version" "$latest_version" "$change_type"
        else
            skipped_packages+=("$package_name:$current_version:$latest_version")
            printf "   ⏭️  %-25s %s → %s (skipped: patch-only)\n" "$package_name" "$current_version" "$latest_version"
        fi
    done <<< "$outdated_packages"
    
    echo
    
    # Perform the upgrades
    if [[ ${#packages_to_upgrade[@]} -gt 0 ]]; then
        echo "🚀 Upgrading ${#packages_to_upgrade[@]} packages with minor/major version changes..."
        echo
        
        for package in "${packages_to_upgrade[@]}"; do
            echo "   📦 Upgrading $package..."
            if brew upgrade "$package" >/dev/null 2>&1; then
                echo "   ✅ $package upgraded successfully"
            else
                echo "   ❌ Failed to upgrade $package"
            fi
        done
        
        echo
        echo "📊 Summary:"
        echo "   Upgraded: ${#packages_to_upgrade[@]} packages"
        echo "   Skipped: ${#skipped_packages[@]} packages"
        echo "✅ Minor/major version upgrade completed"
    else
        echo "ℹ️  No packages found with minor or major version changes"
        echo "   All available updates are patch-only changes"
    fi
}

# Helper function to determine if package should be upgraded for minor-only strategy
_brew_should_upgrade_minor_only() {
    local current_version="$1"
    local latest_version="$2"
    
    local current_major current_minor current_patch
    local latest_major latest_minor latest_patch
    
    # Extract semantic version components
    _brew_parse_version "$current_version" current_major current_minor current_patch
    _brew_parse_version "$latest_version" latest_major latest_minor latest_patch
    
    # Only upgrade if minor version changed but major version is the same
    if [[ $latest_major -eq $current_major && $latest_minor -gt $current_minor ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Helper function to determine if package should be upgraded for major-only strategy
_brew_should_upgrade_major_only() {
    local current_version="$1"
    local latest_version="$2"
    
    local current_major current_minor current_patch
    local latest_major latest_minor latest_patch
    
    # Extract semantic version components
    _brew_parse_version "$current_version" current_major current_minor current_patch
    _brew_parse_version "$latest_version" latest_major latest_minor latest_patch
    
    # Only upgrade if major version changed
    if [[ $latest_major -gt $current_major ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Helper function to determine if package should be upgraded for minor-major strategy
_brew_should_upgrade_minor_major() {
    local current_version="$1"
    local latest_version="$2"
    
    local current_major current_minor current_patch
    local latest_major latest_minor latest_patch
    
    # Extract semantic version components
    _brew_parse_version "$current_version" current_major current_minor current_patch
    _brew_parse_version "$latest_version" latest_major latest_minor latest_patch
    
    # Upgrade if major version changed OR minor version changed (but not patch-only)
    if [[ $latest_major -gt $current_major ]] || 
       [[ $latest_major -eq $current_major && $latest_minor -gt $current_minor ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Helper function to get the type of version change
_brew_get_change_type() {
    local current_version="$1"
    local latest_version="$2"
    
    local current_major current_minor current_patch
    local latest_major latest_minor latest_patch
    
    # Extract semantic version components
    _brew_parse_version "$current_version" current_major current_minor current_patch
    _brew_parse_version "$latest_version" latest_major latest_minor latest_patch
    
    if [[ $latest_major -gt $current_major ]]; then
        echo "major update"
    elif [[ $latest_major -eq $current_major && $latest_minor -gt $current_minor ]]; then
        echo "minor update"
    elif [[ $latest_major -eq $current_major && $latest_minor -eq $current_minor && $latest_patch -gt $current_patch ]]; then
        echo "patch update"
    else
        echo "unknown update"
    fi
}

# Helper function to parse version numbers
_brew_parse_version() {
    local version="$1"
    local major_var="$2"
    local minor_var="$3"
    local patch_var="$4"
    
    # Remove parentheses, prefixes and suffixes, extract x.y.z pattern
    version=$(echo "$version" | sed -E 's/[()]*//g' | sed -E 's/^[vV]?([0-9]+\.[0-9]+(\.[0-9]+)?).*/\1/')
    
    # Parse version components
    local major minor patch
    IFS='.' read -r major minor patch <<< "$version"
    major=${major:-0}
    minor=${minor:-0}
    patch=${patch:-0}
    
    # Set the variables in the calling context using printf to avoid eval issues
    printf -v "$major_var" '%s' "$major"
    printf -v "$minor_var" '%s' "$minor"
    printf -v "$patch_var" '%s' "$patch"
}

# Aliases for brew functions
alias bumin='brew-upgrade-minor-only'
alias bumaj='brew-upgrade-major-only'
alias bupm='brew-upgrade-minor-major'
alias bshow='brew-show-outdated-analysis'

# Future brew functions can be added here following the same pattern
# Example: brew-health-check, brew-cleanup-old-versions, etc.