# Developer Environment Setup Script

A comprehensive macOS developer environment setup script that focuses specifically on setting up a complete development workflow using the SBRN (Second Brain) methodology.

## 🎯 Overview

This script automates the complete setup of a macOS development environment, including:

- **SBRN Directory Structure**: Organized project and resource management
- **Package Management**: Homebrew and essential CLI tools
- **Shell Environment**: Zsh with Oh My Zsh, themes, and plugins
- **Development Tools**: IDEs, editors, and programming languages
- **Version Control**: Git, GitHub CLI, and SSH key management
- **Essential Applications**: Development-focused app installations

## 🚀 Features

### ✅ **SBRN (Second Brain) Integration**
- Creates complete PARA methodology directory structure
- Establishes XDG Base Directory compliance
- Sets up organized development workspace

### ✅ **Comprehensive Tool Installation**
- **Package Manager**: Homebrew with Cask support
- **Shell**: Zsh + Oh My Zsh + Powerlevel10k + Essential plugins
- **CLI Tools**: Modern alternatives (bat, eza, ripgrep, fd, etc.)
- **Languages**: Python, Node.js, Java, Go, Rust, Ruby
- **IDEs**: VS Code, IntelliJ IDEA CE, PyCharm CE, Cursor
- **Version Control**: Git, GitHub CLI, SSH key setup

### ✅ **Smart Configuration**
- Automatic symlink creation for command-line IDE access
- Pre-configured VS Code extensions for development
- Shell aliases and environment variables
- XDG directory compliance for clean home directory

### ✅ **Safety & Flexibility**
- **Dry-run mode** for preview without changes
- **Skip GUI apps** option for manual installation preference
- **Idempotent operations** - safe to run multiple times
- **Comprehensive logging** with colored output

## 📋 Usage

### Basic Usage
```bash
# Run the complete setup
./dev-env-setup.sh

# Preview what would be installed (dry-run)
./dev-env-setup.sh --dry-run

# Skip GUI app installations (CLI tools only)
./dev-env-setup.sh --skip-cask-apps

# Combine options
./dev-env-setup.sh --dry-run --skip-cask-apps
```

### Command Line Options
```bash
Options:
  --dry-run, -n           Preview mode - show what would be executed
  --skip-cask-apps, -s    Skip Homebrew Cask installations
  --help, -h              Show help message

Examples:
  ./dev-env-setup.sh                  # Full installation
  ./dev-env-setup.sh -n               # Preview mode
  ./dev-env-setup.sh -s               # Skip GUI apps
  ./dev-env-setup.sh -n -s            # Preview without GUI apps
```

## 🏗️ What Gets Installed

### 📁 **Directory Structure**
```
~/sbrn/                              # SBRN_HOME
├── proj/                           # Projects (PARA methodology)
│   ├── corp/                       # Corporate projects
│   ├── oss/                        # Open source projects
│   ├── learn/                      # Learning projects
│   ├── lab/                        # Lab experiments
│   └── exp/                        # Experimental projects
├── areas/                          # Ongoing responsibilities
│   ├── work/                       # Professional areas
│   ├── personal/                   # Personal areas
│   ├── community/                  # Community involvement
│   └── academic/                   # Academic pursuits
├── res/                            # Resources
│   ├── notes/                      # Note-taking system
│   ├── templates/                  # Reusable templates
│   └── refs/                       # Reference materials
├── arch/                           # Archives
│   ├── proj/                       # Archived projects
│   └── area/                       # Archived areas
└── sys/                            # System configuration
    ├── config/                     # XDG config directory
    ├── local/share/                # XDG data directory
    ├── local/state/                # XDG state directory
    ├── cache/                      # XDG cache directory
    ├── bin/                        # Custom binaries/symlinks
    └── oh-my-zsh/                  # Zsh configuration

~/Applications/                     # User-installable apps
~/Development/                      # Development workspace
├── Tools/                          # Development tools
├── Libraries/                      # Code libraries
└── Workspace/                      # Active projects
```

### 🛠️ **CLI Tools**
| Tool | Purpose | Alternative To |
|------|---------|----------------|
| `bat` | Syntax-highlighted file viewer | `cat` |
| `eza` | Modern file listing | `ls` |
| `ripgrep` (`rg`) | Fast text search | `grep` |
| `fd` | User-friendly file finder | `find` |
| `fzf` | Fuzzy finder | - |
| `htop` | Interactive process viewer | `top` |
| `tree` | Directory tree display | - |
| `jq` | JSON processor | - |
| `tldr` | Simplified man pages | `man` |
| `diff-so-fancy` | Better Git diffs | - |
| `tig` | Text-mode Git browser | - |
| `lazygit` | Simple Git UI | - |
| `httpie` | User-friendly HTTP client | `curl` |

### 💻 **Programming Languages & Runtimes**
- **Python 3.12** + pip + pyenv + poetry + pipenv
- **Node.js** + npm + yarn + nvm
- **Java OpenJDK 17 & 21** + jenv + Maven + Gradle
- **Go** + Go toolchain
- **Rust** + Cargo
- **Ruby** + rbenv

### 🔧 **Development Tools**
- **Git** + GitHub CLI + Git LFS
- **Docker** + Docker Compose
- **Kubernetes** tools (kubectl, helm)
- **Cloud CLIs** (AWS, Azure)
- **Infrastructure** (Terraform, Ansible)

### 📝 **IDEs & Editors**
| Application | Installation Method | Command Access |
|-------------|-------------------|----------------|
| Visual Studio Code | Homebrew Cask | `code` |
| IntelliJ IDEA CE | Homebrew Cask | `idea` |
| PyCharm CE | Homebrew Cask | - |
| Cursor | Homebrew Cask | `cursor` |
| Sublime Text | Homebrew Cask | - |
| Vim/Neovim | Homebrew | `vim`/`nvim` |
| JupyterLab | pip | `jupyter lab` |

### 🔌 **VS Code Extensions**
**AI & Productivity**
- GitHub Copilot + Copilot Chat
- GitLens, Git Graph
- Prettier, ESLint

**Language Support**
- Python + Jupyter + Black + Flake8
- Java Extension Pack + Spring Boot Tools
- TypeScript + Tailwind CSS

**DevOps & Tools**
- Docker + Kubernetes
- Remote SSH
- Markdown All in One

**Themes & UI**
- Material Icon Theme
- GitHub Theme
- Dracula Theme

### 🐚 **Shell Configuration**
- **Zsh** as default shell
- **Oh My Zsh** framework
- **Powerlevel10k** theme with Meslo Nerd Font
- **Essential plugins**:
  - `zsh-autosuggestions` - Command suggestions
  - `zsh-syntax-highlighting` - Real-time syntax highlighting
  - `history-substring-search` - Advanced history search

## 🔧 Configuration Details

### Environment Variables
```bash
# SBRN Configuration
export SBRN_HOME="$HOME/sbrn"
export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"
export XDG_DATA_HOME="$SBRN_HOME/sys/local/share"
export XDG_STATE_HOME="$SBRN_HOME/sys/local/state"
export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"

# Development
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PYTHONPATH="$SBRN_HOME/proj:$PYTHONPATH"
export GOPATH="$SBRN_HOME/sys/local/go"
export EDITOR="code"
export PATH="$SBRN_HOME/sys/bin:$PATH"
```

### Useful Aliases
```bash
# Navigation
alias sbrn="cd $SBRN_HOME"
alias proj="cd $SBRN_HOME/proj"
alias notes="cd $SBRN_HOME/res/notes"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"

# Modern CLI tools
alias ll="eza -la --icons"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Development
alias py="python3"
alias k="kubectl"
alias dc="docker-compose"
```

## 🚦 Installation Steps

The script follows this sequential installation process:

### Step 1: 📁 SBRN Directory Structure
- Creates PARA methodology directories
- Sets up XDG Base Directory compliance
- Establishes development workspace

### Step 2: 🍺 Homebrew Installation
- Installs Homebrew package manager
- Configures PATH for Apple Silicon
- Updates package lists

### Step 3: 🐚 Zsh Environment Setup
- Installs Oh My Zsh to custom directory
- Installs Powerlevel10k theme
- Installs essential Zsh plugins
- Installs Meslo Nerd Font

### Step 4: 🛠️ Essential CLI Tools
- Installs modern CLI alternatives
- Configures Git with diff-so-fancy
- Sets up development utilities

### Step 5: 🔧 Development Tools
- Installs build tools (Maven, Gradle)
- Installs container tools (Docker, Kubernetes)
- Installs cloud CLIs (AWS, Azure)

### Step 6: 💻 Programming Languages
- Installs language runtimes
- Installs version managers
- Configures development environments

### Step 7: 📝 IDEs and Editors
- Installs development IDEs
- Creates command-line symlinks
- Installs JupyterLab

### Step 8: 🔗 Git and GitHub Setup
- Configures Git global settings
- Generates SSH keys
- Sets up GitHub CLI authentication

### Step 9: 🔌 VS Code Extensions
- Installs essential development extensions
- Configures AI assistants
- Sets up language support

### Step 10: ⚙️ Final Configuration
- Creates shell configuration files
- Sets up aliases and functions
- Configures environment variables

## 💡 Dry-Run Mode

Preview what would be installed without making changes:

```bash
$ ./dev-env-setup.sh --dry-run

[INFO] 🔍 DRY-RUN MODE: Showing what would be executed...
[INFO] 💡 This preview shows planned actions without making changes

[STEP] 📁 Setting up SBRN (Second Brain) directory structure...
[DRY-RUN] Would set SBRN_HOME to /Users/username/sbrn
[DRY-RUN] Would create directories: /Users/username/sbrn/proj/{corp,oss,learn,lab,exp}
...

[STEP] 🍺 Installing Homebrew package manager...
[DRY-RUN] Would install Homebrew via:
[DRY-RUN] /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
...

[INFO] 🔍 DRY-RUN SUMMARY:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[DRY-RUN] No actual changes were made to your system
[DRY-RUN] To execute the real installation, run: dev-env-setup.sh
[DRY-RUN] To see this preview again, run: dev-env-setup.sh --dry-run
```

## 🛡️ Safety Features

### Idempotent Operations
- Safe to run multiple times
- Detects existing installations
- Skips already configured items

### User Control
- Confirmation prompts for real installation
- Dry-run mode for preview
- Option to skip GUI applications

### Error Handling
- Comprehensive error checking
- Graceful handling of missing dependencies
- Clear error messages and suggestions

## 🔄 Post-Installation

After running the script:

1. **Restart your terminal** to apply all shell configurations
2. **Configure Git identity** if not already done:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```
3. **Authenticate GitHub CLI**:
   ```bash
   gh auth login
   ```
4. **Add SSH key to GitHub account** (displayed during installation)
5. **Configure Powerlevel10k theme**:
   ```bash
   p10k configure
   ```

## 🎯 Benefits

### 🏗️ **Structured Development**
- Organized project structure following PARA methodology
- Clean separation of active work, resources, and archives
- XDG compliance for clean home directory

### ⚡ **Enhanced Productivity**
- Modern CLI tools with better performance and features
- Comprehensive IDE setup with essential extensions
- Pre-configured aliases and shortcuts

### 🤝 **Team Consistency**
- Standardized development environment
- Reproducible setup across team members
- Version-controlled configuration

### 🔄 **Future-Proof**
- Easy to maintain and update
- Portable across macOS systems
- Well-documented and extensible

## 🆚 Compared to BIOS Script

| Feature | dev-env-setup.sh | bios-for-macos.sh |
|---------|------------------|-------------------|
| **Focus** | Developer environment | System diagnostics + dev setup |
| **Scope** | Development tools only | Complete system initialization |
| **SBRN Integration** | Deep integration | Basic setup |
| **IDE Setup** | Comprehensive | Basic |
| **Shell Config** | Advanced Zsh setup | Basic shell environment |
| **VS Code Extensions** | 20+ curated extensions | None |
| **Programming Languages** | Multiple with version managers | Basic |
| **CLI Tools** | Modern alternatives focus | Essential tools only |
| **Target User** | Developers | System administrators + developers |

## 📋 System Requirements

- **OS**: macOS 10.15+ (Catalina or later)
- **Architecture**: Intel or Apple Silicon
- **Disk Space**: ~5GB for all tools and dependencies
- **Network**: Internet connection for downloads
- **Permissions**: Admin access for some installations (Homebrew, system settings)

---

**Perfect for**: Developers who want a complete, organized, and modern development environment with minimal manual configuration.

**Best practices**: Run in dry-run mode first, then execute the full installation, and finally customize based on your specific needs.
