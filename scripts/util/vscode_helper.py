#!/usr/bin/env python3
"""
VS Code Utility Module for Developer Laboratory Setup

This module provides functions for managing VS Code extensions and settings,
including capture, install, sync, backup, and diff operations, similar to the Homebrew helper.

Author: Balamurugan Krishnamoorthy
"""
import os
import sys
import subprocess
from datetime import datetime
from typing import List, Tuple

class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'

class Logger:
    @staticmethod
    def info(message: str) -> None:
        print(f"{Colors.BLUE}[INFO]{Colors.NC} {message}")
    @staticmethod
    def success(message: str) -> None:
        print(f"{Colors.GREEN}[SUCCESS]{Colors.NC} {message}")
    @staticmethod
    def warning(message: str) -> None:
        print(f"{Colors.YELLOW}[WARNING]{Colors.NC} {message}")
    @staticmethod
    def error(message: str) -> None:
        print(f"{Colors.RED}[ERROR]{Colors.NC} {message}")

class VSCodeUtil:
    def __init__(self, extensions_file: str, backup_dir: str):
        self.extensions_file = extensions_file
        self.backup_dir = backup_dir
        os.makedirs(self.backup_dir, exist_ok=True)

    def _run_command(self, command: List[str], capture_output: bool = True) -> subprocess.CompletedProcess:
        try:
            result = subprocess.run(
                command,
                capture_output=capture_output,
                text=True,
                timeout=120
            )
            return result
        except Exception as e:
            Logger.error(f"Command failed: {' '.join(command)}: {e}")
            raise

    def check_vscode_cli(self) -> bool:
        result = self._run_command(['which', 'code'])
        if result.returncode == 0:
            return True
        Logger.error("VS Code CLI 'code' command not found. Please install VS Code and add 'code' to PATH.")
        return False

    def capture_extensions(self) -> None:
        Logger.info("Capturing currently installed VS Code extensions...")
        backup_file = os.path.join(self.backup_dir, f"extensions-backup-{datetime.now().strftime('%Y%m%d-%H%M%S')}.txt")
        if os.path.isfile(self.extensions_file):
            os.replace(self.extensions_file, backup_file)
            Logger.warning(f"Created backup: {os.path.basename(backup_file)}")
        result = self._run_command(['code', '--list-extensions', '--show-versions'])
        if result.returncode == 0:
            with open(self.extensions_file, 'w') as f:
                f.write(result.stdout)
            Logger.success(f"Captured {len(result.stdout.splitlines())} extensions to extensions.txt")
        else:
            Logger.error("Failed to capture extensions.")

    def get_installed_extensions(self) -> List[str]:
        result = self._run_command(['code', '--list-extensions'])
        if result.returncode == 0:
            return result.stdout.strip().split('\n')
        return []

    def install_missing_extensions(self) -> Tuple[int, int, int]:
        Logger.info("Installing missing VS Code extensions...")
        if not os.path.isfile(self.extensions_file):
            Logger.warning("extensions.txt not found. Capturing current extensions first...")
            self.capture_extensions()
        installed_count = 0
        skipped_count = 0
        error_count = 0
        current_extensions = set(self.get_installed_extensions())
        with open(self.extensions_file) as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                extension_id = line.split('@')[0]
                if extension_id in current_extensions:
                    Logger.warning(f"Skipping {extension_id} (already installed)")
                    skipped_count += 1
                else:
                    Logger.info(f"Installing {extension_id}...")
                    result = self._run_command(['code', '--install-extension', extension_id, '--force'], capture_output=False)
                    if result.returncode == 0:
                        Logger.success(f"Installed {extension_id}")
                        installed_count += 1
                    else:
                        Logger.error(f"Failed to install {extension_id}")
                        error_count += 1
        Logger.success(f"Installation complete: Installed={installed_count}, Skipped={skipped_count}, Errors={error_count}")
        return installed_count, skipped_count, error_count

    def backup_extensions(self) -> None:
        Logger.info("Creating backup of current extensions...")
        backup_file = os.path.join(self.backup_dir, f"extensions-backup-{datetime.now().strftime('%Y%m%d-%H%M%S')}.txt")
        result = self._run_command(['code', '--list-extensions', '--show-versions'])
        if result.returncode == 0:
            with open(backup_file, 'w') as f:
                f.write(result.stdout)
            Logger.success(f"Backup created: {os.path.basename(backup_file)}")
        else:
            Logger.error("Failed to create backup.")

    def diff_extensions(self) -> None:
        Logger.info("Comparing installed vs configured extensions...")
        if not os.path.isfile(self.extensions_file):
            Logger.error("extensions.txt not found.")
            return
        temp_current = os.path.join('/tmp', 'vscode-current-extensions.txt')
        result = self._run_command(['code', '--list-extensions', '--show-versions'])
        if result.returncode == 0:
            with open(temp_current, 'w') as f:
                f.write(result.stdout)
            import difflib
            with open(self.extensions_file) as f1, open(temp_current) as f2:
                diff = list(difflib.unified_diff(f1.readlines(), f2.readlines(), fromfile='extensions.txt', tofile='current'))
            if not diff:
                Logger.success("No differences found. Extensions are in sync.")
            else:
                Logger.info("Differences:")
                for line in diff:
                    print(line, end='')
            os.remove(temp_current)
        else:
            Logger.error("Failed to get current extensions.")

    def link_settings(self, hrt_settings: str, user_settings: str) -> None:
        # Removed: Settings linking is handled by the provision script
        Logger.warning("Settings linking should be handled by the provision script, not this utility")
        pass

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='VS Code Utility for Developer Laboratory Setup')
    parser.add_argument('--capture', action='store_true', help='Capture currently installed extensions')
    parser.add_argument('--install', action='store_true', help='Install missing extensions from extensions.txt')
    parser.add_argument('--backup', action='store_true', help='Backup current extensions')
    parser.add_argument('--diff', action='store_true', help='Diff installed vs configured extensions')
    parser.add_argument('--link-settings', nargs=2, metavar=('HRT_SETTINGS', 'USER_SETTINGS'), help='Link VSCode settings.json (deprecated - use provision script)')
    parser.add_argument('--extensions-file', default=os.path.expanduser('~/sys/hrt/conf/vscode/extensions.txt'))
    parser.add_argument('--backup-dir', default=os.path.expanduser('~/sys/hrt/scripts'))
    args = parser.parse_args()
    util = VSCodeUtil(args.extensions_file, args.backup_dir)
    if not util.check_vscode_cli():
        sys.exit(1)
    if args.capture:
        util.capture_extensions()
    if args.install:
        util.install_missing_extensions()
    if args.backup:
        util.backup_extensions()
    if args.diff:
        util.diff_extensions()
    if args.link_settings:
        Logger.warning("Settings linking is deprecated in this utility - use provision script instead")
        util.link_settings(args.link_settings[0], args.link_settings[1])
