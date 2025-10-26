#!/usr/bin/env bash
set -euo pipefail

repo_root_dir="$(cd "$(dirname "$0")/.." && pwd)"

cd "$repo_root_dir"

git config core.hooksPath .githooks
echo "Configured core.hooksPath to .githooks for repository at: $repo_root_dir"

# Ensure local config aligns now
git config pull.rebase true
git config pull.ff only
git config rebase.autoStash true
git config rebase.autoSquash true

echo "Repo git config updated to enforce linear history defaults."


