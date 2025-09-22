#!/usr/bin/env zsh

alias rzsh='refresh-zsh'

# rzsh - Refresh zsh by loading all configuration files
function refresh-zsh() {
    local zsh_conf_dir="${HOME}/sbrn/sys/hrt/conf/zsh"
    local functions_dir="${zsh_conf_dir}/functions"
    local rc_dir="${zsh_conf_dir}/rc.d"
    
    echo "🔄 Refreshing zsh configuration..."
    
    # Source core zsh configuration files in proper order
    local zsh_files=(".zshenv" ".zprofile" ".zshrc" ".zlogin")
    
    for zsh_file in "${zsh_files[@]}"; do
        local file_path="${zsh_conf_dir}/${zsh_file}"
        if [[ -f "$file_path" ]]; then
            echo "⚙️  Sourcing: $zsh_file"
            source "$file_path"
        else
            echo "⚠️  File not found: $zsh_file"
        fi
    done
    
    # Source all files in functions directory
    if [[ -d "$functions_dir" ]]; then
        echo "📁 Loading functions from: $functions_dir"
        for file in "$functions_dir"/*.zsh; do
            if [[ -f "$file" ]]; then
                echo "  ⚡ Sourcing: $(basename "$file")"
                source "$file"
            fi
        done
    else
        echo "⚠️  Functions directory not found: $functions_dir"
    fi
    
    # Source all files in rc.d directory
    if [[ -d "$rc_dir" ]]; then
        echo "📁 Loading rc files from: $rc_dir"
        for file in "$rc_dir"/*.zsh; do
            if [[ -f "$file" ]]; then
                echo "  ⚡ Sourcing: $(basename "$file")"
                source "$file"
            fi
        done
    else
        echo "⚠️  RC directory not found: $rc_dir"
    fi
    
    echo "✅ Zsh configuration refreshed successfully!"
    
    # Rehash to update command completions and update prompt
    rehash
}