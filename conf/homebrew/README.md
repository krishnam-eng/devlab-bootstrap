# Homebrew Selective Upgrade

This directory contains tools for selective Homebrew package upgrades based on semantic versioning.

## Problem Solved

By default, `brew upgrade` updates all packages to their latest versions, including patch releases (e.g., 1.2.3 → 1.2.4). For development environments, you might want to:

- **Skip patch updates** to avoid frequent minor changes that might introduce instability
- **Only accept major updates** for critical dependencies to maintain compatibility
- **Control upgrade frequency** based on the significance of version changes

## Features

### 1. Selective Upgrade Script (`scripts/brew-selective-upgrade.sh`)

A standalone script that provides three upgrade strategies:

- **`major-only`**: Only upgrade packages with major version changes (1.x.x → 2.x.x)
- **`major-minor`**: Upgrade packages with major or minor changes (1.2.x → 1.3.x or 2.x.x)
- **`all`**: Upgrade all packages (equivalent to standard `brew upgrade`)

### 2. Convenient Aliases (`conf/homebrew/aliases.sh`)

Pre-configured aliases for common upgrade patterns:

```bash
# Interactive mode - choose upgrade strategy
brew-upgrade-selective

# Upgrade major and minor versions only (skip patches)  
brew-upgrade-minor

# Upgrade major versions only (skip minor/patch)
brew-upgrade-major

# Standard upgrade (all packages)
brew-upgrade-all

# Show all available options
brew-help-upgrade
```

### 3. Upgrade Profiles

Create reusable upgrade configurations:

```bash
# Create a profile for conservative upgrades
brew-create-upgrade-profile conservative major-minor

# Run upgrade with a specific profile
brew-upgrade-with-profile conservative
```

## Usage Examples

### Interactive Mode
```bash
./scripts/brew-selective-upgrade.sh
# Shows menu to choose upgrade strategy
```

### Direct Commands
```bash
# Only upgrade major versions (1.x → 2.x)
./scripts/brew-selective-upgrade.sh major

# Upgrade major and minor versions (1.2.x → 1.3.x or 2.x.x)
./scripts/brew-selective-upgrade.sh major-minor

# Upgrade everything (same as 'brew upgrade')
./scripts/brew-selective-upgrade.sh all
```

### Using Aliases (after sourcing conf/homebrew/aliases.sh)
```bash
# Most common: skip patch-only updates
brew-upgrade-minor

# Conservative: only major version updates
brew-upgrade-major

# See what would be upgraded
brew-outdated
```

## Sample Output

```
Running selective upgrade: major-minor

Analyzing packages for major-minor upgrades...

   ✓ node                     18.17.0 → 20.5.0
   ✓ python@3.11              3.11.4 → 3.11.5
   ⏭ git                      2.41.0 → 2.41.1 (skipped: patch-only update)
   ⏭ curl                     8.1.2 → 8.1.3 (skipped: patch-only update)

Upgrading 2 packages...
   ↗ Upgrading node...
   ✓ node upgraded successfully
   ↗ Upgrading python@3.11...
   ✓ python@3.11 upgraded successfully

Selective upgrade completed: 2 upgraded, 2 skipped
```

## Integration with Provision Script

The main provision script (`provision-devlab.sh`) now includes these selective upgrade options during the Homebrew installation step:

1. **All updates** (default brew upgrade)
2. **Major/Minor only** (skip patch updates) 
3. **Major only** (skip minor and patch)
4. **Skip upgrade**

## Configuration

### Loading Aliases

Add to your `.zshrc` or shell configuration:

```bash
# Load Homebrew selective upgrade aliases
if [[ -f "$SBRN_HOME/sys/hrt/conf/homebrew/aliases.sh" ]]; then
    source "$SBRN_HOME/sys/hrt/conf/homebrew/aliases.sh"
fi
```

### Creating Custom Profiles

Profiles are stored in `$SBRN_HOME/sys/config/homebrew/profiles/` and allow you to:

- Set default upgrade strategy
- Exclude specific packages
- Include only specific packages  
- Configure automatic cleanup

Example profile:
```bash
# Conservative upgrade profile
UPGRADE_TYPE="major-only"
AUTO_CLEANUP=true
EXCLUDE_PACKAGES="node python"  # Keep these at current versions
```

## Version Parsing

The script handles various version formats commonly used in Homebrew:

- Standard semantic versions: `1.2.3`
- Versions with prefixes: `v1.2.3`
- Two-part versions: `1.2` (treated as `1.2.0`)
- Complex versions: `1.2.3-beta.4` (extracts `1.2.3`)

## Benefits

1. **Stability**: Avoid unnecessary patch updates that might introduce bugs
2. **Control**: Choose when to accept breaking changes (major versions)
3. **Efficiency**: Reduce upgrade frequency while staying reasonably current
4. **Visibility**: See exactly what versions are being upgraded and why
5. **Flexibility**: Use interactively or integrate into automation scripts

## Files

```
homebrew/
├── README.md                    # This documentation
├── aliases.sh                   # Shell aliases and functions
└── ../scripts/
    └── brew-selective-upgrade.sh # Main selective upgrade script
```