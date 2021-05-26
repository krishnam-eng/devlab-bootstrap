#!/usr/bin/env bash

command code --list-extensions --show-versions >| $HOME/github/ohmy-linux/vscode/extensions-version.list

\cp  $HOME/.config/Code/User/keybindings.json $HOME/github/ohmy-linux/vscode/
\cp  $HOME/.config/Code/User/settings.json $HOME/github/ohmy-linux/vscode/
