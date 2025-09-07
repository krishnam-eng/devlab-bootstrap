################################################################################
# TREE COMMAND ALIASES (Directory Structure Visualization)
#
# WHAT IS IT:
#   Tree is a command-line utility that displays directory structures in a 
#   tree-like format. These aliases provide common tree command patterns
#   with useful options for different use cases.
#
# TERMINOLOGY:
#   - Tree: Hierarchical directory structure display
#   - Depth/Level: How many subdirectory levels to show
#   - Pattern Filtering: Show/hide files matching specific patterns
#   - Size Display: Show file sizes alongside names
#
# HOW TO USE:
#   Instead of remembering complex tree options, use these convenient aliases:
#   
#   Basic Structure:
#     t                          # Basic tree view (2 levels)
#     tall                       # Show all levels
#     t3                         # Show 3 levels deep
#     
#   Development Focus:
#     tcode                      # Show only code files
#     tconf                      # Show only config files
#     tdocs                      # Show only documentation
#     
#   Size Information:
#     tsize                      # Tree with file sizes
#     tbig                       # Tree showing largest files first
#     
#   Git-Aware:
#     tgit                       # Tree respecting .gitignore
#     tclean                     # Tree without git/build artifacts
#
# HOW TO SET UP:
#   1. Install tree:             brew install tree (macOS) or apt install tree (Linux)
#   2. Use aliases:              t, tall, tcode, etc.
#   3. Combine with pipes:       t | grep "pattern"
#   
# EXAMPLES:
#   t                            # Quick 2-level overview
#   t3 ~/project                 # 3 levels of ~/project
#   tcode                        # Only show source code files
#   tsize | head -20             # Top 20 entries with sizes
#
# BENEFITS:
#   - Quick directory structure overview
#   - Filtered views for specific file types
#   - Size-aware directory exploration
#   - Git-integrated clean views
#   - Consistent depth control
#   - Readable output formatting
#
# COMMON PATTERNS:
#   - Project exploration → t, t3, tcode
#   - Documentation review → tdocs, tmd
#   - Cleanup tasks → tsize, tbig
#   - Development workflow → tgit, tclean
#   - System administration → tall, thidden
#
################################################################################

# === BASIC TREE ALIASES ===
alias tree='tree -C -L 2'                 # Colorized output
alias t1='tree -L 1'                      # Single level (like ls with dirs)
alias t2='tree -L 2'                      # Two levels (most common)
alias t3='tree -L 3'                      # Three levels
alias t4='tree -L 4'                      # Four levels
alias tall='tree'                         # Show all levels (no limit)

# === SIZE & DETAILED INFO ===
alias tsize='tree -sh'                    # Tree with human-readable file sizes
alias t1size='tree -L 1 -sh'              # 1 level with sizes
alias t2size='tree -L 2 -sh'               # 2 levels with sizes
alias t3size='tree -L 3 -sh'               # 3 levels with sizes
alias t4size='tree -L 4 -sh'               # 4 levels with sizes

alias tsort='tree -S'                     # Sort by file size (largest first)
alias ttime='tree -D'                     # Show last modification time
alias tperm='tree -p'                     # Show file permissions
alias tfull='tree -pugsh'                 # Full info: permissions, user, group, size, time

# === FILTERING & PATTERNS ===
# Code Files
alias tcode='tree -P "*.{js,ts,jsx,tsx,py,java,go,rs,c,cpp,h,hpp,sh,rb,php,swift,kt}" -I "node_modules|build|dist|target|.git"'
alias tpy='tree -P "*.{py,pyw,ipynb}" -I "__pycache__|.git|venv|env"'
alias tjs='tree -P "*.{js,ts,jsx,tsx,json}" -I "node_modules|build|dist|.git"'
alias tjava='tree -P "*.{java,kt,kts,gradle}" -I "build|target|.gradle|.git"'
alias tgo='tree -P "*.{go,mod,sum}" -I "vendor|.git"'
alias trust='tree -P "*.{rs,toml}" -I "target|.git"'

# Configuration Files
alias tconf='tree -P "*.{config,conf,cfg,ini,env,yaml,yml,json,toml}" -I ".git"'
alias tyaml='tree -P "*.{yaml,yml}" -I ".git"'
alias tjson='tree -P "*.{json,jsonl}" -I "node_modules|.git"'

# Documentation
alias tdocs='tree -P "*.{md,txt,rst,adoc,tex}" -I ".git"'
alias tmd='tree -P "*.{md,markdown}" -I ".git"'
alias treadme='tree -P "*README*" -I ".git"'

# === GIT & PROJECT AWARENESS ===
alias tgit='tree -I ".git|node_modules|build|dist|target|__pycache__|*.pyc|.DS_Store"'
alias tclean='tree -I ".git|.svn|.hg|CVS|node_modules|build|dist|target|__pycache__|*.pyc|.pytest_cache|.coverage|.DS_Store|Thumbs.db"'
alias tno='tree -I "node_modules|build|dist|target|vendor|.git"'  # No build artifacts

# === SPECIAL VIEWS ===
alias thidden='tree -a'                   # Show hidden files/directories
alias tonly='tree -d'                     # Show only directories
alias tascii='tree -A'                    # ASCII characters only (for copying)
alias tcolor='tree -C'                    # Force colorized output
alias tplain='tree -n'                    # No color (plain text)

# === OUTPUT FORMATS ===
alias thtml='tree -H .'                   # Generate HTML output
alias txml='tree -X'                      # Generate XML output
alias tjsonout='tree -J'                  # Generate JSON output

# === SIZE-BASED EXPLORATION ===
alias tbig='tree -sh | sort -k1 -hr | head -20'  # 20 largest files
alias tsmall='tree -sh | sort -k1 -h | head -20' # 20 smallest files
alias tempty='tree -sh | grep " 0"'       # Find empty files

# === PROJECT-SPECIFIC PATTERNS ===
# Web Development
alias tweb='tree -P "*.{html,css,js,ts,jsx,tsx,vue,svelte}" -I "node_modules|build|dist|.git"'
alias treact='tree -P "*.{jsx,tsx,js,ts,json}" -I "node_modules|build|dist|.git"'
alias tnext='tree -P "*.{js,ts,jsx,tsx,json}" -I "node_modules|.next|build|dist|.git"'

# Mobile Development
alias tios='tree -P "*.{swift,m,h,plist,xcconfig}" -I "build|DerivedData|.git"'
alias tandroid='tree -P "*.{java,kt,xml,gradle}" -I "build|.gradle|.git"'
alias tflutter='tree -P "*.{dart,yaml}" -I "build|.dart_tool|.git"'

# DevOps & Infrastructure
alias tdocker='tree -P "*dockerfile*|*.{yml,yaml}" -I ".git"'
alias tk8s='tree -P "*.{yaml,yml}" -I ".git"'
alias tterraform='tree -P "*.{tf,tfvars,hcl}" -I ".terraform|.git"'

# === UTILITY FUNCTIONS ===
# Tree with custom depth
td() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: td <depth> [directory]"
        echo "Example: td 3 ~/projects"
        return 1
    fi
    local depth=$1
    local dir=${2:-.}
    tree -L "$depth" "$dir"
}

# Tree with custom pattern
tp() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: tp <pattern> [directory]"
        echo "Example: tp '*.py' ~/project"
        return 1
    fi
    local pattern=$1
    local dir=${2:-.}
    tree -P "$pattern" "$dir"
}

# Tree excluding pattern
te() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: te <exclude_pattern> [directory]"
        echo "Example: te 'node_modules' ~/project"
        return 1
    fi
    local exclude=$1
    local dir=${2:-.}
    tree -I "$exclude" "$dir"
}