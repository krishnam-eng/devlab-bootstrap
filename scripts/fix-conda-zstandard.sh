#!/usr/bin/env bash

################################################################################
# Fix Conda zstandard Warning Script
# 
# This script fixes the warning:
# "zstandard could not be imported. Running without .conda support."
#
# Usage: ./fix-conda-zstandard.sh
################################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }

function fix_zstandard_issue() {
    log_info "🔧 Fixing conda zstandard warning..."
    
    # Check if conda is available
    if ! command -v conda &>/dev/null; then
        log_error "Conda not found. Please install miniconda first."
        exit 1
    fi
    
    # Check current status
    log_info "Checking current zstandard status..."
    if python -c "import zstandard" &>/dev/null 2>&1; then
        log_success "zstandard is already installed and working"
        log_info "Testing conda command..."
        conda env list >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            log_success "Conda is working without zstandard warnings"
            exit 0
        fi
    fi
    
    log_info "Installing zstandard to fix conda warnings..."
    
    # Method 1: Try conda install (preferred for conda environments)
    log_info "Attempting Method 1: conda install from conda-forge..."
    if conda install -c conda-forge zstandard -y; then
        log_success "zstandard installed via conda from conda-forge"
    else
        log_warning "Method 1 failed, trying Method 2..."
        
        # Method 2: Try pip install in current environment
        log_info "Attempting Method 2: pip install..."
        if pip install zstandard; then
            log_success "zstandard installed via pip"
        else
            log_warning "Method 2 failed, trying Method 3..."
            
            # Method 3: Try python -m pip install
            log_info "Attempting Method 3: python -m pip install..."
            if python -m pip install zstandard; then
                log_success "zstandard installed via python -m pip"
            else
                log_error "All installation methods failed"
                log_info "Manual installation options:"
                echo "  1. conda install -c conda-forge zstandard"
                echo "  2. pip install zstandard"
                echo "  3. conda update conda (to get latest version)"
                exit 1
            fi
        fi
    fi
    
    # Verify installation
    log_info "Verifying zstandard installation..."
    if python -c "import zstandard; print(f'zstandard version: {zstandard.__version__}')" 2>/dev/null; then
        log_success "zstandard successfully installed and imported"
        
        # Test conda command to see if warning is gone
        log_info "Testing conda command for warnings..."
        conda_output=$(conda env list 2>&1)
        if echo "$conda_output" | grep -q "zstandard could not be imported"; then
            log_warning "Warning still present - may need to restart shell or update conda"
            log_info "Try: conda update conda"
        else
            log_success "Conda zstandard warning fixed!"
        fi
    else
        log_error "zstandard installation verification failed"
        log_info "Try restarting your shell and running 'python -c \"import zstandard\"'"
        exit 1
    fi
    
    log_success "✅ Conda zstandard fix completed"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    fix_zstandard_issue
fi