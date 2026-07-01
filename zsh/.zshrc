eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 1. 補完パスの設定 (compinitより前に書く必要があるもの) ---
# Dockerの補完などを読み込みパスに追加
fpath=(/Users/yo.nakata/.docker/completions $fpath)

# --- 2. 補完とカラー設定 ---
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# 補完候補を矢印キーで選べるようにする（便利です）
zstyle ':completion:*' menu select

# --- 3. eza の設定 ---
if builtin command -v eza > /dev/null; then
  alias l='eza --icons --group-directories-first'
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
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
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

alias theme='~/Desktop/Theme'
alias dwn='~/Downloads'
alias paper='~/Desktop/Theme/papers'
alias ver-1='~/Desktop/Theme/ver-1'
alias memo='~/Desktop/Theme/memos'
alias dino='~/Desktop/Theme/dinov2'

alias zsh='vi ~/.zshrc'

alias gb='git branch'

chrome() {
    # 引数（URLまたはファイル名）がない場合は、普通にChromeを開く
    if [ -z "$1" ]; then
        open -a "Google Chrome" --args --incognito
        return
    fi

    # 入力された文字列が「http」で始まるか、または実際のファイルとして存在するかチェック
    if [[ "$1" =~ ^https?:// ]] || [ -e "$1" ]; then
        # そのまま開く
        open -a "Google Chrome" "$1" --args --incognito
    else
        # 相対パス（例: index.html）を絶対パスに変換して開く（Chromeのバグ対策）
        open -a "Google Chrome" "$(greadlink -f "$1" 2>/dev/null || realpath "$1")" --args --incognito
    fi
}

settoken() {
    if [ -z "$1" ]; then
      echo "トークンを指定してください ex) settoken <JWT>"
    else
        export AUTH_TOKEN="$1"
        echo "AUTH_TOKEN を更新しました"
    fi
}
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

# --- 13. その他の環境設定 ---
export EDITOR="vim"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"
export PATH=/opt/homebrew/opt/libpq/bin:"$PATH"
export PATH="/Library/TeX/texbin:$PATH"

# -- 14. option --
setopt AUTO_CD
