#!/usr/bin/env zsh
# Function Loader System
# Description: Extensible system for loading modular zsh functions
# Follows Open-Closed Principle (OCP) for easy extension

# Function to load all function modules from the functions directory
load_zsh_functions() {
    local functions_dir="${ZSH_FUNCTIONS_DIR:-${ZDOTDIR:-$HOME/.config/zsh}/functions}"
    local loaded_count=0
    local failed_modules=()
    
    # Check if functions directory exists
    if [[ ! -d "$functions_dir" ]]; then
        echo "⚠️  Functions directory not found: $functions_dir"
        return 1
    fi
    
    # Load all .zsh files in the functions directory
    for function_file in "$functions_dir"/*.zsh(N); do
        local module_name="$(basename "$function_file" .zsh)"
        
        if [[ -r "$function_file" ]]; then
            if source "$function_file" 2>/dev/null; then
                ((loaded_count++))
                [[ -n "$ZSH_FUNCTIONS_VERBOSE" ]] && echo "✅ Loaded: $module_name functions"
            else
                failed_modules+=("$module_name")
                echo "❌ Failed to load: $module_name functions"
            fi
        else
            failed_modules+=("$module_name (not readable)")
            echo "❌ Cannot read: $function_file"
        fi
    done
    
    # Summary (only show if verbose or there were failures)
    if [[ -n "$ZSH_FUNCTIONS_VERBOSE" ]] || [[ ${#failed_modules[@]} -gt 0 ]]; then
        echo "📊 Function modules loaded: $loaded_count"
        
        if [[ ${#failed_modules[@]} -gt 0 ]]; then
            echo "❌ Failed modules:"
            for failed in "${failed_modules[@]}"; do
                echo "   • $failed"
            done
        fi
    fi
    
    return 0
}

# Function to reload all function modules (useful for development)
reload_zsh_functions() {
    echo "🔄 Reloading all function modules..."
    ZSH_FUNCTIONS_VERBOSE=1 load_zsh_functions
}

# Function to list available function modules
list_zsh_functions() {
    local functions_dir="${ZSH_FUNCTIONS_DIR:-${ZDOTDIR:-$HOME/.config/zsh}/functions}"
    
    if [[ ! -d "$functions_dir" ]]; then
        echo "⚠️  Functions directory not found: $functions_dir"
        return 1
    fi
    
    echo "📁 Available function modules in: $functions_dir"
    echo
    
    for function_file in "$functions_dir"/*.zsh(N); do
        local module_name="$(basename "$function_file" .zsh)"
        local description=""
        
        # Try to extract description from the file
        if [[ -r "$function_file" ]]; then
            description="$(grep '^# Description:' "$function_file" | head -1 | sed 's/^# Description: //')"
        fi
        
        if [[ -n "$description" ]]; then
            echo "📋 $module_name: $description"
        else
            echo "📋 $module_name"
        fi
    done
}

# Function to create a new function module template
create_function_module() {
    local module_name="$1"
    local functions_dir="${ZSH_FUNCTIONS_DIR:-${ZDOTDIR:-$HOME/.config/zsh}/functions}"
    
    if [[ -z "$module_name" ]]; then
        echo "Usage: create_function_module <module_name>"
        echo "Example: create_function_module docker"
        return 1
    fi
    
    local module_file="$functions_dir/${module_name}.zsh"
    
    if [[ -f "$module_file" ]]; then
        echo "❌ Module already exists: $module_file"
        return 1
    fi
    
    # Create the template
    cat > "$module_file" << EOF
#!/usr/bin/env zsh
# ${module_name^} functions
# Description: Functions for managing ${module_name}

# Add your functions here following this pattern:
# function_name() {
#     # Function implementation
# }

# Example function (remove this when adding real functions):
${module_name}_hello() {
    echo "Hello from ${module_name} module!"
}
EOF
    
    echo "✅ Created new function module: $module_file"
    echo "📝 Edit the file to add your functions, then run 'reload_zsh_functions' to load them"
}