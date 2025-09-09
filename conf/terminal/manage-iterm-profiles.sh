#!/usr/bin/env bash
# iTerm2 Profiles Management Script
# This script helps export, backup, and import iTerm2 profiles systematically

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$SCRIPT_DIR/profiles"
COLORS_DIR="$SCRIPT_DIR/colors"
PROFILES_EXPORT_FILE="$SCRIPT_DIR/profiles/profiles.iterm2.json"
PROFILES_BACKUP_FILE="$SCRIPT_DIR/profiles/profiles-backup-$(date +%Y%m%d-%H%M%S).iterm2.json"

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
    echo "  export      Export current iTerm2 profiles to profiles.iterm2.json"
    echo "  import      Import profiles from profiles.iterm2.json to iTerm2"
    echo "  backup      Create a timestamped backup of current profiles"
    echo "  list        List all available profiles and color schemes"
    echo "  sync        Export current profiles and import any missing ones"
    echo "  install     Install color schemes and set up profile structure"
    echo "  help        Show this help message"
    echo ""
    echo "Files:"
    echo "  profiles.iterm2.json     Main profiles configuration file"
    echo "  profiles-backup-*.json   Timestamped backups"
    echo "  colors/*.itermcolors     Color scheme files"
    echo "  profiles/*.json          Individual profile files"
    echo ""
}

check_iterm2() {
    if ! command -v osascript &> /dev/null; then
        echo -e "${RED}Error: osascript not found. This script requires macOS.${NC}"
        return 1
    fi
    
    if ! osascript -e 'tell application "System Events" to get name of processes' | grep -q "iTerm2"; then
        echo -e "${YELLOW}Warning: iTerm2 is not running. Some operations may require iTerm2 to be running.${NC}"
    fi
    return 0
}

export_profiles() {
    echo -e "${BLUE}Exporting iTerm2 profiles...${NC}"
    
    # Create profiles directory if it doesn't exist
    mkdir -p "$PROFILES_DIR"
    
    # Use AppleScript to export iTerm2 preferences
    osascript << EOF
tell application "iTerm2"
    try
        set profilesList to every profile of current session of current window
        return "Found " & (count of profilesList) & " profiles"
    on error
        return "Error accessing iTerm2 profiles"
    end try
end tell
EOF

    # Alternative method using defaults command for iTerm2 preferences
    if [[ -f ~/Library/Preferences/com.googlecode.iterm2.plist ]]; then
        echo -e "${BLUE}Exporting from iTerm2 preferences...${NC}"
        
        # Convert binary plist to JSON for easier manipulation
        plutil -convert json ~/Library/Preferences/com.googlecode.iterm2.plist -o /tmp/iterm2-prefs.json
        
        # Extract profiles section
        if command -v jq &> /dev/null; then
            jq '.["New Bookmarks"]' /tmp/iterm2-prefs.json > "$PROFILES_EXPORT_FILE" 2>/dev/null
            if [[ $? -eq 0 && -s "$PROFILES_EXPORT_FILE" ]]; then
                echo -e "${GREEN}Profiles exported to profiles.iterm2.json${NC}"
            else
                echo -e "${YELLOW}Using alternative export method...${NC}"
                cp ~/Library/Preferences/com.googlecode.iterm2.plist "$PROFILES_EXPORT_FILE.plist"
                echo -e "${GREEN}Preferences exported to profiles.iterm2.json.plist${NC}"
            fi
        else
            echo -e "${YELLOW}jq not found. Exporting raw preferences file...${NC}"
            cp ~/Library/Preferences/com.googlecode.iterm2.plist "$PROFILES_EXPORT_FILE.plist"
            echo -e "${GREEN}Raw preferences exported to profiles.iterm2.json.plist${NC}"
        fi
        
        # Clean up
        rm -f /tmp/iterm2-prefs.json
    else
        echo -e "${RED}Error: iTerm2 preferences file not found${NC}"
        return 1
    fi
}

import_profiles() {
    echo -e "${BLUE}Importing iTerm2 profiles...${NC}"
    
    if [[ ! -f "$PROFILES_EXPORT_FILE" && ! -f "$PROFILES_EXPORT_FILE.plist" ]]; then
        echo -e "${RED}Error: No profiles file found. Run 'export' first.${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Note: Import requires manual steps in iTerm2:${NC}"
    echo "1. Open iTerm2 → Preferences → Profiles"
    echo "2. Click 'Other Actions...' → 'Import JSON Profiles'"
    echo "3. Select: $PROFILES_EXPORT_FILE"
    echo ""
    echo -e "${BLUE}Alternatively, to import preferences:${NC}"
    echo "1. Open iTerm2 → Preferences → General → Preferences"
    echo "2. Click 'Load preferences from a custom folder or URL'"
    echo "3. Select: $SCRIPT_DIR"
    
    # Provide quick access to the file
    if command -v open &> /dev/null; then
        echo -e "${BLUE}Opening profiles directory...${NC}"
        open "$PROFILES_DIR"
    fi
}

backup_profiles() {
    echo -e "${BLUE}Creating backup of current profiles...${NC}"
    
    if [[ -f "$PROFILES_EXPORT_FILE" ]]; then
        cp "$PROFILES_EXPORT_FILE" "$PROFILES_BACKUP_FILE"
        echo -e "${GREEN}Backup created: $(basename "$PROFILES_BACKUP_FILE")${NC}"
    elif [[ -f "$PROFILES_EXPORT_FILE.plist" ]]; then
        cp "$PROFILES_EXPORT_FILE.plist" "$PROFILES_BACKUP_FILE.plist"
        echo -e "${GREEN}Backup created: $(basename "$PROFILES_BACKUP_FILE").plist${NC}"
    else
        echo -e "${YELLOW}No existing profiles file to backup. Running export first...${NC}"
        export_profiles
        if [[ -f "$PROFILES_EXPORT_FILE" ]]; then
            cp "$PROFILES_EXPORT_FILE" "$PROFILES_BACKUP_FILE"
            echo -e "${GREEN}Backup created: $(basename "$PROFILES_BACKUP_FILE")${NC}"
        fi
    fi
}

list_profiles() {
    echo -e "${BLUE}Available iTerm2 configurations:${NC}"
    echo ""
    
    echo -e "${YELLOW}Color Schemes:${NC}"
    if [[ -d "$COLORS_DIR" ]]; then
        find "$COLORS_DIR" -name "*.itermcolors" -exec basename {} .itermcolors \; | sort | sed 's/^/  • /'
    else
        echo "  No color schemes found"
    fi
    
    echo ""
    echo -e "${YELLOW}Profile Files:${NC}"
    if [[ -d "$PROFILES_DIR" ]]; then
        find "$PROFILES_DIR" -name "*.json" -exec basename {} .json \; | sort | sed 's/^/  • /'
    else
        echo "  No profile files found"
    fi
    
    echo ""
    if [[ -f "$PROFILES_EXPORT_FILE" ]]; then
        echo -e "${GREEN}Main configuration: profiles.iterm2.json${NC}"
    else
        echo -e "${YELLOW}Main configuration: Not found (run 'export' to create)${NC}"
    fi
    
    echo ""
    echo -e "${YELLOW}Backup files:${NC}"
    find "$PROFILES_DIR" -name "profiles-backup-*.json" -o -name "profiles-backup-*.plist" 2>/dev/null | \
        sort -r | head -5 | sed 's/^.*\///;s/^/  • /' || echo "  No backups found"
}

install_color_schemes() {
    echo -e "${BLUE}Installing color schemes to iTerm2...${NC}"
    
    if [[ ! -d "$COLORS_DIR" ]]; then
        echo -e "${RED}Error: Colors directory not found: $COLORS_DIR${NC}"
        return 1
    fi
    
    local installed_count=0
    for color_file in "$COLORS_DIR"/*.itermcolors; do
        if [[ -f "$color_file" ]]; then
            echo -e "${BLUE}Installing $(basename "$color_file" .itermcolors)...${NC}"
            open "$color_file"
            ((installed_count++))
            sleep 1  # Give iTerm2 time to process
        fi
    done
    
    if [[ $installed_count -gt 0 ]]; then
        echo -e "${GREEN}Installed $installed_count color schemes${NC}"
        echo -e "${YELLOW}Note: Color schemes are now available in iTerm2 → Preferences → Profiles → Colors${NC}"
    else
        echo -e "${YELLOW}No color scheme files found in $COLORS_DIR${NC}"
    fi
}

sync_profiles() {
    echo -e "${BLUE}Syncing iTerm2 profiles...${NC}"
    backup_profiles
    echo ""
    export_profiles
    echo ""
    echo -e "${YELLOW}Sync completed. Use 'import' command to apply profiles to iTerm2.${NC}"
}

# Main execution
case "${1:-help}" in
    export)
        check_iterm2
        export_profiles
        ;;
    import)
        check_iterm2
        import_profiles
        ;;
    backup)
        check_iterm2
        backup_profiles
        ;;
    list)
        list_profiles
        ;;
    sync)
        check_iterm2
        sync_profiles
        ;;
    install)
        check_iterm2
        install_color_schemes
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        echo ""
        usage
        exit 1
        ;;
esac
