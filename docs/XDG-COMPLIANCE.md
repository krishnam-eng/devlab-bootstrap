# XDG Base Directory Specification Compliance for AI Development Tools

This document outlines how all AI development tools in the provisioning script have been configured to follow the XDG Base Directory Specification, keeping your home directory clean and organized.

## XDG Base Directories

The script uses these XDG-compliant directories:

- **XDG_CONFIG_HOME**: `$SBRN_HOME/sys/config` - Configuration files
- **XDG_DATA_HOME**: `$SBRN_HOME/sys/local/share` - Data files
- **XDG_CACHE_HOME**: `$SBRN_HOME/sys/cache` - Cache files
- **XDG_STATE_HOME**: `$SBRN_HOME/sys/local/state` - State files

## AI Tools XDG Configuration

### 1. Core AI/ML Tools

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **HuggingFace** | `HF_HOME` | `$XDG_CACHE_HOME/huggingface` |
| | `TRANSFORMERS_CACHE` | `$XDG_CACHE_HOME/huggingface/transformers` |
| | `HF_DATASETS_CACHE` | `$XDG_CACHE_HOME/huggingface/datasets` |
| **MLflow** | `MLFLOW_TRACKING_URI` | `file://$XDG_DATA_HOME/mlflow` |
| | `MLFLOW_REGISTRY_URI` | `file://$XDG_DATA_HOME/mlflow` |
| **Ollama** | `OLLAMA_MODELS` | `$XDG_DATA_HOME/ollama/models` |
| **DuckDB** | `DUCKDB_HOME` | `$XDG_DATA_HOME/duckdb` |
| **PyTorch** | `TORCH_HOME` | `$XDG_CACHE_HOME/torch` |

### 2. Python Environment Tools

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **Conda** | `CONDA_ENVS_PATH` | `$XDG_DATA_HOME/conda/envs` |
| | `CONDA_PKGS_DIRS` | `$XDG_CACHE_HOME/conda/pkgs` |
| | `CONDARC` | `$XDG_CONFIG_HOME/conda/condarc` |
| **Pyenv** | `PYENV_ROOT` | `$XDG_DATA_HOME/pyenv` |
| **UV** | `UV_CACHE_DIR` | `$XDG_CACHE_HOME/uv` |
| | `UV_CONFIG_FILE` | `$XDG_CONFIG_HOME/uv/uv.toml` |
| **Pip** | `PIP_CACHE_DIR` | `$XDG_CACHE_HOME/pip` |

### 3. Jupyter & IPython

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **Jupyter** | `JUPYTER_CONFIG_DIR` | `$XDG_CONFIG_HOME/jupyter` |
| | `JUPYTER_DATA_DIR` | `$XDG_DATA_HOME/jupyter` |
| | `JUPYTER_RUNTIME_DIR` | `$XDG_RUNTIME_DIR/jupyter` |
| **IPython** | `IPYTHONDIR` | `$XDG_CONFIG_HOME/ipython` |

### 4. Vector Databases

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **ChromaDB** | `CHROMA_PERSIST_DIRECTORY` | `$XDG_DATA_HOME/vector-databases/chromadb` |
| **Qdrant** | Data persistence | `$XDG_DATA_HOME/vector-databases/qdrant` |
| **Weaviate** | `WEAVIATE_DATA_PATH` | `$XDG_DATA_HOME/vector-databases/weaviate` |
| | `WEAVIATE_CONFIG_PATH` | `$XDG_CONFIG_HOME/vector-databases/weaviate` |

### 5. AI Services & APIs

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **OpenAI** | `OPENAI_CONFIG_HOME` | `$XDG_CONFIG_HOME/openai` |
| **Anthropic** | `ANTHROPIC_CONFIG_HOME` | `$XDG_CONFIG_HOME/anthropic` |
| **LangChain** | `LANGCHAIN_CACHE_DIR` | `$XDG_CACHE_HOME/langchain` |

### 6. ML Experiment Tracking

| Tool | XDG Configuration | Location |
|------|------------------|----------|
| **Weights & Biases** | `WANDB_CONFIG_DIR` | `$XDG_CONFIG_HOME/wandb` |
| | `WANDB_DATA_DIR` | `$XDG_DATA_HOME/wandb` |
| | `WANDB_CACHE_DIR` | `$XDG_CACHE_HOME/wandb` |
| **TensorBoard** | `TENSORBOARD_LOG_DIR` | `$XDG_DATA_HOME/tensorboard` |

## Configuration Files Created

### 1. Main XDG Configuration
- **Location**: `$XDG_CONFIG_HOME/ai-tools/xdg-env.conf`
- **Purpose**: Central XDG environment variables for all AI tools
- **Auto-sourced**: Added to `.zshrc` for automatic loading

### 2. Vector Database Environment
- **Location**: `$XDG_CONFIG_HOME/vector-databases/env-setup.sh`
- **Purpose**: Vector database-specific XDG configuration
- **Usage**: Source manually when working with vector databases

### 3. Conda Configuration
- **Location**: `$XDG_CONFIG_HOME/conda/condarc`
- **Purpose**: XDG-compliant conda settings
- **Features**: Auto-detects XDG paths, conda-forge priority

### 4. Ollama Configuration
- **Location**: `$XDG_CONFIG_HOME/ollama/config.yaml`
- **Purpose**: LLM model storage in XDG location
- **Features**: Host binding, model path configuration

## Directory Structure

```
$SBRN_HOME/sys/
├── config/                    # XDG_CONFIG_HOME
│   ├── ai-tools/
│   │   └── xdg-env.conf      # Main AI tools XDG configuration
│   ├── vector-databases/
│   │   ├── env-setup.sh      # Vector DB environment setup
│   │   ├── chromadb.conf     # ChromaDB configuration
│   │   ├── weaviate.conf     # Weaviate configuration
│   │   ├── qdrant-docker-compose.yml
│   │   └── setup-pgvector.sql
│   ├── conda/
│   │   └── condarc           # Conda XDG configuration
│   ├── ollama/
│   │   └── config.yaml       # Ollama XDG configuration
│   ├── jupyter/              # Jupyter configuration
│   ├── ipython/              # IPython configuration
│   ├── openai/               # OpenAI CLI configuration
│   ├── anthropic/            # Anthropic CLI configuration
│   ├── wandb/                # Weights & Biases configuration
│   └── uv/                   # UV package manager configuration
├── local/
│   └── share/                # XDG_DATA_HOME
│       ├── conda/
│       │   └── envs/         # Conda environments
│       ├── pyenv/            # Python versions
│       ├── ollama/
│       │   └── models/       # LLM models
│       ├── vector-databases/
│       │   ├── chromadb/     # ChromaDB persistent data
│       │   ├── qdrant/       # Qdrant persistent data
│       │   └── weaviate/     # Weaviate data
│       ├── mlflow/           # MLflow tracking data
│       ├── jupyter/          # Jupyter data files
│       ├── wandb/            # W&B experiment data
│       ├── tensorboard/      # TensorBoard logs
│       └── llamafile/        # Llamafile models
└── cache/                    # XDG_CACHE_HOME
    ├── huggingface/          # HuggingFace models cache
    ├── torch/                # PyTorch model cache
    ├── langchain/            # LangChain cache
    ├── conda/
    │   └── pkgs/             # Conda package cache
    ├── pip/                  # Pip package cache
    ├── uv/                   # UV package cache
    └── wandb/                # W&B cache
```

## Benefits of XDG Compliance

1. **Clean Home Directory**: No AI tool dotfiles cluttering `$HOME`
2. **Organized Data**: All AI tools follow consistent directory structure
3. **Easy Backup**: Backup entire `$SBRN_HOME/sys/` for complete AI environment
4. **Portable Configuration**: Environment variables make tools location-aware
5. **Predictable Paths**: Always know where AI tool data is stored
6. **Easy Cleanup**: Remove tool data by deleting specific XDG directories

## Usage

The XDG configuration is automatically applied when:

1. **Shell Startup**: `.zshrc` sources the main XDG configuration
2. **Conda Usage**: `condarc` file automatically uses XDG paths
3. **AI Tool Installation**: Environment variables guide tools to XDG locations
4. **ML Environment**: Conda environments created in XDG-compliant locations

## Manual Configuration

For additional AI tools not covered by the script:

1. **Add to XDG config**: Edit `$XDG_CONFIG_HOME/ai-tools/xdg-env.conf`
2. **Create directories**: Use `mkdir -p` for required XDG paths
3. **Update shell**: Source the configuration or restart shell
4. **Test paths**: Verify tools use XDG locations

## Troubleshooting

If tools don't respect XDG paths:

1. **Check environment**: `echo $TOOL_CONFIG_VAR`
2. **Source config**: `source $XDG_CONFIG_HOME/ai-tools/xdg-env.conf`
3. **Restart shell**: Start new terminal session
4. **Verify paths**: Check if directories exist and are writable

This XDG compliance ensures your AI development environment is clean, organized, and follows industry best practices for configuration management.
