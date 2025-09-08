# BIOS for macOS

A comprehensive system initialization and development environment setup script that mimics the traditional BIOS boot sequence, adapted for macOS development workflows.

## 🔍 Overview

This script translates the Linux BIOS boot sequence into macOS equivalents, providing a complete system health check, hardware enumeration, environment configuration, and development tools setup. It's designed to get your macOS development environment fully configured and ready for productive work.

## 🚀 Features

- **🔍 Comprehensive System Diagnostics**: Complete hardware and software health checks
- **🎨 Color-coded Logging**: Easy-to-read output with info, success, warning, and error indicators
- **🔒 Safety First**: Confirmation prompts and idempotent operations (safe to run multiple times)
- **🍎 macOS Optimized**: Platform-specific configurations and optimizations
- **🏗️ PARA Integration**: Seamless integration with your Second Brain (SBRN) directory structure
- **⚡ Performance Tuned**: System optimizations for development workflows

## 📋 Script Stages

### Stage 1: Power-On Self-Test (POST) 🔍
Equivalent to hardware diagnostics in traditional BIOS:

- **System Integrity**: macOS version, uptime, disk usage, system logs
- **CPU & Memory**: Hardware specs, memory pressure, system activity
- **Storage Devices**: Mounted volumes, disk health, available space
- **Peripherals**: USB, audio, camera, Bluetooth device detection
- **Network**: Interface detection, connectivity tests, DNS resolution

**Commands Used**: `sw_vers`, `uptime`, `df`, `sysctl`, `vm_stat`, `top`, `diskutil`, `system_profiler`, `ifconfig`, `netstat`, `ping`

### Stage 2: Device Enumeration 📱
Hardware discovery and inventory:

- **CPU & Memory**: Detailed processor and memory specifications
- **Storage**: Complete storage device enumeration and SMART status
- **Network Devices**: Hardware ports, Wi-Fi, Ethernet configuration
- **Peripherals**: Complete hardware overview and external displays
- **Hostname**: System identification and naming

**Commands Used**: `system_profiler`, `networksetup`, `diskutil`, `hostname`

### Stage 3: System Resource Configuration ⚙️
Environment and system optimization:

- **Environment Setup**: SBRN_HOME, XDG directories, essential paths
- **Security Configuration**: FileVault, Gatekeeper, SIP status checks
- **Performance Optimization**: Energy settings, Spotlight indexing, hibernation
- **Development Settings**: Finder preferences, file extensions, autocorrect disable

**Commands Used**: `pmset`, `fdesetup`, `spctl`, `csrutil`, `defaults`, `mdutil`

### Stage 4: Boot Device Selection (Development Environment) 🛠️
Development environment initialization:

- **Package Managers**: Homebrew installation and configuration
- **Shell Environment**: Zsh setup and configuration linking
- **Git Environment**: Git and GitHub CLI setup with configuration checks
- **PATH Configuration**: Development tools and homebrew paths

**Tools Installed**: Homebrew, GitHub CLI, Git

### Stage 5: Bootloader Core (Essential Tools) 🔧
Development tools and workspace setup:

- **Essential CLI Tools**: 
  - `tree` - Directory visualization
  - `wget`, `curl` - File downloaders
  - `jq` - JSON processor
  - `htop` - System monitor
  - `vim` - Text editor
  - `tmux` - Terminal multiplexer
  - `fzf` - Fuzzy finder
  - `ripgrep` - Fast text search
  - `bat` - Enhanced cat
  - `exa` - Enhanced ls
  - `fd` - Enhanced find
  - `tldr` - Simplified man pages

- **Directory Structure**: PARA methodology directories and development workspace
- **Repository Management**: Essential repository cloning with GitHub integration
- **SSH Configuration**: Key generation, agent setup, and GitHub integration

## 📁 Directory Structure Created

```
$SBRN_HOME/
├── proj/           # Active projects
│   ├── corp/       # Corporate projects
│   ├── oss/        # Open source projects
│   ├── learn/      # Learning projects
│   ├── lab/        # Lab experiments
│   └── exp/        # Experimental projects
├── areas/          # Ongoing responsibilities
│   ├── work/       # Professional areas
│   ├── personal/   # Personal areas
│   ├── community/  # Community involvement
│   └── academic/   # Academic pursuits
├── res/            # Resources
│   ├── notes/      # Note-taking system
│   ├── templates/  # Reusable templates
│   └── refs/       # Reference materials
├── arch/           # Archives
│   ├── proj/       # Archived projects
│   └── area/       # Archived areas
└── sys/            # System configuration
    ├── config/     # XDG config directory
    ├── local/      # Local data and state
    └── cache/      # Cache directory

$HOME/Development/
├── Tools/          # Development tools
├── Libraries/      # Code libraries
└── Workspace/      # Active workspace
```

## 🔧 Usage

### Prerequisites
- macOS (any recent version)
- Terminal access
- Internet connection (for package downloads)

### Basic Usage

```bash
# Make the script executable (if not already)
chmod +x /Users/ariston/sbrn/sys/hrt/boot/bios-for-macos.sh

# Run the script
./bios-for-macos.sh

# Or with full path
/Users/ariston/sbrn/sys/hrt/boot/bios-for-macos.sh
```

### What Happens During Execution

1. **System Summary**: Displays current system information
2. **Confirmation Prompt**: Asks for permission to proceed
3. **Stage Execution**: Runs through all 5 stages with detailed logging
4. **Final Summary**: Shows updated system configuration

### Sample Output

```
[INFO] System Summary:
==================
macOS Version: 14.5
Hardware: MacBookPro18,1
CPU: Apple M1 Pro
Memory: 16 GB
Hostname: macbook-pro.local
Shell: /bin/zsh
Homebrew: Homebrew 4.1.0
Git: git version 2.42.0
SBRN_HOME: /Users/username/sbrn
==================

Proceed with BIOS-equivalent initialization? (y/N): y

[INFO] Starting BIOS-equivalent initialization for macOS...
[INFO] 🔍 Stage 1: Performing Power-On Self-Test (POST) equivalent...
[SUCCESS] POST checks completed successfully
[INFO] 🔍 Stage 2: Enumerating devices and hardware...
[SUCCESS] Device enumeration completed
[INFO] 🔧 Stage 3: Configuring system resources...
[SUCCESS] System resource configuration completed
[INFO] 🚀 Stage 4: Selecting boot environment (Development setup)...
[SUCCESS] Boot environment selection completed
[INFO] 🔧 Stage 5: Loading bootloader core (Essential tools)...
[SUCCESS] Bootloader core loaded successfully
[SUCCESS] BIOS-equivalent initialization completed successfully!
```

## 🛡️ Safety Features

- **Idempotent Operations**: Safe to run multiple times without side effects
- **Confirmation Prompts**: User confirmation before making system changes
- **Error Handling**: Graceful handling of missing tools or failed operations
- **Non-destructive**: Won't overwrite existing configurations without explicit linking
- **Rollback Information**: Clear logging of what changes were made

## 🔧 Customization

### Environment Variables

The script respects and sets up these key environment variables:

- `SBRN_HOME`: Your Second Brain root directory
- `XDG_CONFIG_HOME`: Configuration directory
- `XDG_DATA_HOME`: Data directory  
- `XDG_STATE_HOME`: State directory
- `XDG_CACHE_HOME`: Cache directory

### Modifying Tool Lists

To add or remove tools from the installation list, edit the `essential_tools` array in the `_install_essential_tools()` function:

```bash
local essential_tools=(
    "tree"              # Directory tree visualization
    "your-tool-here"    # Your custom tool
    # Add more tools as needed
)
```

### Custom Directory Structure

Modify the directory creation commands in `_setup_development_directories()` to match your preferred structure.

## 🐛 Troubleshooting

### Common Issues

1. **Homebrew Installation Fails**
   - Check internet connection
   - Ensure Xcode Command Line Tools are installed: `xcode-select --install`

2. **Permission Denied Errors**
   - Ensure script is executable: `chmod +x bios-for-macos.sh`
   - Some operations may require admin privileges

3. **GitHub Authentication Issues**
   - Run `gh auth login` separately if automatic authentication fails
   - Check SSH key configuration

4. **Tool Installation Failures**
   - Update Homebrew: `brew update && brew upgrade`
   - Check available disk space

### Debug Mode

For verbose output, you can modify the script to add debug information:

```bash
# Add at the top of the script
set -x  # Enable debug mode
```

## 🔄 Maintenance

### Regular Updates

Run the script periodically to:
- Update installed tools
- Verify system health
- Maintain environment consistency

### Backup Considerations

The script creates directories and installs tools but doesn't modify critical system files. However, consider backing up:
- SSH keys (`~/.ssh/`)
- Git configuration (`~/.gitconfig`)
- Shell configuration files

## 🤝 Contributing

This script is part of the SBRN (Second Brain) system. To contribute:

1. Test changes on a clean macOS system
2. Ensure idempotent behavior
3. Add appropriate logging
4. Update this documentation

## 📚 Related Documentation

- [Second Brain Setup (A00)](../../../res/notes/learning-journal/eng-lab/procedure/A00_setup-second-brain-dir-structure.md)
- [Shell Configuration](../conf/zsh/)
- [Development Tools Setup](../../../res/notes/learning-journal/eng-lab/procedure/)

## 📋 System Requirements

- **OS**: macOS 10.15+ (Catalina or later)
- **Architecture**: Intel or Apple Silicon
- **Disk Space**: ~2GB for all tools and dependencies
- **Network**: Internet connection for downloads
- **Permissions**: Admin access for some system configurations

---

**Last Updated**: September 6, 2025  
**Version**: 1.0  
**Compatibility**: macOS 10.15+
# Dry-Run Mode Documentation

The `bios-for-macos.sh` script now supports a comprehensive dry-run mode that shows exactly what would be executed without making any changes to your system.

## Usage

```bash
# Show help
./bios-for-macos.sh --help
./bios-for-macos.sh -h

# Run in dry-run mode (preview only)
./bios-for-macos.sh --dry-run
./bios-for-macos.sh -n

# Run normally (make actual changes)
./bios-for-macos.sh
```

## Dry-Run Features

### 🔍 Preview Mode
- Shows what commands would be executed
- Displays what directories would be created
- Lists what packages would be installed
- Shows what system settings would be changed
- **No actual changes are made**

### 🎨 Enhanced Logging
- **[DRY-RUN]** - Purple text showing planned actions
- **[INFO]** - Blue informational messages
- **[SUCCESS]** - Green success indicators
- **[WARNING]** - Yellow warnings
- **[ERROR]** - Red error messages

### 🛡️ Safety Features
- **No confirmation prompt** in dry-run mode (safe to run)
- **Automatic detection** of what would vs. wouldn't be done
- **Clear summary** at the end showing no changes were made

## What Dry-Run Shows

### Stage 1: Power-On Self-Test (POST)
- System integrity checks (actual read-only operations)
- Hardware diagnostics (safe to run)
- Network connectivity tests (read-only)

### Stage 2: Device Enumeration  
- Hardware detection (read-only operations)
- System profiling (safe information gathering)

### Stage 3: System Resource Configuration
```
[DRY-RUN] Would set SBRN_HOME to /Users/username/sbrn
[DRY-RUN] Would create directories: /Users/username/sbrn/{sys,proj,areas,res,arch}
[DRY-RUN] Would run: Disable hibernation
[DRY-RUN] Command: sudo pmset -a hibernatemode 0
[DRY-RUN] Would set defaults: com.apple.finder AppleShowAllFiles -bool true
```

### Stage 4: Boot Environment Setup
```
[DRY-RUN] Would install Homebrew via:
[DRY-RUN] /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
[DRY-RUN] Would add Homebrew to PATH in ~/.zprofile for Apple Silicon
[DRY-RUN] Command: brew update
```

### Stage 5: Essential Tools Installation
```
[DRY-RUN] Would install: tree
[DRY-RUN] Would install: wget
[DRY-RUN] Would install: jq
[DRY-RUN] Would create directories: /Users/username/sbrn/{proj/{corp,oss,learn,lab,exp},...}
[DRY-RUN] Would generate SSH key:
[DRY-RUN] ssh-keygen -t ed25519 -C "username@hostname" -f ~/.ssh/id_ed25519 -N ""
```

## Dry-Run Summary

At the end of execution, you'll see:
```
[INFO] 🔍 DRY-RUN SUMMARY:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[DRY-RUN] No actual changes were made to your system
[DRY-RUN] To execute the real installation, run: bios-for-macos.sh
[DRY-RUN] To see this preview again, run: bios-for-macos.sh --dry-run
```

## Benefits

### 🔍 **Transparency**
- See exactly what the script will do before running it
- Understand each command and its purpose
- Review directory structures before creation

### 🛡️ **Safety**
- No risk of unintended changes
- Test script functionality without side effects
- Validate environment before real execution

### 📚 **Learning**
- Understand macOS system administration commands
- Learn about development environment setup
- See best practices for automation scripts

### 🐛 **Debugging**
- Test script logic without consequences
- Verify correct paths and commands
- Ensure compatibility with your system

## Implementation Details

The dry-run mode is implemented through:

1. **Global DRY_RUN variable** - Controls execution flow
2. **Helper functions** - `dry_run_command()`, `dry_run_mkdir()`, etc.
3. **Conditional execution** - Real commands vs. preview descriptions
4. **Enhanced logging** - Purple [DRY-RUN] indicators
5. **Command-line parsing** - `--dry-run` and `-n` flags

## Example Output

```bash
$ ./bios-for-macos.sh --dry-run

[INFO] System Summary:
==================
macOS Version: 15.6.1
Hardware: Mac16,11
CPU: Apple M4 Pro
Memory: 24 GB
Hostname: neurodesk
Shell: /bin/zsh
Homebrew: Homebrew 4.6.9
Git: git version 2.50.1
SBRN_HOME: /Users/username/sbrn
==================

[WARNING] DRY-RUN MODE: No changes will be made to your system

[INFO] 🔍 DRY-RUN MODE: Showing what would be executed...
[INFO] 💡 This preview shows planned actions without making changes

[INFO] Starting BIOS-equivalent initialization for macOS...
[INFO] 🔍 Stage 1: Performing Power-On Self-Test (POST) equivalent...
... (system checks run normally - read-only operations)

[INFO] 🔧 Stage 3: Configuring system resources...
[DRY-RUN] Would set SBRN_HOME to /Users/username/sbrn
[DRY-RUN] Would create directories: /Users/username/sbrn/{sys,proj,areas,res,arch}
[DRY-RUN] Would run: Disable hibernation
[DRY-RUN] Command: sudo pmset -a hibernatemode 0
...

[SUCCESS] BIOS-equivalent initialization completed successfully!
```

This dry-run capability makes the script much safer to test and understand before committing to any system changes.
