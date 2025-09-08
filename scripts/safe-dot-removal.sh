#!/bin/bash

# Safe Dot Files Removal Script
# This script removes dot files that can be automatically recreated

set -eo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Create backup directory
BACKUP_DIR="$HOME/sbrn/sys/backup/auto-recreatable-$(date +%Y%m%d-%H%M%S)"

backup_and_remove() {
    local item="$1"
    local description="$2"
    local path="$HOME/$item"
    
    if [[ -e "$path" ]]; then
        log "Processing $item..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$path" "$BACKUP_DIR/"
        rm -rf "$path"
        success "Removed $item ($description)"
        return 0
    else
        warning "$item not found"
        return 1
    fi
}

show_item() {
    local item="$1"
    local description="$2"
    local emoji="$3"
    
    if [[ -e "$HOME/$item" ]]; then
        echo -e "${YELLOW}$emoji $item${NC} - $description"
        return 0
    fi
    return 1
}

main() {
    echo "Safe Dot Files Removal"
    echo "======================"
    echo ""
    
    if [[ "${1:-}" == "--dry-run" ]]; then
        echo "DRY RUN MODE - No files will be removed"
        echo ""
        echo "Files/directories that can be safely removed (auto-recreatable):"
        echo ""
        
        show_item ".lesshst" "Less history - recreated in \$XDG_STATE_HOME/less_history" "📄"
        show_item ".viminfo" "Vim info - recreated in \$XDG_STATE_HOME/vim/viminfo" "📄"
        show_item ".z" "Z navigation data - recreated in \$XDG_STATE_HOME/z" "📄"
        show_item ".condarc" "Conda config - using XDG-compliant version" "📄"
        show_item ".aws" "AWS config - recreated in \$XDG_CONFIG_HOME/aws" "📁"
        show_item ".conda" "Conda data - recreated in \$XDG_DATA_HOME/conda" "📁"
        show_item ".npm" "NPM cache - recreated in \$XDG_CACHE_HOME/npm" "📁"
        show_item ".ipython" "IPython config - recreated in \$XDG_CONFIG_HOME/ipython" "📁"
        
        echo ""
        echo "Unused application configs (safe to remove):"
        echo ""
        
        show_item ".p10k.zsh" "Powerlevel10k config - user not using" "📄"
        show_item ".profile" "Shell profile - user not using" "📄"
        show_item ".claude" "Claude AI config - user not using" "📁"
        show_item ".codegpt" "CodeGPT config - user not using" "📁"
        show_item ".cursor" "Cursor editor config - user not using" "📁"
        show_item ".nvm" "Node Version Manager - user not using" "📁"
        
        echo ""
        echo "Files/directories that need manual review:"
        echo ""
        
        show_item ".p10k.zsh" "Powerlevel10k config - contains personal customizations" "📄"
        show_item ".profile" "Shell profile - may contain custom settings" "📄"
        show_item ".claude" "Claude AI config - may contain API keys or preferences" "📁"
        show_item ".codegpt" "CodeGPT config - may contain API keys or preferences" "📁"
        show_item ".cursor" "Cursor editor config - may contain personal settings" "📁"
        show_item ".directory_history" "Directory navigation history - user data" "📁"
        show_item ".junie" "Junie config - may contain personal settings" "📁"
        show_item ".sonarlint" "SonarLint config - may contain project settings" "📁"
        show_item ".tabnine" "TabNine config - may contain personal preferences" "📁"
        show_item ".terminfo" "Terminal info database - may be needed for terminal compatibility" "📁"
        show_item ".vscode" "VS Code config - contains extensions and settings" "📁"
        show_item ".nvm" "Node Version Manager - contains installed Node versions" "📁"
        show_item ".redhat" "Red Hat config - may contain authentication" "📁"
        
        exit 0
    fi
    
    # Ask for confirmation
    echo "This script will remove dot files that can be automatically recreated."
    echo "All files will be backed up to: $BACKUP_DIR"
    echo ""
    read -p "Do you want to continue? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
    
    log "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    
    echo ""
    log "Removing auto-recreatable files and directories..."
    
    # Remove auto-recreatable items
    backup_and_remove ".lesshst" "Less history - recreated in \$XDG_STATE_HOME/less_history"
    backup_and_remove ".viminfo" "Vim info - recreated in \$XDG_STATE_HOME/vim/viminfo"
    backup_and_remove ".z" "Z navigation data - recreated in \$XDG_STATE_HOME/z"
    backup_and_remove ".condarc" "Conda config - using XDG-compliant version"
    backup_and_remove ".aws" "AWS config - recreated in \$XDG_CONFIG_HOME/aws"
    backup_and_remove ".conda" "Conda data - recreated in \$XDG_DATA_HOME/conda"
    backup_and_remove ".npm" "NPM cache - recreated in \$XDG_CACHE_HOME/npm"
    backup_and_remove ".ipython" "IPython config - recreated in \$XDG_CONFIG_HOME/ipython"
    
    echo ""
    log "Removing unused application configs..."
    
    # Remove unused application configs (user confirmed not using these)
    backup_and_remove ".p10k.zsh" "Powerlevel10k config - user not using"
    backup_and_remove ".profile" "Shell profile - user not using"
    backup_and_remove ".claude" "Claude AI config - user not using"
    backup_and_remove ".codegpt" "CodeGPT config - user not using"
    backup_and_remove ".cursor" "Cursor editor config - user not using"
    backup_and_remove ".nvm" "Node Version Manager - user not using"
    
    echo ""
    success "Auto-recreatable files and directories have been removed"
    success "Backups saved to: $BACKUP_DIR"
    
    echo ""
    log "Remaining dot files that need manual review:"
    echo ""
    
    show_item ".directory_history" "Directory navigation history - user data" "📁"
    show_item ".junie" "Junie config - may contain personal settings" "📁"
    show_item ".sonarlint" "SonarLint config - may contain project settings" "📁"
    show_item ".tabnine" "TabNine config - may contain personal preferences" "📁"
    show_item ".terminfo" "Terminal info database - may be needed for terminal compatibility" "📁"
    show_item ".vscode" "VS Code config - contains extensions and settings" "📁"
    show_item ".redhat" "Red Hat config - may contain authentication" "📁"
    
    echo ""
    log "Checking final state..."
    remaining_dots=$(ls -la ~ | grep "^\." | grep -v -E "\.(CFUserTextEncoding|DS_Store|Trash|ssh|config|local|cache|zshenv)$" | wc -l)
    echo "Remaining dot files: $remaining_dots"
    
    if [[ $remaining_dots -gt 0 ]]; then
        echo ""
        echo "Remaining dot files:"
        ls -la ~ | grep "^\." | grep -v -E "\.(CFUserTextEncoding|DS_Store|Trash|ssh|config|local|cache|zshenv)$"
    fi
    
    echo ""
    log "Next steps:"
    echo "1. Review the remaining files/directories listed above"
    echo "2. For application configs with personal settings, consider moving them manually"
    echo "3. Restart your shell: exec zsh"
    echo "4. Test your applications to ensure they work correctly"
}

main "$@"
