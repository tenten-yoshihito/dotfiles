#!/bin/zsh -f
# Run after editing sheldon/plugins.toml; startup itself does not use the network.
setopt err_exit
config_root="${0:A:h}"
plugin_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zshrc/neko-sheldon.zsh"
mkdir -p -- "${plugin_cache:h}"
plugin_tmp=$(mktemp "${plugin_cache}.XXXXXX")
trap '[[ -f "$plugin_tmp" ]] && rm -f -- "$plugin_tmp"' EXIT
sheldon --config-dir "$config_root/sheldon" source --relock > "$plugin_tmp"
/bin/zsh -n "$plugin_tmp"
mv -f -- "$plugin_tmp" "$plugin_cache"
print -- 'Plugin cache refreshed. Open a new terminal to use it.'
