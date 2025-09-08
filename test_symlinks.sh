#!/bin/zsh

# Test script for create_app_cli_symlinks function

# Mock the log functions for testing
function log_info() {
    echo "[INFO] $1"
}

function log_success() {
    echo "[SUCCESS] $1"
}

# Set up test environment variables
export SBRN_HOME="/Users/balamurugank/sbrn"

# Extract and test the create_app_cli_symlinks function
function create_app_cli_symlinks() {
    log_info "Creating symbolic links for Application command-line access..."

        local bin_dir="$SBRN_HOME/sys/bin"


        # App symlink definitions: (relative app dir, cli_name, actual_executable)
        typeset -A app_symlinks
        app_symlinks=(
            "Visual Studio Code.app" "code:Contents/Resources/app/bin/code"
            "IntelliJ IDEA.app" "idea-ultimate:Contents/MacOS/idea"
            "IntelliJ IDEA CE.app" "idea:Contents/MacOS/idea"
            "PyCharm.app" "pycharm:Contents/MacOS/pycharm"
            "Cursor.app" "cursor:Contents/MacOS/Cursor"
            "DBeaver.app" "dbeaver:Contents/MacOS/dbeaver"
            "DevToys.app" "devtoys:Contents/MacOS/DevToys"
            "LM Studio.app" "lmstudio:Contents/MacOS/LM Studio"
            "Figma.app" "figma:Contents/MacOS/Figma"
            "Framer.app" "framer:Contents/MacOS/Framer"
            "Obsidian.app" "obsidian:Contents/MacOS/Obsidian"
            "Notion.app" "notion:Contents/MacOS/Notion"
            "GitHub Desktop.app" "github:Contents/MacOS/GitHub Desktop"
            "Insomnia.app" "insomnia:Contents/MacOS/Insomnia"
            "Postman.app" "postman:Contents/MacOS/Postman"
            "Rancher Desktop.app" "rancher:Contents/MacOS/Rancher Desktop"
            "RapidAPI.app" "rapidapi:Contents/MacOS/RapidAPI"
            "Slack.app" "slack:Contents/MacOS/Slack"
            "VirtualBox.app" "vbox:Contents/MacOS/VirtualBoxVM"
            "pgAdmin 4.app" "pgadmin:Contents/MacOS/pgAdmin4"
            "zoom.us.app" "zoom:Contents/MacOS/zoom.us"
        )

        # Test: Print the associative array to verify it's working
        echo "Testing associative array parsing:"
        for app_dir in "${(@k)app_symlinks}"; do
            echo "  App: $app_dir -> ${app_symlinks[$app_dir]}"
        done

        # Create bin directory if it doesn't exist (for testing)
        mkdir -p "$bin_dir"

        # Check both /Applications and $HOME/Applications
        for app_dir in "${(@k)app_symlinks}"; do
            local cli_def="${app_symlinks[$app_dir]}"
            local cli_name="${cli_def%%:*}"
            local exec_rel_path="${cli_def#*:}"
            local found_app_path=""
            for base_dir in "/Applications" "$HOME/Applications"; do
                local app_path="$base_dir/$app_dir"
                local exec_path="$app_path/$exec_rel_path"
                if [[ -d "$app_path" ]] && [[ -f "$exec_path" ]]; then
                    found_app_path="$exec_path"
                    break
                fi
            done
            if [[ -n "$found_app_path" ]] && [[ ! -L "$bin_dir/$cli_name" ]]; then
                echo "Would create symlink: ln -sf \"$found_app_path\" \"$bin_dir/$cli_name\""
                # Uncomment the next line to actually create the symlink
                # ln -sf "$found_app_path" "$bin_dir/$cli_name"
                log_success "Would create symlink for $cli_name ($found_app_path)"
            elif [[ -n "$found_app_path" ]] && [[ -L "$bin_dir/$cli_name" ]]; then
                echo "Symlink already exists for $cli_name"
            else
                echo "App not found or executable missing: $app_dir"
            fi
        done

        # Add bin directory to PATH if not already there
        if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
            echo "Would add $bin_dir to PATH"
            log_success "Would add $bin_dir to PATH"
        else
            echo "PATH already contains $bin_dir"
        fi
}

# Run the test
echo "Testing create_app_cli_symlinks function..."
echo "============================================"
create_app_cli_symlinks
