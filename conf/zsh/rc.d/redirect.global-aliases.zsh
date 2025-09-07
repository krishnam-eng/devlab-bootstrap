################################################################################
# GLOBAL ALIASES - INDUSTRY STANDARD PATTERNS
#
# Global aliases are powerful zsh features that expand anywhere in the command line.
# These are the most commonly used patterns in professional development environments.
#
# SYNTAX: alias -g ALIAS='expansion'
# USAGE:  command ALIAS  →  command | expansion
#
# CATEGORIES:
#   1. PAGING & VIEWING      - H, T, L, M
#   2. FILTERING & SEARCH    - G, GI, GV
#   3. SORTING & COUNTING    - S, U, C, WC
#   4. FORMAT & TRANSFORM    - J, Y, CSV, TSV
#   5. SYSTEM & CLIPBOARD    - CLIP, NULL, ERR
#   6. FILE & PATH           - HEAD, TAIL, navigation
#   7. DEVELOPMENT           - commonly used in CI/CD, logs, debugging
#
# EXAMPLES:
#   ps aux G python         →  ps aux | grep python
#   cat file.json J         →  cat file.json | jq .
#   ls -la S               →  ls -la | sort
#   docker logs container T →  docker logs container | tail
################################################################################

# =============================
# 1. PAGING & VIEWING (Most Essential)
# =============================
alias -g H='| head'                       # First 10 lines: ls H
alias -g H1='| head -1'                   # First line only: ps aux H1
alias -g H5='| head -5'                   # First 5 lines: cat log H5
alias -g T='| tail'                       # Last 10 lines: cat log T
alias -g T1='| tail -1'                   # Last line only: cat file T1
alias -g TF='| tail -f'                   # Follow: cat log TF
alias -g L='| less'                       # Paginate: ps aux L
alias -g M='| more'                       # Paginate (legacy): cat file M

# =============================
# 2. FILTERING & SEARCH (Critical for DevOps)
# =============================
alias -g G='| grep'                       # Search: ps aux G python
alias -g GI='| grep -i'                   # Case insensitive: cat log GI error
alias -g GV='| grep -v'                   # Invert match: ps aux GV grep
alias -g GE='| grep -E'                   # Extended regex: cat log GE '^(ERROR|FATAL)'
alias -g GO='| grep -o'                   # Only matching: echo "foo=bar" GO '[^=]+'
alias -g GN='| grep -n'                   # Line numbers: cat file GN pattern
alias -g GC='| grep -c'                   # Count matches: ps aux GC python
alias -g GR='| grep -r'                   # Recursive: cat files GR pattern

# =============================
# 3. SORTING & COUNTING (Data Processing)
# =============================
alias -g S='| sort'                       # Sort: cat names S
alias -g SN='| sort -n'                   # Numeric sort: du -sh * SN
alias -g SR='| sort -r'                   # Reverse sort: cat file SR
alias -g SRN='| sort -rn'                 # Reverse numeric: du -sh * SRN
alias -g SU='| sort -u'                   # Sort & unique: cat file SU
alias -g SK='| sort -k'                   # Sort by field: ps aux SK2,2
alias -g U='| uniq'                       # Remove duplicates: cat file S U
alias -g UC='| uniq -c'                   # Count duplicates: cat file S UC
alias -g C='| wc -l'                      # Count lines: ps aux C
alias -g WC='| wc'                        # Word count: cat file WC

# =============================
# 4. FORMAT & TRANSFORM (JSON/YAML/CSV)
# =============================
alias -g J='| jq .'                       # Pretty JSON: curl api J
alias -g JC='| jq -c .'                   # Compact JSON: cat file JC
alias -g JR='| jq -r'                     # Raw JSON output: cat file JR '.field'
alias -g Y='| yq .'                       # Pretty YAML: cat file.yml Y
alias -g YJ='| yq -o json'                # YAML to JSON: cat file.yml YJ
alias -g CSV='| column -t -s,'            # Format CSV: cat file.csv CSV
alias -g TSV='| column -t'                # Format TSV: cat file.tsv TSV
alias -g PRETTY='| column -t'             # Format columns: ps aux PRETTY

# =============================
# 5. SYSTEM & CLIPBOARD (Platform Aware)
# =============================
# macOS clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias -g CLIP='| pbcopy'               # Copy to clipboard: cat file CLIP
    alias -g PASTE='pbpaste |'             # Paste from clipboard: PASTE cat
# Linux clipboard (requires xclip)
elif [[ "$OSTYPE" == "linux"* ]]; then
    alias -g CLIP='| xclip -selection clipboard'
    alias -g PASTE='xclip -selection clipboard -o |'
fi

# Output redirection
alias -g NULL='> /dev/null 2>&1'          # Silence all: noisy-command NULL
alias -g QUIET='2>/dev/null'              # Silence errors: command QUIET
alias -g ERR='2>&1'                       # Redirect stderr: command ERR L
alias -g OUT='>/dev/null'                 # Silence stdout: command OUT
alias -g BOTH='2>&1'                      # Combine streams: command BOTH T
alias -g NE='2>/dev/null'                 # No errors (shorter): command NE

# =============================
# 6. FILE & PATH OPERATIONS
# =============================
alias -g DN='/dev/null'                   # Dev null: echo test > DN
alias -g TMP='> /tmp/output.tmp'          # Temp file: command TMP
alias -g LOG='| tee -a /tmp/debug.log'    # Log to file: command LOG
alias -g TLOG='| tee /tmp/debug.log'      # Overwrite log: command TLOG

# Path navigation (commonly used in scripts)
alias -g ...='../..'                      # Parent parent: cd ...
alias -g ....='../../..'                  # 3 levels up: cd ....
alias -g .....='../../../..'              # 4 levels up: cd .....

# =============================
# 7. DEVELOPMENT & DEVOPS (Industry Patterns)
# =============================
# Version checking
alias -g V='--version'                    # Version: python V, node V, docker V
alias -g VV='--version --verbose'         # Verbose version: some-tool VV

# Help and documentation
alias -g HELP='--help'                    # Help: command HELP L
alias -g MAN='--help 2>&1'               # Manual style: command MAN L

# Process and system monitoring
alias -g PS='| ps aux G'                  # Process search: echo python PS
alias -g TOP='| head -20'                 # Top entries: du -sh * SRN TOP
alias -g BOT='| tail -20'                 # Bottom entries: cat log BOT

# Data extraction (log analysis, CSV processing)
alias -g F1='| awk "{print $1}"'          # First field: ps aux F1
alias -g F2='| awk "{print $2}"'          # Second field: ps aux F2
alias -g F3='| awk "{print $3}"'          # Third field: ps aux F3
alias -g FIELDS='| awk'                   # AWK processing: data FIELDS '{sum+=$1} END {print sum}'

# Text processing chains (very common in data ops)
alias -g TRIM='| sed "s/^[[:space:]]*//;s/[[:space:]]*$//"'  # Trim whitespace
alias -g LOWER='| tr "[:upper:]" "[:lower:]"'                # Lowercase
alias -g UPPER='| tr "[:lower:]" "[:upper:]"'                # Uppercase
alias -g NOBL='| grep -v "^$"'                              # Remove blank lines
alias -g ONELINE='| tr "\n" " "'                            # Join lines

# =============================
# 8. XARGS PATTERNS (Process Lists)
# =============================
alias -g X='| xargs'                      # Basic xargs: ls X rm
alias -g X0='| xargs -0'                  # Null separated: find . -print0 X0 rm
alias -g XI='| xargs -I{}'                # Replace string: ls XI echo "File: {}"
alias -g XL='| xargs -L1'                 # One line each: cat list XL process
alias -g XN='| xargs -n1'                 # One arg each: cat args XN command
alias -g XG='| xargs grep'                # Grep in files: find . -name "*.txt" XG pattern

# =============================
# 9. CONDITIONAL & LOGICAL (Scripting)
# =============================
alias -g AND='&&'                         # Success chain: command1 AND command2
alias -g OR='||'                          # Failure chain: command1 OR command2

# =============================
# 10. PERFORMANCE & TIMING (Monitoring)
# =============================
alias -g TIME='time'                      # Time command: TIME complex-operation
alias -g PERF='| ts'                      # Timestamp lines (if ts available)

# =============================
# 11. ENCODINGS & FORMATS (Data Transfer)
# =============================
alias -g B64='| base64'                   # Base64 encode: echo text B64
alias -g B64D='| base64 -d'              # Base64 decode: echo encoded B64D
alias -g URL='| python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read().strip()))"'  # URL encode
alias -g URLD='| python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.stdin.read().strip()))"' # URL decode

# =============================
# EXAMPLES OF POWERFUL COMBINATIONS:
# =============================
# ps aux G python C                      → Count Python processes
# docker ps G nginx F1                   → Get nginx container IDs
# cat large.log G ERROR T                → Last 10 errors
# kubectl get pods G Running F1 XL kubectl delete pod
#                                        → Delete all running pods
# curl -s api.com J JR '.data[]'        → Extract data array from API
# cat access.log F1 S UC SR TOP         → Top IP addresses by frequency