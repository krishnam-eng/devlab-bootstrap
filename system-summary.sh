#!/bin/zsh

# Colors for output
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Function to show system summary
show_system_summary() {
    log_info "Developer Environment Summary:"
    echo "=================================="
    echo "macOS Version: $(sw_vers -productVersion)"
    echo "Hardware: $(sysctl -n hw.model)"
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
    echo "Shell: $SHELL"
    echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "Git: $(git --version 2>/dev/null || echo 'Not installed')"
    echo "Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
    echo "Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "Java: $(java --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "VS Code: $(code --version 2>/dev/null | head -1 || echo 'Not installed')"
    echo "SBRN_HOME: ${SBRN_HOME:-'Not set'}"
    echo "=================================="
}

# Call the function
show_system_summary
