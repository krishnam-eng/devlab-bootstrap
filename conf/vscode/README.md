# VS Code Configuration Management

This directory contains VS Code configuration files and management scripts for systematic backup and restoration of your development environment.

## Files

- `settings.json` - VS Code settings configuration
- `extensions.txt` - List of installed extensions with versions
- `manage-extensions.sh` - Script to manage VS Code extensions
- `extensions-backup-*.txt` - Timestamped backups of extensions

## Extension Management

### Quick Start

```bash
# Navigate to the vscode config directory
cd conf/vscode

# Make the script executable (if not already done)
chmod +x manage-extensions.sh

# Show help
./manage-extensions.sh help
```

### Available Commands

#### Capture Current Extensions
```bash
./manage-extensions.sh capture
```
Saves all currently installed extensions to `extensions.txt`.

#### Install Missing Extensions
```bash
./manage-extensions.sh install
```
Installs any extensions listed in `extensions.txt` that are not currently installed.

#### Sync Extensions
```bash
./manage-extensions.sh sync
```
Captures current extensions and installs any missing ones (combination of capture + install).

#### Create Backup
```bash
./manage-extensions.sh backup
```
Creates a timestamped backup of current extensions.

#### Compare Extensions
```bash
./manage-extensions.sh diff
```
Shows differences between configured extensions and currently installed ones.

### Workflow Examples

#### Setting up a new machine
```bash
# Clone your dotfiles/config repo
git clone <your-repo>
cd conf/vscode

# Install all configured extensions
./manage-extensions.sh install
```

#### Before making changes
```bash
# Create a backup before experimenting with new extensions
./manage-extensions.sh backup
```

#### After installing new extensions
```bash
# Capture new extensions to keep config up to date
./manage-extensions.sh capture
```

#### Regular maintenance
```bash
# Check if everything is in sync
./manage-extensions.sh diff

# Or sync everything
./manage-extensions.sh sync
```

## Integration with Other Tools

### Add to your shell profile
You can add an alias to your shell profile (`.zshrc`, `.bashrc`, etc.):

```bash
alias vscode-ext='~/path/to/conf/vscode/manage-extensions.sh'
```

Then use:
```bash
vscode-ext sync
vscode-ext capture
vscode-ext install
```

### Automation in provision script
Add to your main provision script:
```bash
# Install VS Code extensions
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    ~/path/to/conf/vscode/manage-extensions.sh install
fi
```

## Notes

- The script automatically creates backups when capturing over existing extensions.txt
- Extensions are installed with `--force` flag to ensure they're properly installed
- The script checks for VS Code CLI availability before running
- Both extension ID and version are captured for precise environment reproduction
- Empty lines and comments (starting with #) in extensions.txt are ignored during installation

## Troubleshooting

### VS Code CLI not found
If you get "code command not found":
1. Open VS Code
2. Press `Cmd+Shift+P` (on macOS) or `Ctrl+Shift+P` (on Linux/Windows)
3. Type "Shell Command: Install 'code' command in PATH"
4. Select and run the command

### Extension installation fails
- Check internet connection
- Verify the extension ID is correct
- Some extensions may have been removed from the marketplace
- Try installing manually through VS Code interface first
