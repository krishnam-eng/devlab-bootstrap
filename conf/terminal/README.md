# iTerm2 Profiles Management

This directory contains iTerm2 configuration files and management scripts for systematic backup and restoration of your terminal environment.

## Directory Structure

```
conf/terminal/
├── manage-iterm-profiles.sh    # Profile management script
├── README.md                   # This file
├── profiles/                   # Profile configurations
│   ├── profiles.iterm2.json    # Main profiles export
│   ├── *.json                  # Individual profile files
│   └── profiles-backup-*.json  # Timestamped backups
└── colors/                     # Color schemes
    └── *.itermcolors           # Color scheme files
```

## Quick Start

```bash
# Navigate to the terminal config directory
cd conf/terminal

# Make the script executable (if not already done)
chmod +x manage-iterm-profiles.sh

# Show help
./manage-iterm-profiles.sh help
```

## Available Commands

### Export Current Profiles
```bash
./manage-iterm-profiles.sh export
```
Exports all current iTerm2 profiles to `profiles/profiles.iterm2.json`.

### Import Profiles
```bash
./manage-iterm-profiles.sh import
```
Provides instructions for importing profiles back into iTerm2.

### Create Backup
```bash
./manage-iterm-profiles.sh backup
```
Creates a timestamped backup of current profiles.

### List Configurations
```bash
./manage-iterm-profiles.sh list
```
Shows all available profiles, color schemes, and backup files.

### Sync Profiles
```bash
./manage-iterm-profiles.sh sync
```
Creates backup and exports current profiles (combination of backup + export).

### Install Color Schemes
```bash
./manage-iterm-profiles.sh install
```
Installs all color schemes from the `colors/` directory to iTerm2.

## Systematic Setup Workflow

### 1. Initial Setup (New Machine)
```bash
# Install color schemes first
./manage-iterm-profiles.sh install

# Import your saved profiles
./manage-iterm-profiles.sh import
```

### 2. Regular Maintenance
```bash
# Check current configuration
./manage-iterm-profiles.sh list

# Create backup before making changes
./manage-iterm-profiles.sh backup

# After customizing profiles, export them
./manage-iterm-profiles.sh export
```

### 3. Before System Migration
```bash
# Create final backup and export
./manage-iterm-profiles.sh sync
```

## Manual iTerm2 Profile Management

### Exporting Profiles Manually
1. Open iTerm2 → Preferences → Profiles
2. Select profile(s) to export
3. Click "Other Actions..." → "Copy Profile as JSON"
4. Save to `profiles/` directory

### Importing Profiles Manually
1. Open iTerm2 → Preferences → Profiles
2. Click "Other Actions..." → "Import JSON Profiles"
3. Select your `profiles.iterm2.json` file

### Installing Color Schemes Manually
1. Double-click any `.itermcolors` file
2. iTerm2 will automatically import it
3. Access via Preferences → Profiles → Colors → Color Presets

## Profile Organization Best Practices

### 1. Naming Convention
- Use descriptive names: `GitHub Dark`, `Solarized Light`, `Focus Work`
- Include theme indicator: `Catppuccin Mocha`, `Nord Dark`
- Add purpose: `Development`, `SSH Production`, `Local Testing`

### 2. Color Scheme Management
- Keep color schemes separate from profiles
- Use consistent naming between `.itermcolors` and profile names
- Test color schemes in different lighting conditions

### 3. Profile Settings to Standardize
- **Font**: Use consistent fonts across profiles (e.g., `FiraCode Nerd Font`)
- **Window**: Set consistent window sizes and transparency
- **Terminal**: Configure scrollback, session logging
- **Keys**: Standardize key mappings across profiles
- **Advanced**: Set consistent tmux integration settings

## Integration with Your Development Environment

### Add to Shell Profile
Add an alias to your `.zshrc`:
```bash
alias iterm-profiles='~/sbrn/sys/hrt/conf/terminal/manage-iterm-profiles.sh'
```

Then use:
```bash
iterm-profiles sync
iterm-profiles list
iterm-profiles backup
```

### Automation in Provision Script
Add to your main provision script:
```bash
# Setup iTerm2 profiles and color schemes
if [[ -d "$SBRN_HOME/sys/hrt/conf/terminal" ]]; then
    echo "Setting up iTerm2 profiles..."
    "$SBRN_HOME/sys/hrt/conf/terminal/manage-iterm-profiles.sh" install
    "$SBRN_HOME/sys/hrt/conf/terminal/manage-iterm-profiles.sh" import
fi
```

## Advanced Configuration

### Creating Theme-Based Profiles
1. **Development Profile**
   - Dark theme for extended coding sessions
   - Larger font size for readability
   - Tmux integration enabled

2. **SSH/Production Profile**
   - Distinct colors (red accents for production warning)
   - Different background to avoid confusion
   - Session logging enabled

3. **Presentation Profile**
   - High contrast colors
   - Large fonts for screen sharing
   - Minimal distractions

### Profile Templates
Create base profiles for different scenarios:
- `base-development.json` - Standard development settings
- `base-ssh.json` - Remote connection settings
- `base-presentation.json` - Presentation/demo settings

### Hotkey Configuration
Set up profile-specific hotkeys:
- `⌘+1` - Default development profile
- `⌘+2` - SSH/production profile  
- `⌘+3` - Light theme for bright environments

## Troubleshooting

### Common Issues

**Profiles not importing**
- Ensure iTerm2 is running
- Check JSON file format validity
- Try importing individual profiles

**Color schemes not applying**
- Verify `.itermcolors` file format
- Double-click to install manually
- Check file permissions

**Script permission denied**
```bash
chmod +x manage-iterm-profiles.sh
```

**Cannot export profiles**
- Check iTerm2 preferences file permissions
- Ensure iTerm2 has disk access in System Preferences

## Integration with Version Control

### What to Commit
- ✅ `profiles.iterm2.json` (main configuration)
- ✅ `*.itermcolors` (color schemes)
- ✅ Individual profile `.json` files
- ✅ `manage-iterm-profiles.sh` (management script)

### What to Ignore
- ❌ `profiles-backup-*.json` (timestamped backups)
- ❌ Temporary files
- ❌ User-specific customizations

## Related Tools

### Complementary Terminal Tools
- **tmux**: Session management and multiplexing
- **oh-my-zsh**: Shell enhancement framework
- **powerlevel10k**: Advanced prompt theming
- **fzf**: Fuzzy finder integration

### Color Scheme Resources
- [iTerm2 Color Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)
- [Catppuccin for iTerm2](https://github.com/catppuccin/iterm2)
- [Dracula Theme](https://draculatheme.com/iterm)

This systematic approach ensures your iTerm2 environment is:
- **Reproducible**: Easy to set up on new machines
- **Maintainable**: Clear backup and sync processes
- **Organized**: Consistent structure and naming
- **Automated**: Minimal manual intervention required
