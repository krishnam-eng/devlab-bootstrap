# Language shortcuts
alias python="uv run python3"
alias py="uv run python3"
alias pip="uv pip"
alias pytest="uv run pytest"
alias js="node"

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

# --- UV Python Toolbox venv shortcuts ---
unalias toolbox 2>/dev/null
toolbox() {
	source "$XDG_DATA_HOME/python-envs/toolbox/bin/activate"
}
alias cdtoolbox='cd "$XDG_DATA_HOME/python-envs/toolbox"'

# # Vector DB shortcuts
# alias qdrant-start="docker run -p 6333:6333 -d qdrant/qdrant"
# alias qdrant-stop="docker stop \$(docker ps -q --filter ancestor=qdrant/qdrant)"

# # API shortcuts  
# alias hf="huggingface-cli"
# alias openai="openai api"