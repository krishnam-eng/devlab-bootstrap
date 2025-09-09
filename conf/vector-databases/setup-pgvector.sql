-- PostgreSQL pgvector Extension Setup Script
-- Run this script in your PostgreSQL database to enable vector similarity search

-- Create the vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Verify the extension is installed
SELECT * FROM pg_extension WHERE extname = 'vector';

-- Example: Create a table with vector column for document embeddings
CREATE TABLE IF NOT EXISTS documents (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    embedding VECTOR(1536),  -- OpenAI text-embedding-ada-002 dimension
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example: Create a table for image embeddings
CREATE TABLE IF NOT EXISTS images (
    id SERIAL PRIMARY KEY,
    filename TEXT NOT NULL,
    description TEXT,
    embedding VECTOR(512),   -- Common image embedding dimension
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for efficient vector similarity search
-- IVFFlat index (good for datasets > 1000 vectors)
CREATE INDEX IF NOT EXISTS documents_embedding_ivfflat_idx 
ON documents USING ivfflat (embedding vector_cosine_ops) 
WITH (lists = 100);

-- HNSW index (good for datasets > 10000 vectors, requires PostgreSQL 14+)
-- CREATE INDEX IF NOT EXISTS documents_embedding_hnsw_idx 
-- ON documents USING hnsw (embedding vector_cosine_ops) 
-- WITH (m = 16, ef_construction = 64);

-- Create index for image embeddings
CREATE INDEX IF NOT EXISTS images_embedding_ivfflat_idx 
ON images USING ivfflat (embedding vector_cosine_ops) 
WITH (lists = 50);

-- Example similarity search functions

-- Function to find similar documents using cosine similarity
CREATE OR REPLACE FUNCTION find_similar_documents(
    query_embedding VECTOR(1536),
    similarity_threshold FLOAT DEFAULT 0.8,
    max_results INTEGER DEFAULT 10
)
RETURNS TABLE (
    id INTEGER,
    title TEXT,
    content TEXT,
    similarity FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id,
        d.title,
        d.content,
        1 - (d.embedding <=> query_embedding) AS similarity
    FROM documents d
    WHERE 1 - (d.embedding <=> query_embedding) > similarity_threshold
    ORDER BY d.embedding <=> query_embedding
    LIMIT max_results;
END;
$$ LANGUAGE plpgsql;

-- Function to find similar images
CREATE OR REPLACE FUNCTION find_similar_images(
    query_embedding VECTOR(512),
    similarity_threshold FLOAT DEFAULT 0.8,
    max_results INTEGER DEFAULT 10
)
RETURNS TABLE (
    id INTEGER,
    filename TEXT,
    description TEXT,
    similarity FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        i.id,
        i.filename,
        i.description,
        1 - (i.embedding <=> query_embedding) AS similarity
    FROM images i
    WHERE 1 - (i.embedding <=> query_embedding) > similarity_threshold
    ORDER BY i.embedding <=> query_embedding
    LIMIT max_results;
END;
$$ LANGUAGE plpgsql;

-- Example usage:
-- 
-- Insert a document with embedding:
-- INSERT INTO documents (title, content, embedding) 
-- VALUES ('Sample Document', 'This is a sample document', '[0.1, 0.2, 0.3, ...]'::vector);
--
-- Search for similar documents:
-- SELECT * FROM find_similar_documents('[0.1, 0.2, 0.3, ...]'::vector, 0.7, 5);
--
-- Direct similarity search:
-- SELECT title, content, 1 - (embedding <=> '[0.1, 0.2, 0.3, ...]'::vector) AS similarity
-- FROM documents
-- ORDER BY embedding <=> '[0.1, 0.2, 0.3, ...]'::vector
-- LIMIT 5;
