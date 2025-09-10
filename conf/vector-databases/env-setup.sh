#!/bin/bash
# Vector Database Environment Setup Script
# Source this file to set up XDG-compliant paths for vector databases

# ChromaDB
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/vector-databases/chromadb"

# Weaviate
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"

# Qdrant data directory
export QDRANT_DATA_DIR="$XDG_DATA_HOME/vector-databases/qdrant"

echo "Vector database XDG environment configured:"
echo "  ChromaDB: $CHROMA_PERSIST_DIRECTORY"
echo "  Weaviate: $WEAVIATE_DATA_PATH"
echo "  Qdrant:   $QDRANT_DATA_DIR"
