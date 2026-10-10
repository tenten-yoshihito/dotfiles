# Existing machine-specific environment, before plugin/completion setup.
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
typeset -gU path fpath
export EDITOR=vim
export GOPATH="$HOME/go"
path=(/Library/TeX/texbin /opt/homebrew/opt/libpq/bin /opt/homebrew/share/google-cloud-sdk/bin $path "$GOPATH/bin")
fpath=("$ZSH_CONFIG_ROOT/upstream/common/zsh/functions" $fpath)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)
[[ -d "$HOME/.zfunc" ]] && fpath=("$HOME/.zfunc" $fpath)
autoload -Uz __warn __info __update_cache
