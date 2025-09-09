# iTerm2 Integration with Provision Script

## Overview

The provision script (`provision-devlab-env.sh`) now automatically handles iTerm2 installation and configuration setup as part of the "Install IDEs and Editors" step.

## What's Integrated

### 1. Automatic iTerm2 Installation
- iTerm2 is now included in the core applications list
- Installs via Homebrew Cask during the IDEs and Editors step
- Added to the impact summary display

### 2. Automated Profile and Color Scheme Setup
A new function `setup_iterm_profiles()` handles:
- **iTerm2 Installation Check**: Installs iTerm2 if not present
- **Color Scheme Installation**: Automatically installs all `.itermcolors` files
- **Profile Import Instructions**: Provides clear steps for importing profiles
- **Script Validation**: Ensures the management script is executable

### 3. Enhanced Impact Display
The `show_ides_impact()` function now shows:
- iTerm2 installation status
- Number of available color schemes
- Number of available profile configurations
- Management script availability and commands

## What Happens During Provision

When you run the provision script and select "Install IDEs and Editors":

1. **iTerm2 Installation**: 
   ```bash
   brew install --cask iterm2
   ```

2. **Color Scheme Installation**:
   ```bash
   # Automatically installs all 9 color schemes:
   # • Catppuccin-Mocha
   # • GitHub-Dark  
   # • Nord-North
   # • Solarized-Dark
   # • Gotham-Night
   # • Cobalt-Atom
   # • Jelly-Beans
   # • Noctis-Night
   # • Purple-Shades
   ```

3. **Profile Import Instructions**:
   ```
   To import profiles:
   1. Open iTerm2 → Preferences → Profiles
   2. Click 'Other Actions...' → 'Import JSON Profiles'
   3. Select: /path/to/profiles.iterm2.json
   4. Or run: ./manage-iterm-profiles.sh import
   ```

## Impact Summary Example

After running the provision script, you'll see:

```
✅ Core IDEs and editors installed:
   • Visual Studio Code (GUI + CLI: code)
   • IntelliJ IDEA CE (GUI + CLI: idea)
   • PyCharm Community Edition
   • Cursor AI Editor (GUI + CLI: cursor)
   • iTerm2 Terminal Emulator
   • CLI editors: vim, neovim, emacs, nano

✅ iTerm2 terminal setup:
   • Color schemes: 9 themes available
   • Profiles: 11 configurations available
   • Management: /path/to/manage-iterm-profiles.sh
   • Commands: install, import, export, backup, sync, list
```

## Manual Control

If you prefer manual control, you can still use the management script directly:

```bash
cd ~/sbrn/sys/hrt/conf/terminal

# Install color schemes only
./manage-iterm-profiles.sh install

# Import profiles
./manage-iterm-profiles.sh import

# Full sync
./manage-iterm-profiles.sh sync
```

## Benefits of Integration

- **Systematic**: Automated as part of environment setup
- **Consistent**: Same process across all machines
- **Reliable**: Validates prerequisites and provides clear feedback
- **Maintainable**: Separates concerns between provision and iTerm management
- **User-Friendly**: Clear instructions and status reporting

This integration ensures your terminal environment is set up systematically alongside your other development tools! 🚀
