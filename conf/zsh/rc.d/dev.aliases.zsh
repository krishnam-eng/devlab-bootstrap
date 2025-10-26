# Language shortcuts
alias py="python3"
alias js="node"

# Git: enforce linear history on pull across all repos
# - Uses per-command config (-c) which overrides local repo settings
# - Bypass with: `command git ...` if you need the raw git
git() {
  command git \
    -c pull.rebase=true \
    -c pull.ff=only \
    -c rebase.autoStash=true \
    -c rebase.autoSquash=true \
    "$@"
}

# # AI Development shortcuts
# alias ll="ollama list"
# alias lp="ollama pull"
# alias lr="ollama run"
# alias ls="ollama serve"

# # ML Environment shortcuts
# alias ml="conda activate ml-dev"
# alias mloff="conda deactivate"
# alias jlab="jupyter lab"
# alias jnb="jupyter notebook"

# # Vector DB shortcuts
# alias qdrant-start="docker run -p 6333:6333 -d qdrant/qdrant"
# alias qdrant-stop="docker stop \$(docker ps -q --filter ancestor=qdrant/qdrant)"

# # API shortcuts  
# alias hf="huggingface-cli"
# alias openai="openai api"