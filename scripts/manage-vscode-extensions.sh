#!/usr/bin/env bash

# VS Code Extensions Management Script
# This script helps capture, backup, and install VS Code extensions

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="$SCRIPT_DIR/../conf/vscode/extensions.txt"
EXTENSIONS_BACKUP_FILE="$SCRIPT_DIR/extensions-backup-$(date +%Y%m%d-%H%M%S).txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  capture     Capture currently installed extensions to extensions.txt"
    echo "  install     Install extensions from extensions.txt that are missing"
    echo "  sync        Capture current extensions and install any missing ones"
    echo "  backup      Create a timestamped backup of current extensions"
    echo "  diff        Show differences between installed and configured extensions"
    echo "  help        Show this help message"
    echo ""
    echo "Files:"
    echo "  extensions.txt              - Main extensions configuration file"
    echo "  extensions-backup-*.txt     - Timestamped backups"
}

check_vscode_cli() {
    if ! command -v code &> /dev/null; then
        echo -e "${RED}Error: VS Code CLI 'code' command not found.${NC}"
        echo "Please install VS Code and ensure the 'code' command is available in PATH."
        echo "In VS Code: Cmd+Shift+P -> 'Shell Command: Install code command in PATH'"
        exit 1
    fi
}

capture_extensions() {
    echo -e "${BLUE}Capturing currently installed VS Code extensions...${NC}"
    
    # Create backup if extensions.txt exists
    if [[ -f "$EXTENSIONS_FILE" ]]; then
        cp "$EXTENSIONS_FILE" "$EXTENSIONS_BACKUP_FILE"
        echo -e "${YELLOW}Created backup: $(basename "$EXTENSIONS_BACKUP_FILE")${NC}"
    fi
    
    # Capture extensions with versions
    code --list-extensions --show-versions > "$EXTENSIONS_FILE"
    local count=$(wc -l < "$EXTENSIONS_FILE")
    echo -e "${GREEN}Captured $count extensions to extensions.txt${NC}"
}

install_missing_extensions() {
    echo -e "${BLUE}Installing missing VS Code extensions...${NC}"
    
    if [[ ! -f "$EXTENSIONS_FILE" ]]; then
        echo -e "${YELLOW}extensions.txt not found. Capturing current extensions first...${NC}"
        capture_extensions
        echo ""
    fi
    
    local installed_count=0
    local skipped_count=0
    local error_count=0
    
    # Get currently installed extensions (without versions)
    local current_extensions
    current_extensions=$(code --list-extensions)
    
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        
        # Extract extension ID (remove version if present)
        local extension_id="${line%@*}"
        
        # Check if already installed
        if echo "$current_extensions" | grep -q "^$extension_id$"; then
            echo -e "${YELLOW}Skipping $extension_id (already installed)${NC}"
            ((skipped_count++))
        else
            echo -e "${BLUE}Installing $extension_id...${NC}"
            if code --install-extension "$extension_id" --force; then
                echo -e "${GREEN}✓ Installed $extension_id${NC}"
                ((installed_count++))
            else
                echo -e "${RED}✗ Failed to install $extension_id${NC}"
                ((error_count++))
            fi
        fi
    done < "$EXTENSIONS_FILE"
    
    echo ""
    echo -e "${GREEN}Installation complete:${NC}"
    echo -e "  Installed: $installed_count"
    echo -e "  Skipped: $skipped_count"
    echo -e "  Errors: $error_count"
}

backup_extensions() {
    echo -e "${BLUE}Creating backup of current extensions...${NC}"
    code --list-extensions --show-versions > "$EXTENSIONS_BACKUP_FILE"
    echo -e "${GREEN}Backup created: $(basename "$EXTENSIONS_BACKUP_FILE")${NC}"
}

diff_extensions() {
    echo -e "${BLUE}Comparing installed vs configured extensions...${NC}"
    
    if [[ ! -f "$EXTENSIONS_FILE" ]]; then
        echo -e "${RED}Error: extensions.txt not found.${NC}"
        exit 1
    fi
    
    local temp_current="/tmp/vscode-current-extensions.txt"
    code --list-extensions --show-versions > "$temp_current"
    
    echo -e "${YELLOW}Differences (if any):${NC}"
    if diff "$EXTENSIONS_FILE" "$temp_current" > /dev/null; then
        echo -e "${GREEN}No differences found. Extensions are in sync.${NC}"
    else
        echo -e "${BLUE}< Configured (extensions.txt)${NC}"
        echo -e "${BLUE}> Currently Installed${NC}"
        diff "$EXTENSIONS_FILE" "$temp_current" || true
    fi
    
    rm -f "$temp_current"
}

sync_extensions() {
    echo -e "${BLUE}Syncing VS Code extensions...${NC}"
    capture_extensions
    echo ""
    install_missing_extensions
}

# Main execution
case "${1:-help}" in
    capture)
        check_vscode_cli
        capture_extensions
        ;;
    install)
        check_vscode_cli
        install_missing_extensions
        ;;
    sync)
        check_vscode_cli
        sync_extensions
        ;;
    backup)
        check_vscode_cli
        backup_extensions
        ;;
    diff)
        check_vscode_cli
        diff_extensions
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo -e "${RED}Error: Unknown command '$1'${NC}"
        echo ""
        usage
        exit 1
        ;;
esac
