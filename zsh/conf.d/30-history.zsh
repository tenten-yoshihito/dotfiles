# History settings
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(cd|pushd|popd|mkdir|pwd|exit|clear|man|history|kill|less|cat|git branch -d|git branch -m)(| *)"
# Avoid duplicate entries in history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_ignore_space
# Remove extra blanks in history entries
setopt hist_reduce_blanks
# Share history between all sessions
# Write to the history file immediately, not when the shell exits
# inc_append_history should be turned off when using share_history
setopt share_history
setopt append_history
setopt extended_history
setopt hist_fcntl_lock


source "$ZSH_CONFIG_ROOT/upstream/common/zsh/history.sh"
# The helpers use only the standard library: avoid uv project resolution on prompts.
function __python_runner() {
    emulate -L zsh
    reply=()
    [[ -f "$1" ]] || return 1
    if (( $+commands[python3] )); then
        reply=("${commands[python3]}" "$1")
    elif [[ -x /usr/bin/python3 ]]; then
        reply=(/usr/bin/python3 "$1")
    else
        return 1
    fi
}
