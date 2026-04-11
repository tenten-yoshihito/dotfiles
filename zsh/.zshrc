eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 1. 補完パスの設定 (compinitより前に書く必要があるもの) ---
# Dockerの補完などを読み込みパスに追加
fpath=(/Users/nakata-yoshihito/.docker/completions $fpath)

# --- 2. 補完とカラー設定 ---
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# 補完候補を矢印キーで選べるようにする（便利です）
zstyle ':completion:*' menu select

# --- 3. eza の設定 ---
if builtin command -v eza > /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -hl --icons --git --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
  alias tree='eza --tree --icons'
fi

# --- 4. bat の設定 ---
if builtin command -v bat > /dev/null; then
  alias cat='bat'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# --- 5. プラグインの読み込み (補完設定の後に書く) ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 6. キーバインド (ここが重要！) ---
# Tabキー(^I)を補完に戻す
bindkey '^I' expand-or-complete
# 提案の確定は「右矢印キー」または「Ctrl + F」に割り当て
bindkey '^[[C' autosuggest-accept
bindkey '^F' autosuggest-accept

# --- 7. fzf の連携 ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- 8. プロンプト ---
PROMPT='%F{cyan}%n%f@%F{green}%m%f:%F{yellow}%~%f
%F{magenta}❯%f '

# --- 9. 履歴設定 ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt share_history

# --- 10. カスタムエイリアス ---
alias clip='pbcopy'
alias paste='pbpaste'

# --- 11. 外部ツールの初期化 ---
# nodenv
if builtin command -v nodenv > /dev/null; then
  eval "$(nodenv init - zsh)"
fi

# direnv
if builtin command -v direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# zoxide
if builtin command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# --- 12. ssh ---
# 初回起動時に鍵を追加（パスフレーズ入力を省く）
ssh-add --apple-use-keychain ~/.ssh/id_rsa 2>/dev/null
