#!/bin/bash
# Vector Database Environment Setup Script
# XDG-compliant configuration for vector databases

# ChromaDB configuration
export CHROMA_DB_IMPL="duckdb+parquet"
export CHROMA_PERSIST_DIRECTORY="$XDG_DATA_HOME/vector-databases/chromadb"
export CHROMA_SERVER_HTTP_PORT="8000"
export CHROMA_SERVER_GRPC_PORT="50051"

# Weaviate configuration
export WEAVIATE_DATA_PATH="$XDG_DATA_HOME/vector-databases/weaviate"
export WEAVIATE_CONFIG_PATH="$XDG_CONFIG_HOME/vector-databases/weaviate"
export WEAVIATE_DEFAULT_VECTORIZER_MODULE="text2vec-openai"

# Qdrant configuration
export QDRANT_DATA_DIR="$XDG_DATA_HOME/vector-databases/qdrant"
export QDRANT_HTTP_PORT="6333"
export QDRANT_GRPC_PORT="6334"

# Pinecone configuration
export PINECONE_CONFIG_DIR="$XDG_CONFIG_HOME/vector-databases/pinecone"

# pgvector configuration (PostgreSQL extension)
export PGVECTOR_SETUP_SCRIPT="$XDG_CONFIG_HOME/vector-databases/setup-pgvector.sql"

echo "Vector database XDG environment configured:"
echo "  ChromaDB:  $CHROMA_PERSIST_DIRECTORY"
echo "  Weaviate:  $WEAVIATE_DATA_PATH"
echo "  Qdrant:    $QDRANT_DATA_DIR"
echo "  Pinecone:  $PINECONE_CONFIG_DIR"

# Create necessary directories
mkdir -p "$CHROMA_PERSIST_DIRECTORY"
mkdir -p "$WEAVIATE_DATA_PATH"
mkdir -p "$WEAVIATE_CONFIG_PATH"
mkdir -p "$QDRANT_DATA_DIR"
mkdir -p "$PINECONE_CONFIG_DIR"
