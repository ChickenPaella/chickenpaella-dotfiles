# ── alias 모음 ────────────────────────────────────────────────
# .zshrc에서 source됨

# ── CLI 도구 대체 (설치된 경우에만) ──────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza'
  alias l='eza -l'
  alias ll='eza -la --git'
  alias la='eza -la'
  alias lt='eza --tree --level=2'
else
  alias l='ls -lh'
  alias ll='ls -lah'
fi
if command -v bat &>/dev/null; then
  alias cat='bat --style=plain'
fi

# ── 탐색 ─────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias rp='realpath'

# ── 편집기 ───────────────────────────────────────────────────
alias v='nvim'
alias vi='nvim'

# ── 셸 ───────────────────────────────────────────────────────
alias e='exit 0'
alias reload='source ~/.zshrc'

# ── tmux ─────────────────────────────────────────────────────
alias ta='tmux a'
alias tl='tmux ls'
alias tn='tmux new-session -s'

# ── Python ───────────────────────────────────────────────────
if command -v poetry &>/dev/null; then
  alias po='poetry'
  alias por='poetry run'
  alias poi='poetry install'
  alias poa='poetry add'
fi

# ── git (oh-my-zsh git plugin 없이도 동작) ───────────────────
# oh-my-zsh git plugin이 있으면 대부분 중복이지만 명시적으로 유지
alias g='git'

# ── 네트워크 ─────────────────────────────────────────────────
alias myip='curl -s https://ipinfo.io/ip && echo'

# ── 유틸 ─────────────────────────────────────────────────────
alias cl='clear'
alias path='echo $PATH | tr ":" "\n"'      # PATH를 줄별로 출력
alias now='date "+%Y-%m-%d %H:%M:%S"'
