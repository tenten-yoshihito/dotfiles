# Generate explicitly after changing plugins.toml; normal startup stays offline.
typeset -g _local_plugin_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zshrc/neko-sheldon.zsh"
if [[ -r "$_local_plugin_cache" ]]; then
    source "$_local_plugin_cache"
else
    # Keep the shell usable while bootstrapping or recovering the plugin cache.
    [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
unset _local_plugin_cache
