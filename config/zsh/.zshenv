# ── XDG Base Directory ────────────────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# zshrc 위치를 XDG 경로로 지정
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ── 언어/편집기 ───────────────────────────────────────────────
export EDITOR='nvim'
export LANG='en_US.UTF-8'

# ── 도구별 XDG 경로 ───────────────────────────────────────────
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# ── Python ────────────────────────────────────────────────────
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"

# ── PATH ──────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
