#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/hrt/boot/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# When using Powerlevel10k with instant prompt, console output during zsh initialization may indicate issues.
# Suppress this warning either by running p10k configure or by manually defining the following parameter:
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet