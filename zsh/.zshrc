# Neko-nos/configs base + personal compatibility layer.
# Edit conf.d/*.zsh for settings, sheldon/plugins.toml for plugins.
typeset -g ZSH_CONFIG_ROOT="${${(%):-%N}:A:h}"
source "$ZSH_CONFIG_ROOT/conf.d/00-environment.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/10-plugins.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/20-options-completion.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/30-history.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/40-functions.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/50-personal.zsh"
source "$ZSH_CONFIG_ROOT/conf.d/60-interface.zsh"
