# Search tool aliases and functions
# Source this file in your shell configuration

# Ripgrep aliases
alias rg='rg'                          # Standard ripgrep
alias rgi='rg --ignore-case'           # Case insensitive search
alias rgf='rg --files'                 # List files that would be searched
alias rgl='rg --files-with-matches'    # Show only file names with matches
alias rgv='rg --invert-match'          # Invert match (like grep -v)
alias rgw='rg --word-regexp'           # Match whole words only
alias rgj='rg --type json'             # Search only JSON files
alias rgp='rg --type py'               # Search only Python files
alias rgjs='rg --type js'              # Search only JavaScript files
alias rgmd='rg --type md'              # Search only Markdown files
alias rgy='rg --type yaml'             # Search only YAML files

# Grep aliases
alias grep='grep --color=auto'         # Colorize grep output
alias egrep='egrep --color=auto'       # Colorize egrep output
alias fgrep='fgrep --color=auto'       # Colorize fgrep output

# Combined search functions
function rgcode() {
    # Search in common code file types
    rg --type py --type js --type ts --type java --type go --type rust --type c --type cpp "$@"
}

function rgconfig() {
    # Search in common config file types
    rg --type yaml --type json --type toml --type ini --type xml "$@"
}

function rglog() {
    # Search in log files with context
    rg --type log --context 5 "$@"
}

# Quick file finding
function ff() {
    # Find files by name (case insensitive)
    rg --files | rg -i "$1"
}

# Ripgrep + eza combinations
function rgfiles() {
    # List files that ripgrep would search, displayed with eza
    rg --files "$@" | while read -r file; do
        if [[ -f "$file" ]]; then
            eza -al "$file"
        fi
    done
}

function rglist() {
    # Find files matching pattern and list with eza
    local pattern="$1"
    shift
    rg --files-with-matches "$pattern" "$@" | while read -r file; do
        if [[ -f "$file" ]]; then
            echo "📁 File: $file"
            eza -al "$file"
            echo ""
        fi
    done
}

function rgdir() {
    # Search for pattern and group results by directory with eza
    local pattern="$1"
    shift
    local dirs=($(rg --files-with-matches "$pattern" "$@" | xargs -I{} dirname {} | sort -u))
    
    for dir in "${dirs[@]}"; do
        echo "📂 Directory: $dir"
        eza -al "$dir"
        echo "🔍 Matches in this directory:"
        rg --color=always --line-number "$pattern" "$dir"/* 2>/dev/null || true
        echo "────────────────────────────────────────"
        echo ""
    done
}

# Search and replace preview (requires fzf)
if command -v fzf >/dev/null 2>&1; then
    function rgs() {
        # Interactive ripgrep with fzf
        rg --color=always --line-number --no-heading --smart-case "${*:-}" |
            fzf --ansi \
                --color "hl:-1:underline,hl+:-1:underline:reverse" \
                --delimiter : \
                --preview 'bat --color=always {1} --highlight-line {2}' \
                --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
    }
    
    function rgeza() {
        # Interactive file finder with eza preview
        rg --files | fzf --preview 'eza -al --color=always {}'
    }
fi
