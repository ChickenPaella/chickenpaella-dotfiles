# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Oh My Zsh ─────────────────────────────────────────────────
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git docker)
source "$ZSH/oh-my-zsh.sh"

# ── vi 모드 (oh-my-zsh 로드 후 설정) ─────────────────────────
bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode  # jk로 normal 모드
bindkey '^k' up-history
bindkey '^j' down-history
bindkey -M viins '\ey' autosuggest-accept

# Ctrl+S XOFF 비활성화 (tmux prefix Ctrl+S 충돌 방지)
stty -ixon 2>/dev/null

# ── 패키지 관리자 ─────────────────────────────────────────────
# pyenv
if command -v pyenv &>/dev/null || [[ -d "$PYENV_ROOT" ]]; then
  export PYENV_ROOT="${PYENV_ROOT:-$HOME/.local/share/pyenv}"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# nvm
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$(brew --prefix nvm 2>/dev/null)/nvm.sh" ]] && source "$(brew --prefix nvm)/nvm.sh"
fi

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# ── 플러그인 ──────────────────────────────────────────────────
# zsh-autosuggestions (syntax-highlighting보다 먼저 로드)
for f in \
  "$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /usr/share/zsh-autosuggestions/autosuggestions.zsh; do
  [[ -f "$f" ]] && source "$f" && break
done
# Alt+Y로 추천 수락 (WezTerm send_composed_key=false → Alt가 \ey 전송)
bindkey '\ey' autosuggest-accept
bindkey -M viins '\ey' autosuggest-accept
# Gruvbox 배경에서 추천 텍스트 가시성 향상 (기본 fg=8 대신 명시적 지정)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'

# zsh-syntax-highlighting (항상 마지막에 로드)
for f in \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [[ -f "$f" ]] && source "$f" && break
done

# fzf
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND='fd --hidden --type f --exclude .git'
  export FZF_DEFAULT_OPTS='--height=40% --cycle --border'
fi

# ── alias & 함수 로드 ─────────────────────────────────────────
ZDOTDIR_CONFIG="${ZDOTDIR:-$HOME/.config/zsh}"
[[ -f "$ZDOTDIR_CONFIG/aliases.zsh" ]] && source "$ZDOTDIR_CONFIG/aliases.zsh"

# dotfiles의 zsh 설정 디렉토리에서 로드
DOTFILES_ZSH="${DOTFILES:-$HOME/dotfiles}/config/zsh"
[[ -f "$DOTFILES_ZSH/aliases.zsh" ]]   && source "$DOTFILES_ZSH/aliases.zsh"
[[ -f "$DOTFILES_ZSH/functions.zsh" ]] && source "$DOTFILES_ZSH/functions.zsh"

# ── p10k 테마 ─────────────────────────────────────────────────
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── 기기별 설정 (API 키, 회사 전용 등) ───────────────────────
[[ -f ~/.config/zsh/local_rc.zsh ]] && source ~/.config/zsh/local_rc.zsh
