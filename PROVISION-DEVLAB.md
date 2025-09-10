# PROVISION-DEVLAB.md

## Portable Replicatable Scalable Developer Laboratory Setup for macOS

**Author:** Balamurugan Krishnamoorthy

> **📖 Complete Documentation:** This is the authoritative documentation for `provision-devlab.sh`. The script references this file for detailed explanations of all features, industry standards, and implementation details.

This script sets up a complete macOS development environment based on industry-tested standards for effortless productivity.

## Philosophy

### Leverage Industry-Tested Standards for Effortless Productivity

This setup harnesses well-established principles, standards, and specifications that have been battle-tested across industries and proven effective for millions of developers and knowledge workers daily. By adopting these acclaimed standards (PARA, XDG, DAM, FHS), we eliminate the complexity of reinventing organizational systems and instead build upon decades of refinement.

The result is a development environment that transforms file organization, tool management, and workflow efficiency from conscious decisions into second nature—automating good practices by design, reducing cognitive overhead, and creating muscle memory for peak productivity.

### Key Benefits

- **Portability:** Environment replicates identically across machines
- **Scalability:** Handles simple scripts to complex enterprise projects  
- **Maintainability:** Industry standards ensure long-term compatibility
- **Speed:** Reduces setup time from days to minutes
- **Consistency:** Eliminates configuration drift and "works on my machine" issues

## Quick Start

```bash
# Clone the repository
git clone https://github.com/krishnam-eng/sbrn-sys-hrt.git ~/sbrn/sys/hrt

# Run the setup script
cd ~/sbrn/sys/hrt
chmod +x provision-devlab.sh
./provision-devlab.sh
```

### Command Line Options

```bash
# Full interactive setup
./provision-devlab.sh

# Fully automated setup (no prompts)
./provision-devlab.sh --yes

# Skip GUI app installations (CLI tools only)
./provision-devlab.sh --skip-cask-apps

# Skip iTerm2 setup (avoid interactive prompts)
./provision-devlab.sh --skip-iterm-setup

# Check current system status
./provision-devlab.sh --status

# Show help
./provision-devlab.sh --help
```

## What This Script Does

The provision-devlab.sh script creates a comprehensive macOS development environment through these steps:

### Prerequisites

**🍺 Package Manager** - Installs and configures Homebrew for macOS package management (required for all subsequent installations)

### Main Setup Steps (7 Steps)

1. **📁 Directory Structure** - Creates SBRN (Second Brain) organization using PARA, XDG, DAM, and FHS standards
2. **🐚 Shell Environment** - Sets up Zsh with Oh My Zsh, Powerlevel10k theme, and essential plugins
3. **🛠️ CLI Tools** - Installs 40+ productivity command-line tools (shell, network, text processing)
4. **🔧 Development Tools** - Installs Git, Docker, Kubernetes, cloud tools, and API development utilities
5. **💻 Programming Languages** - Installs Java, Python, Node.js, Go, Rust with version managers and build tools
6. **📝 IDEs & Editors** - Installs VS Code, IntelliJ, PyCharm, Cursor, and productivity apps like Notion, Figma
7. **🤖 AI Development** - Sets up local LLMs (Ollama), AI frameworks (LangChain, CrewAI), and vector databases

---

### Prerequisite: 🍺 Homebrew Package Manager Installation

Installs and configures Homebrew, the essential package manager for macOS that enables all subsequent tool installations.

- **Homebrew**: The missing package manager for macOS (or Linux)
- Configures Apple Silicon support for M1/M2 Macs
- Updates package database to latest versions
- **Requirement**: This must be installed first as all other tools depend on it

### 1. 📁 SBRN Directory Structure Setup

Creates a scalable, portable directory structure following **PARA (Projects, Areas, Resources, Archives)**, **XDG Base Directory Specification**, **DAM (Digital Asset Management)**, and **FHS (Filesystem Hierarchy Standard)** principles.

#### Core Principle: Leveraging Industry-Tested Standards

Harness well-established principles, standards, and specifications that have been battle-tested across industries and proven effective for millions of users daily. By adopting these acclaimed standards (PARA, XDG, DAM, FHS), we eliminate the complexity of reinventing organizational systems and instead build upon decades of refinement.

This approach transforms file organization from a conscious decision into second nature—automating good practices by design, reducing cognitive overhead, and creating muscle memory for efficiency. The Home directory becomes a clean, purposeful space containing only system defaults plus dedicated management directories (Drives, sbrn), while complex configurations and personal projects flow naturally into their designated hierarchies.

**The result:** Speed, time savings, and mental clarity through systematic automation rather than ad-hoc complexity. These principles become unconscious habits that compound productivity gains over time.

#### Industry Standards Implemented

**PARA Principle** *(Created 2017 by Tiago Forte)*

- **Problem Solved:** Information overload and scattered digital assets causing wasted time (average knowledge worker spends 26% of day looking for information, 76 hours/year on misplaced files)
- **Core Principle:** Organize by actionability, not subject - Projects (most actionable), Areas (ongoing responsibilities), Resources (future reference), Archives (inactive items)
- **Origin:** Created during Forte's consulting work to manage knowledge efficiently in fast-paced environments

**DAM Principle** *(Evolved from 1990s-2000s digital asset management)*

- **Problem Solved:** Organizations losing track of digital assets, version confusion, inconsistent branding, and duplicated creative work causing millions in wasted resources
- **Core Principle:** Centralized storage with metadata, version control, search capabilities, and access permissions for all digital media and creative assets
- **Origin:** Developed as businesses transitioned from analog to digital workflows

**XDG Principle** *(Created August 10, 2003 by freedesktop.org)*

- **Problem Solved:** Messy home directories cluttered with dotfiles (.config, .cache, .local) scattered inconsistently across UNIX-like systems, making user environments unmanageable
- **Core Principle:** Define standardized base directories for config, cache, data, state, and runtime files, ensuring clean separation and cross-application consistency
- **Origin:** Created to bring order to desktop Linux environments during the desktop wars era

**FHS Principle** *(Created February 14, 1994 as FSSTND, renamed FHS 1997)*

- **Problem Solved:** Inconsistent filesystem layouts across UNIX variants causing compatibility issues, software installation problems, and system administration complexity
- **Core Principle:** Standardize directory hierarchy (/bin, /etc, /usr, /var, /opt) ensuring predictable file locations, read-only system partitions, and cross-distribution compatibility
- **Origin:** Created during early Linux distribution fragmentation to establish universal standards

#### Target Persona

Knowledge workers, researchers, developers, creatives, consultants, and digital professionals managing complex information workflows who require organized, searchable, and portable systems. Organizations report 1.5 workdays monthly saved from improved information retrieval.

#### Industry Adoption and Tool Support

- **PARA:** Supported by Notion, Obsidian, Logseq, Roam Research, implemented at World Bank, Genentech, Sunrun
- **DAM:** Market leaders include Adobe Experience Manager, Bynder, Canto, with 88% cloud adoption rate
- **XDG:** Native support in all major Linux distributions, libraries for Python, C++, Haskell, Qt
- **FHS:** Universal standard ensuring cross-platform compatibility and long-term maintainability

This hybrid approach provides enterprise-grade organization with personal workflow flexibility.

**Directory Structure Created:**

```text
~/sbrn/                           # Second Brain home directory
├── proj/                         # Projects (PARA)
│   ├── corp/                     # Corporate projects
│   ├── oss/                      # Open source projects
│   ├── learn/                    # Learning projects
│   ├── lab/                      # Laboratory experiments
│   └── exp/                      # Experimental projects
├── area/                         # Areas (PARA)
│   ├── work/                     # Work responsibilities
│   ├── personal/                 # Personal responsibilities
│   ├── community/                # Community involvement
│   └── academic/                 # Academic pursuits
├── rsrc/                         # Resources (PARA)
│   ├── notes/                    # Reference notes
│   ├── templates/                # Document templates
│   └── refs/                     # Reference materials
├── arch/                         # Archives (PARA)
│   ├── proj/                     # Archived projects
│   └── area/                     # Archived areas
└── sys/                          # System configuration (XDG)
    ├── config/                   # XDG_CONFIG_HOME
    ├── local/share/              # XDG_DATA_HOME
    ├── local/state/              # XDG_STATE_HOME
    ├── cache/                    # XDG_CACHE_HOME
    ├── bin/                      # Custom executables
    ├── etc/                      # System configurations
    └── hrt/                      # Home Runtime Tools repository

~/Drives/                         # Cloud storage mount points
├── iCloud/
├── GoogleDrive/
├── OneDrive/
└── Dropbox/
```

### 2. 🐚 Zsh Environment Setup

Sets up a powerful, customized Zsh environment with Oh My Zsh and essential plugins.

**Components Installed and Configured:**

- **Oh My Zsh**: Framework for managing Zsh configuration
- **Powerlevel10k**: Fast, flexible Zsh theme with customizable prompt
- **Meslo Nerd Font**: Font with programming ligatures and icons
- **zsh-autosuggestions**: Fish-like autosuggestions for Zsh
- **zsh-syntax-highlighting**: Real-time syntax highlighting for commands
- **history-substring-search**: Better history search with substring matching
- **zsh-autoswitch-virtualenv**: Automatic Python virtual environment switching

### 3. 🛠️ Essential CLI Tools Installation

Installs productivity-enhancing command-line tools organized by category.

#### 🖥️ Shell Enhancements & CLI Productivity

- **coreutils**: GNU core utilities with g- prefix for macOS
- **tree**: Directory tree visualization tool
- **fzf**: Command-line fuzzy finder for files, history, processes
- **tmux**: Terminal multiplexer for session management
- **screen**: Terminal multiplexer with VT100/ANSI terminal emulation
- **htop**: Interactive process viewer and system monitor
- **bat**: Cat clone with syntax highlighting and Git integration
- **fd**: Fast alternative to find with intuitive syntax
- **tldr**: Simplified man pages with practical examples
- **eza**: Modern ls replacement with colors and icons
- **zoxide**: Smarter cd command that learns your habits
- **watch**: Execute programs periodically and display output
- **ncdu**: NCurses disk usage analyzer
- **glances**: Cross-platform system monitoring tool
- **lsd**: LSDeluxe - next generation ls command
- **ctop**: Top-like interface for container metrics
- **autoenv**: Directory-based environment activation
- **atuin**: Improved shell history for zsh, bash, fish
- **direnv**: Load/unload environment variables based on PWD
- **ack**: Search tool like grep, optimized for programmers
- **broot**: New way to see and navigate directory trees
- **figlet**: Banner-like program that prints strings as ASCII art
- **lolcat**: Rainbows and unicorns in your console
- **ranger**: Console file manager with VI key bindings
- **as-tree**: Print a list of paths as a tree of paths
- **agedu**: Unix utility for tracking down wasted disk space
- **starship**: Minimal, blazing-fast, and customizable prompt

#### 🌐 Networking, Security, & Transfer Tools

- **curl**: Command-line tool for transferring data with URL syntax
- **wget**: Internet file retriever with recursive download support
- **httpie**: User-friendly command-line HTTP client
- **netcat**: Networking utility for reading/writing network connections
- **gnupg**: GNU Pretty Good Privacy (PGP) package for encryption
- **certbot**: Tool to obtain certificates from Let's Encrypt
- **telnet**: User interface to the TELNET protocol

#### 📊 Text, Regex, JSON, Data Tools

- **vim**: Vi IMproved - enhanced version of the vi editor
- **neovim**: Ambitious Vim-fork focused on extensibility and agility
- **emacs**: GNU Emacs text editor with extensive customization
- **nano**: Free GNU replacement for the Pico text editor
- **jq**: Lightweight and flexible command-line JSON processor
- **ripgrep**: Fast text search tool with smart defaults
- **grep**: GNU grep, egrep and fgrep with color support
- **fx**: Terminal JSON viewer with interactive browsing
- **jid**: JSON incremental digger for exploring JSON data
- **colordiff**: Color-highlighted diff output for better readability
- **base64**: Encode and decode base64 files
- **base91**: Utility to encode and decode base91 files
- **python-yq**: Command-line YAML and XML processor wrapping jq
- **ccat**: Cat clone with syntax highlighting

### 4. 🔧 Development Tools Installation

Comprehensive development tools covering version control, cloud, containers, and APIs.

#### 🔧 Developer Tools (VCS, Repos, Git Helpers)

- **git**: Distributed revision control system
- **git-extras**: Small git utilities for common workflows
- **git-lfs**: Git extension for versioning large files
- **gh**: GitHub command-line tool for repository management
- **ghq**: Remote repository management tool
- **diff-so-fancy**: Good-looking diffs with diff-highlight
- **delta**: Syntax-highlighting pager for git and diff output
- **tig**: Text-mode interface for git with ncurses
- **lazygit**: Simple terminal UI for git commands
- **git-gui**: Tcl/Tk based graphical user interface to Git
- **gitk**: Git repository browser with graphical interface
- **gibo**: Fast access to .gitignore boilerplates

#### ☁️ Cloud & Containers

- **docker**: Platform for developing, shipping, and running applications
- **docker-compose**: Tool for defining multi-container Docker applications
- **colima**: Container runtimes on macOS with minimal setup
- **kubernetes-cli**: Kubernetes command-line interface (kubectl)
- **helm**: Kubernetes package manager for deploying applications
- **awscli**: Official Amazon AWS command-line interface
- **dive**: Tool for exploring Docker image layers
- **dockviz**: Visualizing Docker data and relationships
- **k9s**: Kubernetes CLI to manage clusters in style
- **kubecolor**: Colorize kubectl output for better readability
- **kompose**: Tool to move from docker-compose to Kubernetes
- **krew**: Package manager for kubectl plugins
- **kube-ps1**: Kubernetes prompt info for bash and zsh
- **kubebuilder**: SDK for building Kubernetes APIs using CRDs
- **kustomize**: Template-free customization of Kubernetes YAML
- **istioctl**: Istio configuration command-line utility
- **minikube**: Run a Kubernetes cluster locally
- **terraform**: Tool to build, change, and version infrastructure
- **pulumi**: Modern infrastructure as code platform
- **railway**: Deploy and manage applications on Railway
- **vercel-cli**: Command-line interface for Vercel platform

#### 🎨 Graphics, OCR, and UI Libraries

- **librsvg**: Library to render SVG files using Cairo
- **gtk+3**: Toolkit for creating graphical user interfaces
- **ghostscript**: Interpreter for PostScript and PDF files
- **graphviz**: Graph visualization software from AT&T
- **guile**: GNU Ubiquitous Intelligent Language for Extensions
- **pcre**: Perl Compatible Regular Expressions library
- **xerces-c**: Validating XML parser written in C++
- **pygobject3**: GNOME Python bindings based on GObject Introspection

#### 🛠️ Additional Development & API Tools

- **jwt-cli**: Super fast CLI tool to decode and encode JWTs
- **newman**: Command-line collection runner for Postman
- **openapi-generator**: Generate clients, server & docs from OpenAPI
- **operator-sdk**: SDK for building Kubernetes applications
- **hugo**: Fast and flexible static site generator
- **logrotate**: Rotates, compresses, and mails system logs
- **rtmpdump**: Tool for downloading RTMP streaming media
- **sftpgo**: Fully featured SFTP server with multiple protocols
- **etcd**: Distributed key-value store for shared configuration
- **postgresql@15**: Object-relational database system
- **redis**: In-memory data structure store and message broker
- **nginx**: HTTP server, reverse proxy, and mail proxy server

### 5. 💻 Programming Languages & Runtimes Installation

Essential programming languages, version managers, and build tools.

#### Core Programming Languages & Runtimes

- **openjdk@17**: Java Platform, Standard Edition v17 (LTS)
- **openjdk@21**: Java Platform, Standard Edition v21 (LTS)
- **python@3.13**: Python 3.13 programming language
- **perl**: Highly capable, feature-rich programming language
- **node**: JavaScript runtime built on Chrome's V8 engine
- **go**: Open source programming language from Google
- **rust**: Systems programming language focused on safety and performance

#### Version Managers

- **jenv**: Java version management with XDG compliance
- **uv**: Fast Python package installer and resolver
- **nvm**: Node Version Manager with XDG-compliant configuration

#### Package & Build Tools

- **maven**: Java-based project management and build tool
- **gradle**: Build automation tool for multi-language development
- **poetry**: Python dependency management and packaging tool
- **pipx**: Install and run Python applications in isolated environments
- **yarn**: Fast, reliable, and secure dependency management for JavaScript

### 6. 📝 IDEs and Editors Installation

Modern development environments and productivity applications.

#### Core IDEs and Editors

- **Visual Studio Code**: Lightweight but powerful source code editor
- **IntelliJ IDEA CE**: Community edition of the leading Java IDE
- **PyCharm CE**: Community edition Python IDE from JetBrains
- **Cursor**: AI-native code editor with advanced AI features
- **iTerm2**: Terminal emulator for macOS with advanced features

#### Productivity and Development Support Apps

- **Notion**: All-in-one workspace for notes, tasks, wikis, and databases
- **Obsidian**: Knowledge management app with linked note-taking
- **Figma**: Collaborative interface design tool in the browser
- **Slack**: Team communication and collaboration platform
- **GitHub Desktop**: GUI application for managing Git and GitHub
- **Postman**: API development and testing platform
- **Insomnia**: REST API client for testing and debugging APIs
- **DBeaver Community**: Universal database tool for developers
- **pgAdmin 4**: PostgreSQL administration and development platform
- **RapidAPI**: API testing and development platform

#### Development Environment for Data Science

- **JupyterLab**: Web-based interactive development environment
- **Jupyter Notebook**: Original web application for creating notebooks
- **pipx**: Manages Python applications in isolated environments with XDG compliance

### 7. 🤖 Agentic AI Development Environment Setup

Comprehensive AI and machine learning development stack.

#### AI/ML Core Tools & Frameworks

- **ollama**: Local LLM deployment with XDG-compliant model storage
- **huggingface-cli**: Command-line interface for Hugging Face Hub
- **duckdb**: Fast in-process analytical database
- **datasette**: Tool for exploring and publishing data
- **sqlite-utils**: CLI utilities for manipulating SQLite databases
- **uv**: Fast Python package installer and resolver
- **pyenv**: Python version management tool
- **mlflow**: Platform for ML experiment tracking and model management

#### Conda Package Manager Setup

- **miniconda**: Minimal conda installer with XDG-compliant configuration
- Creates agentic-ai conda environment with comprehensive AI stack:
  - **LangChain ecosystem**: langchain, langsmith, langserve, langchain-community
  - **Multi-agent frameworks**: crewai, autogen-agentchat, semantic-kernel
  - **Search & retrieval**: haystack-ai, llama-index with extensions
  - **LLM clients**: openai, anthropic, cohere, google-generativeai
  - **ML core**: transformers, datasets, accelerate, torch, sentence-transformers
  - **Web frameworks**: streamlit, gradio, chainlit, fastapi
  - **Monitoring**: mlflow, wandb, langfuse, arize-phoenix

#### Local LLM Capabilities

- **Ollama**: Local LLM hosting with essential models (llama3.2:3b, codellama:7b, mistral:7b, phi3:mini)
- **llamafile**: Single-file LLM deployment for portable AI applications
- XDG-compliant model storage and configuration

#### Modern AI-Enhanced IDEs

- **Cursor**: AI-native code editor with advanced AI features
- **Windsurf**: AI-native IDE from Codeium with collaborative AI
- **Zed**: High-performance collaborative code editor with AI
- **Continue**: Open-source AI code assistant (VS Code extension)

#### Vector Databases & Search

- **Qdrant**: Vector search engine with Docker deployment and XDG persistence
- **ChromaDB**: AI-native open-source embedding database
- **Weaviate**: Cloud-native vector database client
- **Pinecone**: Managed vector database service CLI
- **pgvector**: Vector similarity search extension for PostgreSQL

#### Modern Productivity & Automation Tools

- **Raycast**: AI-powered launcher and productivity tool
- **Rectangle**: Window management for enhanced productivity
- **Alfred**: Productivity app with workflows and AI features
- **Karabiner Elements**: Keyboard customization tool
- **Hammerspoon**: Desktop automation tool using Lua
- **terminal-notifier**: Send macOS notifications from command line
- **mas**: Mac App Store command line interface
- **trash**: Move files to trash from command line

## System Summary Output

When you run `./provision-devlab.sh --status`, you'll see a comprehensive status check:

### 📊 System Information

- macOS Version, Hardware, Architecture
- CPU, Memory, Shell information

### 📁 SBRN Directory Structure

- Verification of PARA directory structure
- XDG Base Directory compliance
- HRT repository status
- Oh My Zsh installation status

### 📦 Package Manager

- Homebrew installation and configuration
- Apple Silicon/Intel optimization

### 🐚 Shell Environment

- Zsh plugins and theme status
- Font installation verification
- XDG-compliant directory setup

### 🛠️ Essential CLI Tools

- Shell productivity tools count and missing items
- Network tools availability
- Text/data processing tools status

### 🔧 Development Tools

- Git/VCS tools status
- Cloud/container tools availability
- Additional development tools verification

### 💻 Programming Languages & Runtimes

- Language versions (Python, Node.js, Java, Go, Rust)
- Version managers status
- Build tools availability

### 📝 IDEs and Editors

- Core IDEs installation status
- VS Code extensions count and management
- CLI editors availability
- Jupyter environment status

### 🤖 Agentic AI Development

- AI/ML tools status
- Conda environments verification
- Local LLM setup status
- AI IDEs availability
- Vector databases configuration

## XDG Base Directory Specification

The script implements XDG Base Directory Specification for clean home directory management:

```bash
# XDG Environment Variables
export XDG_CONFIG_HOME="$SBRN_HOME/sys/config"    # Configuration files
export XDG_DATA_HOME="$SBRN_HOME/sys/local/share" # Data files
export XDG_STATE_HOME="$SBRN_HOME/sys/local/state" # State files
export XDG_CACHE_HOME="$SBRN_HOME/sys/cache"      # Cache files
```

## Application CLI Symlinks

The script creates convenient command-line shortcuts for GUI applications:

```bash
# Example symlinks created in $SBRN_HOME/sys/bin
code        -> Visual Studio Code
cursor      -> Cursor
idea        -> IntelliJ IDEA CE
dbeaver     -> DBeaver
figma       -> Figma
obsidian    -> Obsidian
notion      -> Notion
github      -> GitHub Desktop
postman     -> Postman
slack       -> Slack
```

## Configuration Management

The script links configurations from the HRT repository to XDG-compliant locations:

- **Zsh**: `$XDG_CONFIG_HOME/zsh` -> `$SBRN_HOME/sys/hrt/conf/zsh`
- **Git**: `$XDG_CONFIG_HOME/git` -> `$SBRN_HOME/sys/hrt/conf/git`
- **VS Code**: Settings and extensions managed via HRT configuration
- **iTerm2**: Profiles and color schemes from HRT configuration
- **AI Tools**: XDG-compliant configurations for all AI development tools

## Productivity Impact

### Time Savings

- **Setup Time**: Reduces environment setup from days to minutes
- **Information Retrieval**: Organizations report 1.5 workdays monthly saved
- **Context Switching**: Automated environment switching reduces cognitive overhead

### Consistency Benefits

- **Cross-Machine**: Identical environment replication across devices
- **Team Collaboration**: Standardized tooling reduces "works on my machine" issues
- **Long-term Maintenance**: Industry standards ensure compatibility

### Workflow Optimization

- **Muscle Memory**: Consistent shortcuts and aliases become unconscious habits
- **Search Enhancement**: Smart defaults for ripgrep, fzf, and other tools
- **AI Integration**: Local LLMs and AI-enhanced IDEs for productivity

## Troubleshooting

### Common Issues

1. **Homebrew Installation Fails**

   ```bash
   # Manual installation
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **VS Code CLI Not Available**
   - Open VS Code → Cmd+Shift+P → "Shell Command: Install 'code' command in PATH"

3. **Git Configuration Missing**

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

4. **Python Environment Issues**

   ```bash
   # Create isolated environment
   python3 -m venv ~/.local/share/python-envs/dev
   source ~/.local/share/python-envs/dev/bin/activate
   ```

### Support

For issues, suggestions, or contributions:

- Repository: <https://github.com/krishnam-eng/sbrn-sys-hrt>
- Issues: Create GitHub issue with system details
- Documentation: Check HRT repository README

## License

This project is open-source and available under the MIT License.