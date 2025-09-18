#!/usr/bin/env zsh
# Git workspace management function
# ==========================================================================
# USAGE GUIDE
# ==========================================================================
#
# Available Functions:
#
# 1. update-project-repos (alias: upr)
#    Usage: update-project-repos
#    Purpose: Updates all git repositories in ~/sbrn/proj/, ~/sbrn/proj/workshop/*, and ~/sbrn/sys/
#    Example: update-project-repos
#    Alias: upr
#
# 2. create-quick-pull-request (alias: qpr)
#    Usage: create-quick-pull-request "PR Title" "PR Body"
#    Purpose: Fast PR creation with title and body
#    Example: create-quick-pull-request "Fix auth bug" "Resolves login validation issue"
#    Alias: qpr
#
# 3. create-smart-pull-request (alias: smartpr, spr)
#    Usage: create-smart-pull-request "PR Title"
#    Purpose: Creates PR with auto-generated body from commits + checklists
#    Example: create-smart-pull-request "Implement user dashboard"
#    Aliases: smartpr, spr
#
# 4. create-interactive-pull-request (alias: ipr)
#    Usage: create-interactive-pull-request
#    Purpose: Interactive prompts for careful PR creation
#    Example: create-interactive-pull-request (then follow prompts)
#    Alias: ipr
#
# =============================================================================

# update-project-repos - Update all git repos in ~/sbrn/proj/, ~/sbrn/proj/workshop/*, and ~/sbrn/sys/
# Usage: update-project-repos
# Alias: upr
update-project-repos() {
    local main_proj=~/sbrn/proj
    local sys_dir=~/sbrn/sys
    local repo
    local subdir
    local all_repos=()
    local repo_count=0
    local success_count=0
    local failed_repos=()

    echo "🔍 Scanning for git repositories..."
    echo

    # Collect all repos recursively under ~/sbrn/proj/ (excluding workshop for now)
    for repo in $main_proj/**/.git(N); do
        repo_dir="${repo%/.git}"
        # Skip workshop directory as we handle it separately
        if [[ "$repo_dir" != *"/workshop/"* ]]; then
            all_repos+=("$repo_dir")
            ((repo_count++))
        fi
    done

    # For ~/sbrn/proj/workshop/, update repos one level deeper
    for subdir in $main_proj/workshop/*; do
        if [[ -d "$subdir/.git" ]]; then
            echo "� Updating $subdir"
            (cd "$subdir" && git pull --ff-only)
        fi
    done

    # Collect all repos recursively under ~/sbrn/sys/
    for repo in $sys_dir/**/.git(N); do
        repo_dir="${repo%/.git}"
        all_repos+=("$repo_dir")
        ((repo_count++))
    done

    # Display all identified repositories
    if [[ $repo_count -eq 0 ]]; then
        echo "⚠️  No git repositories found in specified directories"
        return 0
    fi

    echo "📊 Found $repo_count git repositories:"
    for repo_path in "${all_repos[@]}"; do
        echo "   📁 $repo_path"
    done
    echo

    echo "🔄 Starting updates..."
    echo

    # Update all collected repositories
    local current_num=0
    for repo_path in "${all_repos[@]}"; do
        ((current_num++))
        repo_name="$(basename "$repo_path")"
        
        echo "[$current_num/$repo_count] 📁 Updating: $repo_name"
        echo "   Path: $repo_path"
        
        if (cd "$repo_path" && git pull --ff-only 2>/dev/null); then
            echo "   ✅ Successfully updated"
            ((success_count++))
        else
            echo "   ❌ Update failed (conflicts, uncommitted changes, or network issues)"
            failed_repos+=("$repo_name")
        fi
        echo
    done

    # Summary
    echo "📊 Update Summary:"
    echo "   Total repositories: $repo_count"
    echo "   Successfully updated: $success_count"
    echo "   Failed: $((repo_count - success_count))"
    
    if [[ ${#failed_repos[@]} -gt 0 ]]; then
        echo
        echo "❌ Failed repositories:"
        for failed in "${failed_repos[@]}"; do
            echo "   • $failed"
        done
    else
        echo "   🎉 All repositories updated successfully!"
    fi
}

alias glA='update-project-repos'

# create-quick-pull-request - Quick GitHub PR Creation
# Creates a GitHub pull request with current branch as head and master as base
# Usage: create-quick-pull-request "PR Title" "PR Body"
#   title: Title for the pull request
#   body: Body/description for the pull request
# Example: create-quick-pull-request "Fix user authentication bug" "Resolves issue with login validation"
# Alias: qpr
create-quick-pull-request() {
    local title="$1"
    local body="$2"
    
    # Check if gh CLI is installed
    if ! command -v gh >/dev/null 2>&1; then
        echo "❌ Error: GitHub CLI (gh) is not installed"
        echo "   Install with: brew install gh"
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "❌ Error: Not in a git repository"
        return 1
    fi
    
    # Check if user provided both title and body
    if [[ -z "$title" || -z "$body" ]]; then
        echo "❌ Error: Both title and body are required"
        echo "Usage: create-quick-pull-request \"PR Title\" \"PR Body\""
        echo "Example: create-quick-pull-request \"Fix user auth\" \"Resolves login validation issue\""
        return 1
    fi
    
    # Get current branch
    local current_branch
    current_branch="$(git branch --show-current 2>/dev/null)"
    
    if [[ -z "$current_branch" ]]; then
        echo "❌ Error: Cannot determine current branch (detached HEAD?)"
        return 1
    fi
    
    # Check if current branch is master (prevent creating PR from master to master)
    if [[ "$current_branch" == "master" ]]; then
        echo "❌ Error: Cannot create PR from master branch to master"
        echo "   Please switch to a feature branch first"
        return 1
    fi
    
    echo "🚀 Creating PR from '$current_branch' to 'master'..."
    echo "   Title: $title"
    echo "   Body: $body"
    echo
    
    # Create the PR
    if gh pr create --base master --head "$current_branch" --title "$title" --body "$body"; then
        echo "✅ Pull request created successfully!"
    else
        echo "❌ Failed to create pull request"
        echo "   Make sure you're authenticated with GitHub (gh auth login)"
        echo "   and that you have push access to the repository"
        return 1
    fi
}

# Alias for create-quick-pull-request
alias qpr='create-quick-pull-request'

# create-smart-pull-request - Smart GitHub PR Creation with Auto-generated Body
# Creates a GitHub pull request with auto-generated body from recent commits
# Usage: create-smart-pull-request "PR Title"
#   title: Title for the pull request (body auto-generated from commits)
# Example: create-smart-pull-request "Fix user authentication bug"
# Aliases: smartpr, spr
create-smart-pull-request() {
    local title="$1"
    
    # Check if gh CLI is installed
    if ! command -v gh >/dev/null 2>&1; then
        echo "❌ Error: GitHub CLI (gh) is not installed"
        echo "   Install with: brew install gh"
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "❌ Error: Not in a git repository"
        return 1
    fi
    
    # Check if user provided title
    if [[ -z "$title" ]]; then
        echo "❌ Error: PR title is required"
        echo "Usage: create-smart-pull-request \"PR Title\""
        echo "Example: create-smart-pull-request \"Fix user authentication bug\""
        return 1
    fi
    
    # Get current branch
    local current_branch
    current_branch="$(git branch --show-current 2>/dev/null)"
    
    if [[ -z "$current_branch" ]]; then
        echo "❌ Error: Cannot determine current branch (detached HEAD?)"
        return 1
    fi
    
    # Check if current branch is master
    if [[ "$current_branch" == "master" ]]; then
        echo "❌ Error: Cannot create PR from master branch to master"
        echo "   Please switch to a feature branch first"
        return 1
    fi
    
    # Generate body from commits
    local commits
    commits=$(git log master..HEAD --oneline --pretty=format:"- %s" 2>/dev/null)
    
    if [[ -z "$commits" ]]; then
        echo "⚠️  Warning: No commits found between master and current branch"
        commits="- No commits found"
    fi
    
    local body="## Changes
$commits

## Testing
- [ ] Manual testing completed
- [ ] Unit tests pass
- [ ] Integration tests pass

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated if needed"
    
    echo "🚀 Creating smart PR from '$current_branch' to 'master'..."
    echo "   Title: $title"
    echo "   Auto-generated body with $(echo "$commits" | wc -l | tr -d ' ') commits"
    echo
    
    # Create the PR
    if gh pr create --base master --head "$current_branch" --title "$title" --body "$body"; then
        echo "✅ Smart pull request created successfully!"
    else
        echo "❌ Failed to create pull request"
        echo "   Make sure you're authenticated with GitHub (gh auth login)"
        echo "   and that you have push access to the repository"
        return 1
    fi
}

# Aliases for create-smart-pull-request
alias smartpr='create-smart-pull-request'
alias spr='create-smart-pull-request'

# create-interactive-pull-request - Interactive GitHub PR Creation
# Creates a GitHub pull request with interactive prompts for title and body
# Usage: create-interactive-pull-request
# Example: create-interactive-pull-request (then follow prompts)
# Alias: ipr
create-interactive-pull-request() {
    # Check if gh CLI is installed
    if ! command -v gh >/dev/null 2>&1; then
        echo "❌ Error: GitHub CLI (gh) is not installed"
        echo "   Install with: brew install gh"
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "❌ Error: Not in a git repository"
        return 1
    fi
    
    # Get current branch
    local current_branch
    current_branch="$(git branch --show-current 2>/dev/null)"
    
    if [[ -z "$current_branch" ]]; then
        echo "❌ Error: Cannot determine current branch (detached HEAD?)"
        return 1
    fi
    
    # Check if current branch is master
    if [[ "$current_branch" == "master" ]]; then
        echo "❌ Error: Cannot create PR from master branch to master"
        echo "   Please switch to a feature branch first"
        return 1
    fi
    
    echo "🎯 Interactive PR Creation"
    echo "Branch: $current_branch → master"
    echo
    
    # Get title
    echo "Enter PR title:"
    read -r title
    
    if [[ -z "$title" ]]; then
        echo "❌ Error: Title cannot be empty"
        return 1
    fi
    
    # Get body
    echo
    echo "Enter PR description (press Enter twice when done):"
    local body=""
    local line
    local empty_line_count=0
    
    while IFS= read -r line; do
        if [[ -z "$line" ]]; then
            ((empty_line_count++))
            if [[ $empty_line_count -ge 2 ]]; then
                break
            fi
            body+=$'\n'
        else
            empty_line_count=0
            if [[ -n "$body" ]]; then
                body+=$'\n'
            fi
            body+="$line"
        fi
    done
    
    if [[ -z "$body" ]]; then
        echo "⚠️  Warning: Creating PR with empty body"
        body="No description provided"
    fi
    
    echo
    echo "🚀 Creating PR from '$current_branch' to 'master'..."
    echo "   Title: $title"
    echo "   Body: $(echo "$body" | head -1)..."
    echo
    
    # Create the PR
    if gh pr create --base master --head "$current_branch" --title "$title" --body "$body"; then
        echo "✅ Interactive pull request created successfully!"
    else
        echo "❌ Failed to create pull request"
        echo "   Make sure you're authenticated with GitHub (gh auth login)"
        echo "   and that you have push access to the repository"
        return 1
    fi
}

# Alias for create-interactive-pull-request
alias ipr='create-interactive-pull-request'

# Future git functions can be added here following the same pattern
# Example: create-git-status-report, check-repository-health, etc.