# Adapted from upstream/common/zsh/.zshrc.
# General settings
# ref: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt autoremoveslash
setopt no_beep

# Expansion and Globbing
setopt extended_glob
setopt glob_dots
setopt ksh_glob
setopt numeric_glob_sort

# Scripts
setopt interactive_comments

# Completion
# ref: https://zenn.dev/i9wa4/articles/2026-01-01-zsh-startup-optimization-compinit
autoload -Uz compinit
typeset -g _zcompdump="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/.zcompdump-${HOST}-${ZSH_VERSION}"
[[ -d "${_zcompdump:h}" ]] || mkdir -p "${_zcompdump:h}"
if [[ ! -r "${_zcompdump}" || -n "${_zcompdump}"(#qN.mh+24) ||
      "${XDG_CACHE_HOME:-$HOME/.cache}/zshrc/neko-sheldon.zsh" -nt "$_zcompdump" ]]; then
    compinit -d "${_zcompdump}"
    touch "${_zcompdump}"
else
    compinit -C -d "${_zcompdump}"
fi
unset -v _zcompdump

# Match both lowercase and uppercase letters during completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
# Prevent zsh's fallback from restoring ignored paths when nothing else matches.
zstyle ':completion:*' completer _complete
zstyle ':completion:*:(*files|*directories)' ignored-patterns \
    '(|*/)(.git|.ruff_cache|.pytest_cache|.venv|__pycache__|.DS_Store)(|/)'
# Correct typos
setopt correct
setopt correct_all


# Keep existing AUTO_CD and completion colors.
setopt auto_cd
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

function _local_command_completions() {
    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zshrc"
    local tool completion_file
    for tool in uv uvx gh; do
        (( $+commands[$tool] )) || continue
        completion_file="$cache_dir/$tool-completion.zsh"
        case $tool in
            uv) __update_cache uv "$completion_file" -- generate-shell-completion zsh ;;
            uvx) __update_cache uvx "$completion_file" -- --generate-shell-completion zsh ;;
            gh) __update_cache gh "$completion_file" -- completion -s zsh ;;
        esac
        [[ -r "$completion_file" ]] && source "$completion_file"
    done
    for completion_file in "$HOME"/.zfunc/_*~*.zwc(N-.); do
        source "$completion_file"
    done
}
_local_command_completions
unfunction _local_command_completions
if (( $+functions[_uv] )); then
    function _uv_run_mod() {
        if [[ "$words[2]" == run && "$words[CURRENT]" != -* ]]; then
            _arguments '*:filename:_files -g "*.py"'
        else
            _uv "$@"
        fi
    }
    compdef _uv_run_mod uv
fi
