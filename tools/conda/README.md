## Prerequisites
### Managing channels
Use conda-forge as repo instead of default

Why: https://community.anaconda.cloud/t/is-conda-cli-free-for-use/14303

How: 
```zsh
ln -s /Users/balamurugan/hrt/boot/tools/conda/.condarc ~/.condarc
```
or

```zsh
# check what is currently set
conda config --show channels

# remove what you find
conda config --remove channels defaults

# add conda-forge
conda config --add channels conda-forge

conda config --show-sources
```

## Working with Conda 

### Managing conda
```zsh
conda --version
conda info

# Updating conda to the current version
conda update conda
```

### Managing environments
```zsh
# restart terminal after the init
conda init zsh

# Environment for development - keep the base clean
conda create --name gen-ai python=3.12.2

# Switch to dev environment
conda activate gen-ai
conda config --show-sources

# before installing packages; hack to provide permission for managing environment file
chmod -R 777 /Users/balamurugan/.conda/
```

### Managing packages

```zsh 
# Install packages at base level
pip install --user pipenv
```

```zsh
# Install essential packages
conda install jupyter
```

### Creating projects
add environment.yaml file in project parent directory

```yaml
name: ai-orchestration
channels:
  - conda-forge
dependencies:
  - openai
  - langchain
  - llama-index
  - langchain-openai
```

```zsh
# create environment for the project
conda env create --file environment.yml
conda activate ai-orchestration

# after adding new packages
conda env update --file environment.yml
```

## Working with PyCharm 

Using PyCharm with Conda environment

-- https://docs.anaconda.com/free/working-with-conda/ide-tutorials/pycharm/# 
