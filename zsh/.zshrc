# --- 1. 補完とカラー設定 ---
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- 2. eza (lsの進化系) の設定 ---
if builtin command -v eza > /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -hl --icons --git --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
  alias tree='eza --tree --icons'
fi

# --- 3. bat (catの進化系) の設定 ---
if builtin command -v bat > /dev/null; then
  alias cat='bat'
  # manコマンドもbatで綺麗に表示
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# --- 4. fzf (曖昧検索) の連携 ---
# これを入れると Ctrl+r で履歴を爆速検索できます
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- 5. プラグインの読み込み (パスは環境に合わせて調整) ---
# Homebrewで入れた場合の標準的なパスです
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 6. プロンプト (シンプルで見やすく) ---
PROMPT='%F{cyan}%n%f@%F{green}%m%f:%F{yellow}%~%f
%F{magenta}❯%f '

# --- 7. 履歴設定 ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt share_history

# --- 8. カスタムエイリアス（クリップボードなど） ---
alias clip='pbcopy'
alias paste='pbpaste'

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/yo.nakata/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
eval "$(nodenv init - zsh)"

export EDITOR="vim"
eval "$(direnv hook zsh)"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# --- 8. zsh-autosuggestions の確定をTabキーにする ---
bindkey '^I' autosuggest-accept
