# AI Tools Configuration Management

This directory contains configuration templates and documentation for AI development tools in the HRT (Home Runtime Tools) environment.

## Configuration Strategy

All AI tool configurations are managed through:
1. **Environment Variables**: Centralized in `conf/zsh/.zshenv` with logical grouping
2. **Configuration Files**: Tool-specific configs in `conf/*/` directories
3. **Symlink Management**: Automated linking from HRT conf to XDG locations

## Environment Variables Overview

### XDG Base Directory Specification
- `XDG_CONFIG_HOME`: `$SBRN_HOME/sys/config`
- `XDG_DATA_HOME`: `$SBRN_HOME/sys/local/share`
- `XDG_CACHE_HOME`: `$SBRN_HOME/sys/cache`
- `XDG_STATE_HOME`: `$SBRN_HOME/sys/local/state`

### AI/ML Tool Environment Variables

#### HuggingFace Ecosystem
```bash
HF_HOME="$XDG_CACHE_HOME/huggingface"
TRANSFORMERS_CACHE="$XDG_CACHE_HOME/huggingface/transformers"
HF_DATASETS_CACHE="$XDG_CACHE_HOME/huggingface/datasets"
```

#### MLflow Tracking
```bash
MLFLOW_TRACKING_URI="file://$XDG_DATA_HOME/mlflow"
MLFLOW_REGISTRY_URI="file://$XDG_DATA_HOME/mlflow"
```

#### Jupyter/IPython
```bash
JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"
JUPYTER_RUNTIME_DIR="$XDG_RUNTIME_DIR/jupyter"
IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
```

#### Local LLM (Ollama)
```bash
OLLAMA_MODELS="$XDG_DATA_HOME/ollama/models"
```

#### Vector Databases
```bash
DUCKDB_HOME="$XDG_DATA_HOME/duckdb"
CHROMA_DB_IMPL="duckdb+parquet"
CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/chromadb"
```

#### AI Frameworks
```bash
TORCH_HOME="$XDG_CACHE_HOME/torch"
LANGCHAIN_CACHE_DIR="$XDG_CACHE_HOME/langchain"
```

#### Cloud AI Services
```bash
OPENAI_CONFIG_HOME="$XDG_CONFIG_HOME/openai"
ANTHROPIC_CONFIG_HOME="$XDG_CONFIG_HOME/anthropic"
```

#### Experiment Tracking
```bash
WANDB_CONFIG_DIR="$XDG_CONFIG_HOME/wandb"
WANDB_DATA_DIR="$XDG_DATA_HOME/wandb"
WANDB_CACHE_DIR="$XDG_CACHE_HOME/wandb"
TENSORBOARD_LOG_DIR="$XDG_DATA_HOME/tensorboard"
```

#### Python Package Management
```bash
CONDA_ENVS_PATH="$XDG_DATA_HOME/conda/envs"
CONDA_PKGS_DIRS="$XDG_CACHE_HOME/conda/pkgs"
PIP_CACHE_DIR="$XDG_CACHE_HOME/pip"
UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
UV_CONFIG_FILE="$XDG_CONFIG_HOME/uv/uv.toml"
PYENV_ROOT="$XDG_DATA_HOME/pyenv"
```

## Configuration Files

### Available Configurations
- `ollama/config.yaml`: Ollama LLM service configuration
- `conda/condarc`: Conda package manager configuration
- `jupyter/jupyter_notebook_config.py`: Jupyter notebook configuration
- `uv/uv.toml`: UV Python package manager configuration
- `vector-databases/`: Vector database service configurations

### Symlink Strategy
The provision script automatically creates directory-level symlinks from HRT conf directories to XDG standard locations:

```bash
$SBRN_HOME/sys/hrt/conf/ollama/ → $XDG_CONFIG_HOME/ollama/
$SBRN_HOME/sys/hrt/conf/conda/ → $XDG_CONFIG_HOME/conda/
$SBRN_HOME/sys/hrt/conf/jupyter/ → $XDG_CONFIG_HOME/jupyter/
$SBRN_HOME/sys/hrt/conf/uv/ → $XDG_CONFIG_HOME/uv/
$SBRN_HOME/sys/hrt/conf/vector-databases/ → $XDG_CONFIG_HOME/vector-databases/
$SBRN_HOME/sys/hrt/conf/ai-tools/ → $XDG_CONFIG_HOME/ai-tools/
```

This approach allows:
- Multiple configuration files per tool within their dedicated directories
- Tool-specific subdirectories and additional configuration files
- Direct access to configuration files using their standard names
- Easier maintenance and version control of entire configuration sets

## Usage

1. **Environment Setup**: Variables are automatically loaded from `.zshenv`
2. **Configuration Linking**: Run `setup_ai_tools_xdg_config()` from provision script
3. **Tool Installation**: Use `setup_agentic_ai_development()` for complete AI environment

## Benefits

- **XDG Compliance**: All tools follow XDG Base Directory Specification
- **Centralized Management**: Single source of truth for configurations
- **Version Control**: All configurations tracked in git
- **Portability**: Easy migration between development environments
- **Isolation**: Clean separation of application data, cache, and configuration
