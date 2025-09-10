#!/usr/bin/env python3
"""
Simple AI Agent Example using LangChain and Ollama
"""

from langchain.llms import Ollama
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain
import os

def create_simple_agent():
    """Create a simple AI agent using Ollama local LLM"""
    
    # Initialize Ollama LLM (assumes ollama is running locally)
    llm = Ollama(model="llama3.2:3b")
    
    # Create a prompt template
    prompt = PromptTemplate(
        input_variables=["task"],
        template="You are a helpful AI assistant. Please help with the following task:\n\n{task}\n\nResponse:"
    )
    
    # Create chain
    chain = LLMChain(llm=llm, prompt=prompt)
    
    return chain

def main():
    """Run the simple agent"""
    agent = create_simple_agent()
    
    # Example task
    task = "Explain what an AI agent is in simple terms"
    response = agent.run(task=task)
    
    print(f"Task: {task}")
    print(f"Agent Response: {response}")

if __name__ == "__main__":
    main()