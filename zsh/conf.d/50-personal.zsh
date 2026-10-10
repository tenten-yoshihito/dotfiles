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
alias act='source .venv/bin/activate'

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

# Add upstream diff helpers only when already installed.
(( $+commands[colordiff] )) && alias diff='colordiff -u'
(( $+commands[icdiff] )) && alias icdiff='icdiff -U 1 --line-numbers'
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

