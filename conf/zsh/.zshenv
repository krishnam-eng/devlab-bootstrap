# Cross-Desktop Group (XDG) Specification for organizing user files to improve portability and reduce clutter in the home directory.
# More info: https://specifications.freedesktop.org/basedir-spec/latest/
export SBRN_HOME="$HOME/sbrn"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/sbrn/sys/config"
export XDG_DATA_HOME="$HOME/sbrn/sys/local/share" 
export XDG_STATE_HOME="$HOME/sbrn/sys/local/state"
export XDG_CACHE_HOME="$HOME/sbrn/sys/cache"

# Zsh by default looks for its configuration files in the home directory.
# By setting the ZDOTDIR environment variable, you can specify a different directory for Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$SBRN_HOME/sys/etc/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Zsh XDG compliance - move Zsh files to appropriate XDG directories
export HISTFILE="$XDG_STATE_HOME/zsh/.zhistfile"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-${ZSH_VERSION}"
export ZSH_SESSIONS_DIR="$XDG_STATE_HOME/zsh/sessions"

## Application-specific XDG compliance
# Tool-specific configuration paths
export NVM_DIR="$XDG_DATA_HOME/nvm"  # NVM working directory (prevents destruction during Homebrew upgrades)
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
export JENV_ROOT="$XDG_DATA_HOME/jenv"  # jenv XDG-compliant configuration directory

# Python environment variables
export CONDARC="$XDG_CONFIG_HOME/conda/.condarc"
export CONDA_ENVS_PATH="$XDG_DATA_HOME/conda/envs"
export CONDA_PKGS_DIRS="$XDG_CACHE_HOME/conda/pkgs"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Application-specific XDG compliance
export MAVEN_CONFIG="$XDG_CONFIG_HOME/maven"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_HOME="$XDG_DATA_HOME/android"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
# let Git use its default template location
#export GIT_TEMPLATE_DIR="$XDG_DATA_HOME/git/templates"

export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export VIMINFOFILE="$XDG_STATE_HOME/vim/viminfo"

# Node.js and NPM XDG compliance
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

# Z shell navigation tool
export _Z_DATA="$XDG_STATE_HOME/z"

## AI/ML Development Environment Variables (XDG-compliant)
# HuggingFace
export HF_HOME="$XDG_CACHE_HOME/huggingface"
export TRANSFORMERS_CACHE="$XDG_CACHE_HOME/huggingface/transformers"
export HF_DATASETS_CACHE="$XDG_CACHE_HOME/huggingface/datasets"

# MLflow
export MLFLOW_TRACKING_URI="file://$XDG_DATA_HOME/mlflow"
export MLFLOW_REGISTRY_URI="file://$XDG_DATA_HOME/mlflow"

# Jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"
export JUPYTER_RUNTIME_DIR="$XDG_RUNTIME_DIR/jupyter"

# Ollama
export OLLAMA_MODELS="$XDG_DATA_HOME/ollama/models"
export OLLAMA_HOST="127.0.0.1:11434"

# DuckDB
export DUCKDB_HOME="$XDG_DATA_HOME/duckdb"

# PyTorch
export TORCH_HOME="$XDG_CACHE_HOME/torch"

# OpenAI
export OPENAI_CONFIG_HOME="$XDG_CONFIG_HOME/openai"

# Anthropic
export ANTHROPIC_CONFIG_HOME="$XDG_CONFIG_HOME/anthropic"

# LangChain
export LANGCHAIN_CACHE_DIR="$XDG_CACHE_HOME/langchain"

# ChromaDB
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/chromadb"

# Weights & Biases
export WANDB_CONFIG_DIR="$XDG_CONFIG_HOME/wandb"
export WANDB_DATA_DIR="$XDG_DATA_HOME/wandb"
export WANDB_CACHE_DIR="$XDG_CACHE_HOME/wandb"

# TensorBoard
export TENSORBOARD_LOG_DIR="$XDG_DATA_HOME/tensorboard"

# UV (Python package manager) - XDG compliance
export UV_CONFIG_FILE="$XDG_CONFIG_HOME/uv/uv.toml"
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export UV_TOOL_DIR="$XDG_DATA_HOME/uv/tools"
export UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/bin"
export UV_PYTHON_INSTALL_DIR="$XDG_DATA_HOME/uv/python"

# pipx (Python application installer) - XDG compliance
export PIPX_HOME="$XDG_DATA_HOME/pipx"
export PIPX_BIN_DIR="$XDG_DATA_HOME/pipx/bin"
export PIPX_MAN_DIR="$XDG_DATA_HOME/pipx/man"
export PIPX_SHARED_LIBS="$XDG_DATA_HOME/pipx/pyvenv"
export PIPX_LOCAL_VENVS="$XDG_DATA_HOME/pipx/venvs"
export PIPX_LOG_DIR="$XDG_STATE_HOME/pipx/logs"
export PIPX_CACHE_DIR="$XDG_CACHE_HOME/pipx"

# Pyenv
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"

# Python package cache
export PIP_CACHE_DIR="$XDG_CACHE_HOME/pip"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export PYENV_ROOT="$HOME/sbrn/sys/local/share/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Vector Databases
export QDRANT_DATA_DIR="$XDG_DATA_HOME/vector-databases/qdrant"
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"

# AWS, Kubernetes, and Docker configuration paths 
# to comply with XDG Base Directory Specification
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

## Home Brew
# Install Homebrew Cask applications to a user-specific Applications directory instead of the global
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

# Disable Homebrew's anonymous usage analytics/telemetry
export HOMEBREW_NO_ANALYTICS=1

# Enable Homebrew environment hints
export HOMEBREW_NO_ENV_HINTS=

# Auto-cleanup old versions of installed formulae and casks after upgrading
export HOMEBREW_INSTALL_CLEANUP=1

# Set Homebrew auto-update interval to 7 days (default is 24 hours)
export HOMEBREW_AUTO_UPDATE_SECS="604800"

# Set Homebrew directories to comply with XDG Base Directory Specification
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_STATE_HOME/homebrew/logs"
export HOMEBREW_TEMP="$XDG_STATE_HOME/homebrew/tmp"

export PATH="$HOME/sbrn/sys/bin:$PIPX_BIN_DIR:$UV_TOOL_BIN_DIR:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Homebrew environment variables
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

# Set default editor to vim
export EDITOR="vim"
export VISUAL="vim"

# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"