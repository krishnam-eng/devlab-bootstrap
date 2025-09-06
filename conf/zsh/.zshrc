# To use this customized .zshrc, run the following command to create a symlink:
# ln -sf /Users/balamurugan.k/sbrn/sys/hrt/zshrc ~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#! Initialization code that may require console input must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/sbrn/sys/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Many modern applications partially support the XDG [Cross Desktop Group] Base Directory Specification, which allows configuration, data, and cache files to be stored outside the home directory—usually in subfolders of ~/.config or configurable via environment variables.

# Set base directory for user-specific data files
export XDG_DATA_HOME="$HOME/sbrn/sys/local/share"

# Set base directory for user-specific configuration files
export XDG_CONFIG_HOME="$HOME/sbrn/sys/config"

# Set base directory for user-specific state files
export XDG_STATE_HOME="$HOME/sbrn/sys/local/state"

# Set base directory for user-specific cache files
export XDG_CACHE_HOME="$HOME/sbrn/sys/cache"

# Make sure your directories exist:
# mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

export PATH="$HOME/sbrn/sys/bin:$PATH"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
# 1. Core Shell Experience & Navigation (Highly Recommended)
  zsh-autosuggestions      # Command suggestions based on your history as you type
  zsh-syntax-highlighting  # Real-time syntax highlighting for commands
  history-substring-search # Search history by any substring (more powerful)
  per-directory-history    # Contextual history per directory
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


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. "$HOME/sbrn/sys/local/share/../bin/env"
