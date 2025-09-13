#!/usr/bin/env python3
"""
Homebrew Utility Module for Developer Laboratory Setup

This module provides optimized functions for managing Homebrew packages and casks,
including batch installation capabilities to reduce setup time when packages
are already installed.

Author: Balamurugan Krishnamoorthy
"""

import subprocess
import sys
from typing import List, Set, Tuple


class Colors:
    """ANSI color codes for terminal output"""
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[1;34m'
    CYAN = '\033[0;36m'
    MAGENTA = '\033[0;35m'
    BOLD = '\033[1m'
    DIM = '\033[2m'
    GREY = '\033[37m'
    NC = '\033[0m'  # No Color


class Logger:
    """Maven-style logging functions"""
    
    @staticmethod
    def info(message: str) -> None:
        print(f"{Colors.GREY}[INFO]{Colors.NC} {message}")
    
    @staticmethod
    def success(message: str) -> None:
        print(f"{Colors.GREEN}[SUCCESS]{Colors.NC} {message}")
    
    @staticmethod
    def warning(message: str) -> None:
        print(f"{Colors.YELLOW}[WARNING]{Colors.NC} {message}")
    
    @staticmethod
    def error(message: str) -> None:
        print(f"{Colors.RED}[ERROR]{Colors.NC} {message}")


class BrewUtil:
    """Utility class for Homebrew package management"""
    
    def __init__(self, skip_cask_apps: bool = False):
        """
        Initialize BrewUtil
        
        Args:
            skip_cask_apps: If True, skip all cask app installations
        """
        self.skip_cask_apps = skip_cask_apps
        self._installed_formulas: Set[str] = set()
        self._installed_casks: Set[str] = set()
        self._formulas_loaded = False
        self._casks_loaded = False
    
    def _run_command(self, command: List[str], capture_output: bool = True) -> subprocess.CompletedProcess:
        """
        Run a shell command and return the result
        
        Args:
            command: List of command parts
            capture_output: Whether to capture stdout/stderr
            
        Returns:
            CompletedProcess result
        """
        try:
            result = subprocess.run(
                command,
                capture_output=capture_output,
                text=True,
                timeout=300  # 5 minute timeout
            )
            return result
        except subprocess.TimeoutExpired:
            Logger.error(f"Command timed out: {' '.join(command)}")
            raise
        except subprocess.CalledProcessError as e:
            Logger.error(f"Command failed: {' '.join(command)}, Error: {e}")
            raise
    
    def _load_installed_formulas(self) -> None:
        """Load the list of installed Homebrew formulas"""
        if self._formulas_loaded:
            return
            
        try:
            result = self._run_command(['brew', 'list', '--formula'])
            if result.returncode == 0:
                self._installed_formulas = set(result.stdout.strip().split('\n')) if result.stdout.strip() else set()
            else:
                Logger.warning("Failed to get list of installed formulas")
                self._installed_formulas = set()
        except Exception as e:
            Logger.warning(f"Error loading installed formulas: {e}")
            self._installed_formulas = set()
        
        self._formulas_loaded = True
    
    def _load_installed_casks(self) -> None:
        """Load the list of installed Homebrew casks"""
        if self._casks_loaded:
            return
            
        try:
            result = self._run_command(['brew', 'list', '--cask'])
            if result.returncode == 0:
                self._installed_casks = set(result.stdout.strip().split('\n')) if result.stdout.strip() else set()
            else:
                Logger.warning("Failed to get list of installed casks")
                self._installed_casks = set()
        except Exception as e:
            Logger.warning(f"Error loading installed casks: {e}")
            self._installed_casks = set()
        
        self._casks_loaded = True
    
    def is_formula_installed(self, package: str) -> bool:
        """
        Check if a Homebrew formula is installed
        
        Args:
            package: Package name to check
            
        Returns:
            True if installed, False otherwise
        """
        self._load_installed_formulas()
        return package in self._installed_formulas
    
    def is_cask_installed(self, cask: str) -> bool:
        """
        Check if a Homebrew cask is installed
        
        Args:
            cask: Cask name to check
            
        Returns:
            True if installed, False otherwise
        """
        self._load_installed_casks()
        return cask in self._installed_casks
    
    def install_formula(self, package: str) -> bool:
        """
        Install a single Homebrew formula
        
        Args:
            package: Package name to install
            
        Returns:
            True if successful, False otherwise
        """
        if self.is_formula_installed(package):
            Logger.success(f"{package} already installed")
            return True
        
        Logger.info(f"Installing {package}...")
        try:
            result = self._run_command(['brew', 'install', package], capture_output=False)
            if result.returncode == 0:
                Logger.success(f"{package} installed successfully")
                self._installed_formulas.add(package)
                return True
            else:
                Logger.warning(f"Failed to install {package}")
                return False
        except Exception as e:
            Logger.warning(f"Failed to install {package}: {e}")
            return False
    
    def install_cask(self, cask: str, description: str = None) -> bool:
        """
        Install a single Homebrew cask
        
        Args:
            cask: Cask name to install
            description: Optional description for logging
            
        Returns:
            True if successful, False otherwise
        """
        description = description or cask
        
        if self.skip_cask_apps:
            Logger.info(f"Skipping cask installation: {description}")
            return True
        
        if self.is_cask_installed(cask):
            Logger.success(f"{description} already installed")
            return True
        
        Logger.info(f"Installing {description}...")
        try:
            result = self._run_command([
                'brew', 'install', '--cask', '--appdir=~/Applications', cask
            ], capture_output=False)
            if result.returncode == 0:
                Logger.success(f"{description} installed successfully")
                self._installed_casks.add(cask)
                return True
            else:
                Logger.warning(f"Failed to install {description}")
                return False
        except Exception as e:
            Logger.warning(f"Failed to install {description}: {e}")
            return False
    
    def install_formulas_batch(self, packages: List[str]) -> Tuple[List[str], List[str]]:
        """
        Install multiple Homebrew formulas in batch
        
        Args:
            packages: List of package names to install
            
        Returns:
            Tuple of (successful_packages, failed_packages)
        """
        if not packages:
            return [], []
        
        self._load_installed_formulas()
        
        Logger.info(f"Checking installation status of {len(packages)} packages...")
        
        # Separate installed from missing packages
        missing_packages = []
        for package in packages:
            if package in self._installed_formulas:
                Logger.success(f"{package} already installed")
            else:
                missing_packages.append(package)
        
        successful_packages = [p for p in packages if p in self._installed_formulas]
        failed_packages = []
        
        # Install missing packages in batch if any
        if missing_packages:
            Logger.info(f"Installing {len(missing_packages)} missing packages: {' '.join(missing_packages)}")
            try:
                result = self._run_command(['brew', 'install'] + missing_packages, capture_output=False)
                if result.returncode == 0:
                    for package in missing_packages:
                        Logger.success(f"{package} installed successfully")
                        self._installed_formulas.add(package)
                    successful_packages.extend(missing_packages)
                else:
                    Logger.warning("Some packages may have failed to install - checking individually...")
                    # Fallback to individual installation for failed packages
                    for package in missing_packages:
                        if self.install_formula(package):
                            successful_packages.append(package)
                        else:
                            failed_packages.append(package)
            except Exception as e:
                Logger.warning(f"Batch installation failed: {e} - falling back to individual installation")
                # Fallback to individual installation
                for package in missing_packages:
                    if self.install_formula(package):
                        successful_packages.append(package)
                    else:
                        failed_packages.append(package)
        else:
            Logger.success(f"All {len(packages)} packages already installed")
        
        return successful_packages, failed_packages
    
    def install_casks_batch(self, casks: List[str]) -> Tuple[List[str], List[str]]:
        """
        Install multiple Homebrew casks in batch
        
        Args:
            casks: List of cask names to install
            
        Returns:
            Tuple of (successful_casks, failed_casks)
        """
        if not casks:
            return [], []
        
        if self.skip_cask_apps:
            Logger.info(f"Skipping {len(casks)} cask applications (SKIP_CASK_APPS=true)")
            return [], casks
        
        self._load_installed_casks()
        
        Logger.info(f"Checking installation status of {len(casks)} applications...")
        
        # Separate installed from missing casks
        missing_casks = []
        for cask in casks:
            if cask in self._installed_casks:
                Logger.success(f"{cask} already installed")
            else:
                missing_casks.append(cask)
        
        successful_casks = [c for c in casks if c in self._installed_casks]
        failed_casks = []
        
        # Install missing casks in batch if any
        if missing_casks:
            Logger.info(f"Installing {len(missing_casks)} missing applications: {' '.join(missing_casks)}")
            try:
                result = self._run_command([
                    'brew', 'install', '--cask', '--appdir=~/Applications'
                ] + missing_casks, capture_output=False)
                if result.returncode == 0:
                    for cask in missing_casks:
                        Logger.success(f"{cask} installed successfully")
                        self._installed_casks.add(cask)
                    successful_casks.extend(missing_casks)
                else:
                    Logger.warning("Some applications may have failed to install - checking individually...")
                    # Fallback to individual installation for failed casks
                    for cask in missing_casks:
                        if self.install_cask(cask):
                            successful_casks.append(cask)
                        else:
                            failed_casks.append(cask)
            except Exception as e:
                Logger.warning(f"Batch installation failed: {e} - falling back to individual installation")
                # Fallback to individual installation
                for cask in missing_casks:
                    if self.install_cask(cask):
                        successful_casks.append(cask)
                    else:
                        failed_casks.append(cask)
        else:
            Logger.success(f"All {len(casks)} applications already installed")
        
        return successful_casks, failed_casks
    
    def update_homebrew(self) -> bool:
        """
        Update Homebrew package database
        
        Returns:
            True if successful, False otherwise
        """
        Logger.info("Updating Homebrew...")
        try:
            result = self._run_command(['brew', 'update'], capture_output=False)
            if result.returncode == 0:
                Logger.success("Homebrew updated successfully")
                # Clear cached data since packages may have changed
                self._formulas_loaded = False
                self._casks_loaded = False
                self._installed_formulas.clear()
                self._installed_casks.clear()
                return True
            else:
                Logger.warning("Failed to update Homebrew")
                return False
        except Exception as e:
            Logger.warning(f"Failed to update Homebrew: {e}")
            return False
    
    def is_homebrew_installed(self) -> bool:
        """
        Check if Homebrew is installed
        
        Returns:
            True if Homebrew is available, False otherwise
        """
        try:
            result = self._run_command(['which', 'brew'])
            return result.returncode == 0
        except Exception:
            return False


def main():
    """Main function for command-line usage"""
    import argparse
    
    parser = argparse.ArgumentParser(description='Homebrew Utility for Developer Laboratory Setup')
    parser.add_argument('--skip-cask-apps', action='store_true', 
                        help='Skip cask app installations')
    parser.add_argument('--install-formulas', nargs='+', 
                        help='Install specified formulas')
    parser.add_argument('--install-casks', nargs='+', 
                        help='Install specified casks')
    parser.add_argument('--update', action='store_true', 
                        help='Update Homebrew')
    parser.add_argument('--check-homebrew', action='store_true', 
                        help='Check if Homebrew is installed')
    
    args = parser.parse_args()
    
    brew_util = BrewUtil(skip_cask_apps=args.skip_cask_apps)
    
    if args.check_homebrew:
        if brew_util.is_homebrew_installed():
            Logger.success("Homebrew is installed")
            sys.exit(0)
        else:
            Logger.error("Homebrew is not installed")
            sys.exit(1)
    
    if args.update:
        if not brew_util.update_homebrew():
            sys.exit(1)
    
    if args.install_formulas:
        successful, failed = brew_util.install_formulas_batch(args.install_formulas)
        if failed:
            Logger.error(f"Failed to install formulas: {' '.join(failed)}")
            sys.exit(1)
    
    if args.install_casks:
        successful, failed = brew_util.install_casks_batch(args.install_casks)
        if failed:
            Logger.error(f"Failed to install casks: {' '.join(failed)}")
            sys.exit(1)


if __name__ == '__main__':
    main()