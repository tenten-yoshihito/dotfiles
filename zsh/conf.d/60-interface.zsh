# --- 6. キーバインド ---
# Emacsライク操作（VSCode terminalでも確実に動くよう明示）
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' backward-kill-line
bindkey '^W' backward-kill-word
bindkey '^B' backward-char
bindkey '^F' forward-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^D' delete-char-or-list


# Tabキー(^I)を補完に戻す
bindkey '^I' expand-or-complete
# 提案の確定は右矢印キーに割り当て
bindkey '^[[C' autosuggest-accept

# --- 7. fzf の連携 ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- 8. プロンプト (Powerlevel10kがない場合のフォールバック) ---
PROMPT='%F{cyan}%n%f@%F{green}%m%f:%F{yellow}%~%f
%F{magenta}❯%f '
if (( $+functions[p10k] )); then
    source "$ZSH_CONFIG_ROOT/prompt.zsh"
fi


# Additional upstream word-navigation keys; preserve Ctrl+W and Ctrl+Z behavior.
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
# Upstream spelling prompts alter normal typing, so preserve the existing behavior.
unsetopt correct correct_all
