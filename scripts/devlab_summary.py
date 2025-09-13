#!/usr/bin/env python3

"""
Developer Laboratory Setup Summary Generator

This module contains phase summaries for the provision-devlab.sh script.
Each phase summary is organized by category and tool type for better readability.
"""

import sys

class DevLabSummary:
    """Utility class for generating phase summaries."""
    
    PHASE_SUMMARIES = {
        "0": {
            "title": "Prerequisites Setup",
            "content": [
                "Second Brain root directory created at $SBRN_HOME",
                "Basic sys directory structure initialized",
                "HRT repository cloned or verified at $SBRN_HOME/sys/hrt",
                "Homebrew package manager checked and updated"
            ]
        },
        "1": {
            "title": "Directory Structure",
            "content": [
                "XDG-compliant directory structure fully initialized",
                "PARA method directories created (Projects, Areas, Resources, Archives)",
                "Development workspace organized under ~/sbrn with specialized subdirectories",
                "Cloud drive mount points prepared (iCloud, Google Drive, OneDrive, Dropbox)",
                "System directories organized (bin, etc, cache, config, local)",
                "User directories optimized (Desktop, Documents, Downloads)",
                "FSH-compliant configuration structure established",
                "All paths set with proper permissions and ownership"
            ]
        },
        "2": {
            "title": "Zsh Environment",
            "content": [
                "Oh My Zsh framework installed with custom configuration",
                "Powerlevel10k theme configured with optimal settings",
                "Essential plugins installed and configured:",
                "  • Syntax highlighting for command validation",
                "  • Autosuggestions for command completion",
                "  • History substring search for quick recall",
                "  • Autoswitch virtualenv for Python development",
                "Meslo Nerd Font installed for rich terminal visuals",
                "Custom aliases and functions from HRT linked",
                "Shell configuration files properly organized",
                "XDG-compliant Zsh directory structure implemented"
            ]
        },
        "3": {
            "title": "Essential CLI Tools",
            "content": [
                "Shell Productivity Tools:",
                "  • Core Utilities:",
                "    - [coreutils] GNU core utilities",
                "    - [tldr] Simplified man pages",
                "  • File Operations:",
                "    - [eza/lsd] Modern ls replacements",
                "    - [bat] Enhanced cat with syntax highlighting",
                "    - [fd] User-friendly find alternative",
                "    - [tree] Directory listing in tree format",
                "  • Directory & Navigation:",
                "    - [ranger] Console file manager",
                "    - [as-tree] Tree view of lists",
                "    - [fzf] Fuzzy finder",
                "    - [zoxide] Smarter cd command",
                "    - [broot] Directory tree explorer",
                "  • System Monitoring:",
                "    - [htop] Interactive process viewer",
                "    - [glances] System monitoring tool",
                "    - [ctop] Container metrics viewer",
                "    - [ncdu] NCurses disk usage analyzer",
                "    - [watch] Execute commands periodically",
                "    - [agedu] Space usage analyzer",
                "  • Terminal Enhancement:",
                "    - [tmux] Terminal session manager",
                "    - [screen] Screen manager with VT100",
                "    - [figlet] ASCII art text banner",
                "    - [lolcat] Rainbow text colorizer",
                "  • Shell Enhancement:",
                "    - [atuin] Magical shell history",
                "    - [direnv] Directory environment",
                "    - [autoenv] Directory-based env",
                "    - [zsh-autosuggestions] Command suggestions",
                "    - [zsh-completions] Extended completions",
                "    - [bash-completion] Bash completion support",
                "    - [fish] User-friendly shell",
                "    - [starship] Cross-shell prompt",
                "Networking & Security:",
                "  • Data Transfer:",
                "    - [curl] URL transfer tool",
                "    - [wget] Network file retriever",
                "    - [httpie] HTTP client for APIs",
                "  • Security:",
                "    - [gnupg] GNU Privacy Guard",
                "    - [certbot] Let's Encrypt client",
                "  • Network Diagnostics:",
                "    - [netcat] TCP/IP swiss army knife",
                "    - [telnet] User interface to TELNET",
                "Text Processing:",
                "  • Text Tools:",
                "    - [emacs] Extensible text editor",
                "    - [nano] Simple text editor",
                "  • Data Processing:",
                "    - [grep] Standard pattern search",
                "    - [colordiff] Colorized diff output",
                "    - [ccat] Colored cat output",
                "    - [base64/base91] Data encoding utilities"
            ]
        },
        "4": {
            "title": "Development Tools",
            "content": [
                "Version Control System tools configured:",
                "  • Git Core & Extensions:",
                "    - [git] Version control system",
                "    - [git-extras] Git utilities and workflows",
                "    - [git-lfs] Git large file storage",
                "    - [gibo] .gitignore boilerplates",
                "  • Git UI & Visualization:",
                "    - [git-gui] GUI interface for Git",
                "    - [lazygit] Terminal UI for Git",
                "    - [tig] Text-mode interface for Git",
                "    - [diff-so-fancy] Better Git diff",
                "    - [delta] Syntax-highlighting pager",
                "  • GitHub Integration:",
                "    - [gh] GitHub CLI",
                "    - [ghq] Remote repository manager",
                "Container & Cloud Development tools installed:",
                "  • Container Tools:",
                "    - [docker] Container platform",
                "    - [docker-compose] Multi-container Docker",
                "    - [colima] Container runtime for macOS",
                "    - [dive] Docker image explorer",
                "    - [dockviz] Docker visualization",
                "    - [ctop] Container metrics viewer",
                "  • Kubernetes Tools:",
                "    - [kubernetes-cli] Kubernetes command-line",
                "    - [helm] Kubernetes package manager",
                "    - [k9s] Kubernetes terminal UI",
                "    - [minikube] Local Kubernetes",
                "    - [kubecolor] Colorized kubectl output",
                "    - [kompose] Docker Compose to Kubernetes",
                "    - [krew] kubectl plugin manager",
                "    - [kube-ps1] Kubernetes prompt info",
                "    - [kubebuilder] SDK for building operators",
                "    - [kustomize] Kubernetes configuration",
                "  • Cloud & Infrastructure:",
                "    - [awscli] Amazon Web Services CLI",
                "    - [terraform] Infrastructure as Code",
                "    - [pulumi] Modern Infrastructure as Code",
                "    - [railway] Railway platform CLI",
                "    - [vercel-cli] Vercel platform CLI",
                "    - [istioctl] Service mesh control",
                "Graphics & UI Development libraries:",
                "  • Core Libraries:",
                "    - [gtk+3] GUI toolkit",
                "    - [librsvg] SVG rendering library",
                "    - [pcre] Regular expression library",
                "    - [xerces-c] XML parsing library",
                "  • Image & Graphics:",
                "    - [ghostscript] PostScript interpreter",
                "    - [graphviz] Graph visualization",
                "  • UI Development:",
                "    - [guile] GNU extension language",
                "    - [pygobject3] Python GObject bindings",
                "Code & Data Development Tools:",
                "  • Code Editors:",
                "    - [vim] Vi IMproved text editor",
                "    - [neovim] Hyperextensible Vim",
                "  • Code Search & Analysis:",
                "    - [ripgrep] Fast code search tool",
                "    - [ack] Code-search utility",
                "  • JSON/YAML Development:",
                "    - [jq] Command-line JSON processor",
                "    - [yq] YAML processor",
                "    - [fx] JSON explorer",
                "    - [jid] JSON incremental digger",
                "API & Backend Development:",
                "  • API Tools:",
                "    - [openapi-generator] API code generator",
                "    - [jwt-cli] JWT debugger",
                "    - [newman] Postman CLI runner",
                "  • Documentation:",
                "    - [hugo] Static site generator",
                "  • Data Services:",
                "    - [postgresql@15] PostgreSQL database",
                "    - [redis] In-memory data store",
                "    - [etcd] Distributed key-value store",
                "  • Server & Operations:",
                "    - [nginx] Web server",
                "    - [sftpgo] SFTP server",
                "    - [operator-sdk] Kubernetes operators",
                "    - [logrotate] Log file management",
                "    - [rtmpdump] RTMP toolkit"
            ]
        },
        "5": {
            "title": "Programming Languages & Runtimes",
            "content": [
                "Core Programming Languages & Runtimes:",
                "  • JVM Languages:",
                "    - [openjdk@17] OpenJDK 17 LTS for enterprise compatibility",
                "    - [openjdk@21] OpenJDK 21 LTS for latest features",
                "  • Interpreted Languages:",
                "    - [python@3.13] Latest Python with optimal AI/ML support",
                "    - [perl] Perl interpreter for legacy script support",
                "  • Compiled Languages:",
                "    - [node] Node.js runtime for JavaScript/TypeScript",
                "    - [go] Go language for high-performance applications",
                "    - [rust] Rust for systems programming and safety",
                "Runtime Environment Managers (XDG-compliant):",
                "  • Java Environment:",
                "    - [jenv] Java version management with XDG paths",
                "    - Enable export, maven, gradle plugins",
                "    - Global Java 21 set as default",
                "    - XDG directories: $XDG_DATA_HOME/jenv",
                "  • Python Environment:",
                "    - [uv] Modern Python package & project manager",
                "    - XDG configuration: $XDG_CONFIG_HOME/uv (linked from HRT)",
                "    - XDG cache: $XDG_CACHE_HOME/uv",
                "    - Tool binaries: $XDG_DATA_HOME/uv/bin (added to PATH)",
                "    - Python installations: $XDG_DATA_HOME/uv/python",
                "    - [pipx] Isolated Python application installer",
                "    - XDG paths: $XDG_DATA_HOME/pipx (home, bin, venvs, logs)",
                "  • Node.js Environment:",
                "    - [nvm] Node Version Manager with XDG compliance",
                "    - XDG directory: $XDG_DATA_HOME/nvm",
                "    - Latest LTS Node.js installed and set as default",
                "Build Automation & Package Management:",
                "  • Java Build Tools:",
                "    - [maven] Apache Maven for Java project management",
                "    - [gradle] Gradle build automation for JVM projects",
                "  • JavaScript/Node.js Tools:",
                "    - [yarn] Fast, reliable dependency management for Node.js",
                "  • Python Tools:",
                "    - [poetry] Python dependency management and packaging",
                "Development Environment Creation:",
                "  • ML Development Environment:",
                "    - Created with uv in XDG location: $XDG_DATA_HOME/python-projects/ml-dev",
                "    - Python 3.12 runtime with comprehensive ML packages",
                "    - Jupyter kernel registered: 'Python (ML-Dev-UV)'",
                "    - Activation: cd [project-path] && uv shell",
                "    - Jupyter access: uv run jupyter lab",
                "  • XDG Base Directory Compliance:",
                "    - All runtime managers use XDG-compliant paths",
                "    - Configuration files linked from HRT repository",
                "    - Cache and data directories properly organized",
                "    - PATH variables updated for tool accessibility"
            ]
        },
        "6": {
            "title": "IDEs & Productivity Tools",
            "content": [
                "Professional Development Environments:",
                "  • Core IDEs & Editors:",
                "    - [visual-studio-code] Microsoft's extensible code editor",
                "    - [intellij-idea-ce] JetBrains IntelliJ IDEA Community Edition",
                "    - [pycharm-ce] JetBrains PyCharm Community Edition for Python",
                "    - [cursor] AI-powered code editor with advanced features", 
                "    - [windsurf] Next-generation development environment",
                "    - [zed] High-performance collaborative code editor",
                "  • Terminal & Shell Enhancement:",
                "    - [iterm2] Advanced terminal emulator with profiles",
                "    - Custom profiles from HRT configuration",
                "    - Color schemes: Catppuccin, Nord, Solarized, GitHub Dark, etc.",
                "  • VS Code Configuration:",
                "    - Settings linked from HRT: $SBRN_HOME/sys/config/code/user/settings.json",
                "    - Extensions installed from HRT extensions.txt configuration",
                "    - XDG-compliant configuration directory structure",
                "Data Science & Development Environment:",
                "  • Notebook Environment:",
                "    - [jupyterlab] Web-based interactive development environment",
                "    - [notebook] Classic Jupyter Notebook interface",
                "    - Installed via pipx for isolation and XDG compliance",
                "    - Custom kernels support (ML-Dev-UV, Agentic-AI-UV)",
                "  • Database Management:",
                "    - [dbeaver-community] Universal database management tool",
                "    - [pgadmin4] PostgreSQL administration and development platform",
                "Productivity & Collaboration Applications:",
                "  • Knowledge Management:",
                "    - [notion] All-in-one workspace for notes and collaboration",
                "    - [obsidian] Knowledge management with linked notes",
                "  • Design & Prototyping:",
                "    - [figma] Collaborative design and prototyping platform",
                "  • Communication & Collaboration:",
                "    - [slack] Team communication and integration platform",
                "    - [github] GitHub Desktop for Git workflow management",
                "  • API Development & Testing:",
                "    - [postman] API development and testing platform",
                "    - [insomnia] REST and GraphQL API testing client",
                "    - [rapidapi] API marketplace and testing platform",
                "System Enhancement & Automation Tools:",
                "  • Window & Desktop Management:",
                "    - [rectangle] Window management for enhanced productivity",
                "    - [hammerspoon] Desktop automation and scripting engine",
                "    - [bartender] Menu bar organization and management",
                "  • Input & Keyboard Enhancement:",
                "    - [karabiner-elements] Keyboard customization and remapping",
                "  • Launcher & Search:",
                "    - [alfred] Powerful launcher and workflow automation",
                "  • System Utilities:",
                "    - [terminal-notifier] Send macOS notifications from command line",
                "    - [mas] Mac App Store command line interface",
                "    - [duti] Set default applications for document types",
                "    - [trash] Move files to trash from command line",
                "    - [brew-services] Manage background services via Homebrew",
                "Application Command-Line Integration:",
                "  • CLI Symlinks Created in $SBRN_HOME/sys/bin:",
                "    - code → Visual Studio Code",
                "    - idea → IntelliJ IDEA Community Edition",
                "    - pycharm → PyCharm Community Edition", 
                "    - cursor → Cursor AI Editor",
                "    - dbeaver → DBeaver Database Tool",
                "    - figma → Figma Design Tool",
                "    - obsidian → Obsidian Knowledge Management",
                "    - notion → Notion Workspace",
                "    - github → GitHub Desktop",
                "    - insomnia → Insomnia API Client",
                "    - postman → Postman API Platform",
                "    - rapidapi → RapidAPI Testing Platform",
                "    - slack → Slack Communication",
                "    - pgadmin → pgAdmin PostgreSQL Tool",
                "  • PATH Integration:",
                "    - $SBRN_HOME/sys/bin added to PATH for instant CLI access",
                "    - All applications accessible from terminal via command name"
            ]
        },
        "7": {
            "title": "AI Development Environment",
            "content": [
                "AI/ML Core Development Infrastructure:",
                "  • Package & Environment Management:",
                "    - [uv] Modern Python package manager (configured in Phase 5)",
                "    - [pyenv] Python version management for AI/ML compatibility",
                "    - Python 3.13 optimized for latest AI frameworks",
                "  • Data Processing & Analytics:",
                "    - [duckdb] High-performance analytical database",
                "    - [datasette] Data exploration and publishing platform",
                "    - [sqlite-utils] Command-line utilities for SQLite/data",
                "  • ML Operations & Tracking:",
                "    - [mlflow] ML lifecycle management and experiment tracking",
                "    - Configured with XDG paths: $XDG_DATA_HOME/mlflow",
                "    - [huggingface-cli] HuggingFace Hub model management",
                "AI Agent Development Framework:",
                "  • Agentic AI Environment (uv-managed):",
                "    - Project location: $XDG_DATA_HOME/python-projects/agentic-ai",
                "    - Python 3.13 runtime with comprehensive agent frameworks",
                "    - Dependencies from HRT template: agentic-ai-pyproject.toml",
                "    - LangChain ecosystem for agent development",
                "    - OpenAI, Anthropic, and local model integrations",
                "    - Vector database connectors and embeddings",
                "    - Example scripts and templates in examples/ directory",
                "  • Jupyter Integration:",
                "    - Custom kernel: 'Python (Agentic-AI-UV)'",
                "    - Activation: cd [project-path] && uv shell",
                "    - Notebook access: uv run jupyter lab",
                "    - XDG-compliant Jupyter data: $XDG_DATA_HOME/jupyter",
                "Local LLM Infrastructure:",
                "  • Ollama Platform:",
                "    - [ollama] Local LLM deployment and management",
                "    - XDG configuration: $XDG_CONFIG_HOME/ollama/config.yaml",
                "    - Model storage: $XDG_DATA_HOME/ollama/models",
                "    - Service binding: 127.0.0.1:11434 with CORS support",
                "  • Essential Models Downloaded:",
                "    - [llama3.2:3b] Efficient general-purpose language model",
                "    - [codellama:7b] Code generation and programming assistance",
                "    - [mistral:7b] High-quality chat and reasoning model",
                "    - [phi3:mini] Microsoft's compact efficient model",
                "  • Portable Deployment:",
                "    - [llamafile] Single-file LLM deployment solution",
                "    - Installation: $SBRN_HOME/sys/bin/llamafile",
                "    - XDG data directory: $XDG_DATA_HOME/llamafile/models",
                "Vector Database Ecosystem:",
                "  • Production Vector Databases:",
                "    - [qdrant] High-performance vector search engine",
                "    - Docker configuration with XDG persistence",
                "    - Data storage: $XDG_DATA_HOME/vector-databases/qdrant",
                "    - Docker Compose: $XDG_CONFIG_HOME/vector-databases/qdrant-docker-compose.yml",
                "  • Embedded Vector Solutions:",
                "    - [chromadb] AI-native embedding database (via pipx)",
                "    - XDG configuration: $XDG_DATA_HOME/vector-databases/chromadb",
                "    - DuckDB+Parquet backend for persistence",
                "  • Enterprise Vector Platforms:",
                "    - [weaviate-client] Cloud-native vector database client",
                "    - [pinecone-client] Managed vector database service",
                "    - XDG configuration: $XDG_CONFIG_HOME/vector-databases/",
                "  • PostgreSQL Vector Extension:",
                "    - [pgvector] Vector similarity search for PostgreSQL",
                "    - Setup script: $XDG_CONFIG_HOME/vector-databases/setup-pgvector.sql",
                "    - Integration with existing PostgreSQL installation",
                "XDG Base Directory Compliance:",
                "  • Configuration Management:",
                "    - AI tool configs linked from HRT: $XDG_CONFIG_HOME/ai-tools/",
                "    - Ollama, Jupyter, vector database configurations",
                "    - Environment setup script: $XDG_CONFIG_HOME/vector-databases/env-setup.sh",
                "  • Data Organization:",
                "    - Cache: $XDG_CACHE_HOME/{huggingface,torch,langchain,wandb,uv}",
                "    - Data: $XDG_DATA_HOME/{mlflow,jupyter,ollama,duckdb,chromadb,wandb}",
                "    - State: $XDG_STATE_HOME/ai-tools for application state",
                "Development Workflow Integration:",
                "  • VS Code AI Extensions:",
                "    - Configured via HRT extensions.txt",
                "    - AI-specific tooling and language support",
                "  • Environment Variables:",
                "    - OLLAMA_MODELS for local model storage",
                "    - MLFLOW_TRACKING_URI for experiment tracking",
                "    - Vector database connection strings",
                "  • Activation Commands:",
                "    - ML Environment: cd $XDG_DATA_HOME/python-projects/ml-dev && uv shell",
                "    - AI Agent Env: cd $XDG_DATA_HOME/python-projects/agentic-ai && uv shell",
                "    - Ollama Service: ollama serve (with XDG model paths)",
                "    - Qdrant Service: docker-compose -f [qdrant-compose] up -d"
            ]
        }
    }
    
    @classmethod
    def get_phase_summary(cls, phase_number):
        """
        Get the summary content for a specific phase.
        
        Args:
            phase_number (str): The phase number (e.g., "3")
            
        Returns:
            list: List of summary lines
        """
        phase_data = cls.PHASE_SUMMARIES.get(phase_number)
        if phase_data:
            return phase_data["content"]
        return []
    
    @classmethod
    def get_phase_title(cls, phase_number):
        """
        Get the title for a specific phase.
        
        Args:
            phase_number (str): The phase number (e.g., "3")
            
        Returns:
            str: Phase title
        """
        phase_data = cls.PHASE_SUMMARIES.get(phase_number)
        if phase_data:
            return phase_data["title"]
        return f"Phase {phase_number}"

def get_phase_summary(phase_number):
    """Convenience function to get phase summary."""
    return DevLabSummary.get_phase_summary(phase_number)

def main():
    """Main function for command line usage."""
    if len(sys.argv) > 1:
        phase_number = sys.argv[1]
        summary = DevLabSummary.get_phase_summary(phase_number)
        for line in summary:
            print(line)
    else:
        # Default to phase 3 for backward compatibility
        summary = DevLabSummary.get_phase_summary("3")
        for line in summary:
            print(line)

if __name__ == "__main__":
    main()
