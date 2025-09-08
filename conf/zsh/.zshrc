# ============================
# Oh My Zsh & Powerlevel10k Instant Prompt
# ============================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#! Initialization code that may require console input must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$SBRN_HOME/sys/etc/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# =============================
# Zsh History Management
# =============================
# Location and size of history file
HISTFILE=$XDG_STATE_HOME/.zhistfile  # History file location
HISTSIZE=1000000  # Maximum number of history entries in memory
SAVEHIST=1000000  # Maximum number of history entries saved to file

# History behavior options
setopt interactivecomments       # Allow comments in interactive shell
setopt HIST_VERIFY                # Don't execute history expansion immediately
setopt EXTENDED_HISTORY           # Save timestamp and duration for each entry
setopt HIST_IGNORE_ALL_DUPS       # Remove older duplicate commands
setopt HIST_FIND_NO_DUPS          # Don't show duplicates in history search
setopt HIST_REDUCE_BLANKS         # Remove extra spaces/tabs from history
setopt INC_APPEND_HISTORY         # Write history immediately as commands are typed
setopt SHARE_HISTORY              # Share history across all zsh sessions

# =============================
# Advanced Auto-Completion & Navigation
# =============================
# Load auto completion feature
autoload -Uz compinit
compinit -u # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories

# Enable auto complete for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
 # make completion work with kubecolor
 compdef kubecolor=kubectl
fi

# Enable auto complete for helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# To run command completion, you need to run bashcompinit by adding the following autoload line
autoload bashcompinit && bashcompinit

# Enable auto complete for aws cli
if [ $commands[aws] ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

# Enable auto complete and alias for GitHub CLI
if [ $commands[gh] ]; then
  source <(gh completion -s zsh)
  # copilot subcommand will work only after gh login
  # eval "$(gh copilot alias -- zsh)"
fi

# Option stacking for Docker completions
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Group and menu selection for completions
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' verbose yes

# Enable autocd (cd into dir by typing its name)
setopt autocd

# Allow completion in the middle of a word
setopt completeinword

# Suggest mis-spelled commands
setopt correct

# Space triggers history expansion (e.g. echo !!<Space> => echo ls)
bindkey ' ' magic-space

# =============================
# Globbing & Pattern Matching
# =============================
# Do not show "no matches found:..." error
setopt null_glob

# Do not show "no bad pattern" error either
setopt no_bad_pattern

# Make it similar to bash - in case of any nomatch, pattern will be treated as string
unsetopt nomatch

# Enable extended globbing. This enables cool features like recursive searching "**/"
setopt EXTENDED_GLOB

# Bulk rename utility - works based on pattern
autoload -Uz zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run

# =============================
# Shell Behavior & Line Editor
# =============================
# Prevent accidental file overwrites with redirection (use >| to force overwrite)
setopt noclobber

# Enable multiple output streams
setopt multios

# Vim-style navigation in the Zsh terminal (use -e for emacs-style)
bindkey -v

# Disable annoying beeping on errors
setopt NO_BEEP

# =============================
# Zsh Configuration with Community Plugins
# =============================
export ZSH="$SBRN_HOME/sys/etc/oh-my-zsh"

export PATH="$SBRN_HOME/sys/bin:$PATH"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# oh my zsh plugins
plugins=(
# 1. Core Shell Experience & Navigation (Highly Recommended)
  zsh-autosuggestions      # Command suggestions based on your history as you type
  zsh-syntax-highlighting  # Real-time syntax highlighting for commands
  history-substring-search # Search history by any substring (more powerful)
  per-directory-history    # Contextual history per directory - Disabled due to conflict with custom HISTFILE
  last-working-dir         # Start shell in last directory you worked in
  sudo                     # Rerun last command with sudo quickly
  extract                  # Universal extractor for archives
  eza                      # Modern colorful alternative to ls

# 2. Git & Version Control (Essential for Developers)
  git                      # Core git commands and helpers
  gh                       # GitHub CLI integration
  git-auto-fetch           # Automatic background fetch of remotes
  git-lfs                  # Git Large File Storage support

# 3. Development Environments & Language Managers

#   ## Python (Most common python tools)
  pylint                   # Python linter
  autopep8                 # Automatic code formatting
  pip                      # Pip package manager wrapper - if you mostly use uv or conda environment package management interfaces, this may be less useful but can keep for convenience.
  pipenv                   # Python Pipenv environment manager
  conda                    # Conda environment management
  conda-env                # Conda env helpers
  pyenv                    # Python version management - flexible Python version management independent of conda or uv’s Python versions
  poetry                   # Modern Python packaging & dependency management - Useful if you use Poetry for packaging and dependencies; if uv handles all these well for you, this might be redundant but can keep it if you specifically use Poetry.
  # virtualenvwrapper        # Manage virtualenvs efficiently - Since uv automates virtualenv management better and conda handles environments itself, you likely do not need this and can keep it disabled to avoid conflict or redundancy.

#   ## Java, Go, Rust, Flutter
  jenv                     # Java version manager
  mvn                      # Maven Java build tool
  gradle                   # Gradle build tool helpers
  spring                   # Spring Java framework helpers  
  golang                   # Go language helpers
  rust                     # Rust environment helpers
  flutter                  # Flutter development helpers

#   ## Node.js / JavaScript
  nvm                      # Node Version Manager for switching Node versions
  npm                      # Node package manager interface
  nodenv                   # Node.js version management

# 4. Cloud, Containers & DevOps (Critical for devops & cloud users)
  docker                   # Docker CLI enhancements
  docker-compose           # Docker Compose helpers
  kubectl                  # Kubernetes CLI helper
  helm                     # Kubernetes Helm package manager
  aws                      # AWS CLI helpers
  azure                    # Azure CLI helpers
  vagrant                  # Vagrant environment helpers
  minikube                 # Local Kubernetes cluster helper
  kubectx                  # Kubernetes context switching
  kube-ps1                 # Shows Kubernetes context in prompt
  svcat                    # Kubernetes service catalog helpers
  operator-sdk             # Operator SDK CLI tools

# 5. System & OS Utilities (Important for productivity)
  gnu-utils                # Provides GNU versions of common cli utilities on macOS, which typically come with BSD versions by default. GNU utils offer more features and options, helping make macOS terminal commands behave more like Linux
  macos                    # macOS-specific fixes and helpers: Contains macOS-specific fixes, shortcuts, and helper functions to improve the terminal experience tailored to macOS quirks and features
  brew                     # Homebrew package manager helper: Adds shortcuts and helper aliases for Homebrew, the popular macOS package manager, making it easier to install, update, and manage packages from the terminal
  iterm2                   # iTerm 2 integration helpers: Integrates with the iTerm2 terminal emulator on macOS to provide enhanced features like reporting the current directory, better paste behavior, and other usability improvements
  tmux                     # Terminal multiplexer helpers: Provides helper functions and aliases to manage tmux sessions, windows, and panes, useful if you use tmux for terminal multiplexing 
  ssh                      # SSH helpers & shortcuts: Adds useful SSH-related aliases and shortcuts to simplify connecting to and managing SSH sessions 
  # ssh-agent                # Manages SSH keys easily - Creates console output-> Starting ssh-agent ...

# 6. General Utilities & Tools (Useful daily helpers)
  autoenv                  # Loads environment variables automatically
  dotenv                   # Load .env files into environment
  colorize                 # Colorizes command output
  command-not-found        # Suggests install commands for unknown commands
  httpie                   # HTTP client helpers
  jsontools                # JSON processing utilities
  qrcode                   # Generate QR codes in terminal
  rsync                    # Rsync helpers for syncing
  urltools                 # URL manipulation tools
  encode64                 # Base64 encoding/decoding tools
  copypath                 # Copy file paths helper
  copyfile                 # Copy files helper
  invoke                   # Task execution helpers
  isodate                  # ISO date helpers

# 7. Aliases & Productivity Enhancers
  aliases                  # A collection of useful aliases
  common-aliases           # Common alias shortcuts
  alias-finder             # Find existing aliases easily
  globalias                # Enable global aliases

# 8. Manual Pages & Help
  colored-man-pages        # Colorize man pages for readability
  man                      # Enhanced man command features
  tldr                     # Simplified man pages with examples
  fastfile                 # Fastlane fastfile helpers

# 9. Directory Jumping & Navigation (Pick 1-2 from this group)
  z                        # Fast directory jumping by frecency
  fasd                     # Jump to files and dirs by usage frequency
#   wd                       # Jump to recent directories
#   jump                     # Jump to dirs by partial names
#   scd                      # Smart cd with autosuggestions
#   dirhistory               # Manage navigation history
  
# 10. Optional / Less Common (Add as needed)
# postgres                 # PostgreSQL helpers
# redis-cli                # Redis CLI helper
# dbt                      # Data Build Tool helpers
# istioctl                 # Istio CLI helpers for service mesh
# argocd                   # ArgoCD CLI helpers
# screen                   # Screen terminal multiplexer support
# jfrog                    # JFrog CLI tools
# textmate                 # TextMate editor integration
# themes                   # Zsh theme helpers
# jira                     # Jira CLI helpers
)

# Alias-finder plugin settings (optional, uncomment to customize)
zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# =============================
# Load Custom RC Files
# =============================
# Load all .zsh files from the rc.d directory
if [[ -d "$ZDOTDIR/rc.d" ]]; then
  for rc_file in "$ZDOTDIR/rc.d"/*.zsh; do
    if [[ -r "$rc_file" ]]; then
      source "$rc_file"
    fi
  done
  unset rc_file
fi

# =============================
# Version Managers & Tools
# =============================

# NVM (Node Version Manager) - Homebrew installation
# Note: Managing nvm via Homebrew is unsupported by upstream nvm
# Proper configuration to avoid destruction of node installations during upgrades
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  # Create NVM working directory if it doesn't exist
  [[ ! -d "$NVM_DIR" ]] && mkdir -p "$NVM_DIR"
  
  # Load nvm
  source "/opt/homebrew/opt/nvm/nvm.sh"
  
  # Load nvm bash completion
  [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

# Jenv (Java Environment Manager) - XDG-compliant configuration
if command -v jenv >/dev/null 2>&1; then
  # Ensure jenv uses XDG data directory
  export JENV_ROOT="$XDG_DATA_HOME/jenv"
  eval "$(jenv init -)"
fi

# =============================
# Finalize Oh My Zsh Setup
# =============================
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source $ZSH/oh-my-zsh.sh
else
    echo "⚠️  Oh My Zsh not found at: $ZSH/oh-my-zsh.sh"
    echo "📋 To install Oh My Zsh and complete your development environment setup:"
    echo "   cd $SBRN_HOME/sys/hrt && ./provision-devlab-env.sh"
    echo ""
fi

# =============================
# Powerlevel10k Configuration
# =============================
# To customize prompt, run `p10k configure` or edit $XDG_CONFIG_HOME/p10k.zsh.
[[ ! -f $XDG_CONFIG_HOME/p10k/p10k.zsh ]] || source $XDG_CONFIG_HOME/p10k/p10k.zsh
