# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/sbin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	docker
	iterm2
)

source $ZSH/oh-my-zsh.sh

# vi 모드 (oh-my-zsh 로드 후에 설정)
bindkey -v
export KEYTIMEOUT=1

# jk로 normal 모드 전환
bindkey -M viins 'jk' vi-cmd-mode

# 히스토리 이동
bindkey '^k' up-history
bindkey '^j' down-history

# autosuggestion 수락 (vi 모드에서도 동작)
bindkey -M viins '^y' autosuggest-accept

# 커서 모양: 입력모드=막대, 명령모드=블록
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[1 q'  # 블록
  else
    echo -ne '\e[5 q'  # 막대
  fi
}
zle -N zle-keymap-select

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# conda 블록 제거됨 (pyenv로 대체)

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Task Master aliases added on 2/25/2026
alias tm='task-master'
alias taskmaster='task-master'
alias hamster='task-master'
alias ham='task-master'

# 새 CLI 도구
alias ls='eza'
alias ll='eza -la --git'
alias la='eza -la'
alias cat='bat --style=plain'

# autosuggestions (syntax-highlighting보다 위에 위치)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^y' autosuggest-accept

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --hidden --type f --exclude .git'
export FZF_DEFAULT_OPTS='--height=40% --cycle --border'

# ── 에디터 ───────────────────────────────────────────────────
export EDITOR='nvim'

# ── 기본 단축키 ──────────────────────────────────────────────
alias ..='cd ..'
alias e='exit 0'
alias po='poetry'
alias rp='realpath'

# ── tmux 단축키 (g=git은 oh-my-zsh에서 제공) ─────────────────
alias ta='tmux a'
alias tl='tmux ls'

# ── Magic 약어: 스페이스바로 파이프 자동 완성 ──────────────────
# 예: ls G<Space> → ls | grep
setopt extended_glob
typeset -A abbreviations
abbreviations=(
  "G"  "| grep"
  "X"  "| xargs"
  "T"  "| tail"
  "W"  "| wc"
  "A"  "| awk"
  "S"  "| sed"
  "N"  "> /dev/null"
)
function magic-abbrev-expand () {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}
function no-magic-abbrev-expand () { LBUFFER+=' ' }
zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

# ── 압축 해제 (tar/zip/gz 등 자동 감지) ──────────────────────
function ex () {
  for filename in "$@"; do
    if [ -f "$filename" ]; then
      case "$filename" in
        *.tar.bz2) tar xjf "$filename" ;;
        *.tar.gz)  tar xzf "$filename" ;;
        *.tar.xz)  tar xf  "$filename" ;;
        *.bz2)     bunzip2 "$filename" ;;
        *.gz)      gunzip  "$filename" ;;
        *.tar)     tar xf  "$filename" ;;
        *.zip)     unzip   "$filename" ;;
        *.7z)      7z x    "$filename" ;;
        *.rar)     unrar x "$filename" ;;
        *)         echo "'$filename' 압축 해제 불가" ;;
      esac
    else
      echo "'$filename' 파일 없음"
    fi
  done
}

# ── fzf 최근 디렉토리 이동 (Ctrl+E) ──────────────────────────
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function fzf-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | fzf -q "$LBUFFER" --prompt 'cd > ' +s --preview 'eza -la --color=always {}')"
  if [ -n "$selected_dir" ]; then
    BUFFER=" cd ${selected_dir}"
    zle accept-line
  else
    BUFFER=''
    zle accept-line
  fi
}
zle -N fzf-cdr
bindkey '^E' fzf-cdr

# ── tvim: tmux 세션 + nvim 통합 ───────────────────────────────
function tvim() {
  local dir="${1:-.}"
  cd "$dir"
  local workdir="$(basename $PWD)"
  if tmux has-session -t "=$workdir" 2>/dev/null; then
    tmux switch-client -t "$workdir" 2>/dev/null || tmux attach -t "$workdir"
    return 0
  fi
  tmux new-session -s "$workdir" -d
  tmux send-keys -t "$workdir" "nvim ." ENTER
  tmux switch-client -t "$workdir" 2>/dev/null || tmux attach -t "$workdir"
}

# ── Bazel 래퍼 ───────────────────────────────────────────────
function br () {
  local p="$(realpath --relative-to="$PWD" "$1")" j="$2" s='2'
  if [ -z "$j" ] && [[ -f "$p" ]]; then j="${p:t:r}"; p="$(dirname "$p")"; s='1'; fi
  ([ -z "$p" ] || [ -z "$j" ]) && echo "사용법: br <경로> <타겟>" && return
  shift "$s"
  echo "$ bazel run //${p}:${j} $@"
  bazel run "//${p}:${j}" "$@"
}
function bt () {
  local p="$(realpath --relative-to="$PWD" "$1")"
  [ -z "$p" ] && echo "사용법: bt <경로>" && return
  shift 1
  echo "$ bazel test //${p} $@"
  bazel test "//${p}" "$@"
}

# ── kubectl ───────────────────────────────────────────────────
function k () {
  if [[ -n "$CONTEXT" && -n "$NAMESPACE" && "$#" -gt 0 ]]; then
    kubectl --context="$CONTEXT" -n "$NAMESPACE" "$@"
  else
    kubectl "$@"
  fi
}
function klogf () {
  local pod="$(k get pods -o name | grep "$1" | head -n 1 | cut -d '/' -f 2)"
  [ -z "$pod" ] && echo "Pod 없음: $1" && return 1
  shift 1
  k logs -f "$pod" "$@"
}

# ── JWT 디코딩 ────────────────────────────────────────────────
function jwtd () {
  echo "${1}" | jq -R 'split(".") | .[0],.[1] | @base64d | fromjson'
}

# Ctrl+S XOFF flow control 비활성화 (tmux prefix Ctrl+S 충돌 방지)
stty -ixon 2>/dev/null

# ── cd 오버라이드: Python 가상환경 자동 활성화/비활성화 ───────────
function cd () {
  builtin cd "$@" || return
  # .venv 또는 venv 디렉토리가 있으면 자동 활성화
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  elif [[ -f "venv/bin/activate" ]]; then
    source venv/bin/activate
  # pyproject.toml이 있고 poetry 환경이 있으면 활성화
  elif [[ -f "pyproject.toml" ]] && command -v poetry &>/dev/null; then
    local venv_path="$(poetry env info --path 2>/dev/null)"
    if [[ -n "$venv_path" && -f "$venv_path/bin/activate" ]]; then
      source "$venv_path/bin/activate"
    fi
  # 가상환경 디렉토리를 벗어나면 deactivate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_parent="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD" != "$venv_parent"* ]]; then
      deactivate 2>/dev/null
    fi
  fi
}

# ── 유틸리티 함수 ─────────────────────────────────────────────
# 현재 디렉토리를 HTTP 서버로 서빙
function serve () {
  local port="${1:-8000}"
  echo "http://localhost:${port} 에서 서버 시작"
  python3 -m http.server "$port"
}

# 명령어 설명 (man + tldr 통합)
function def () {
  if command -v tldr &>/dev/null; then
    tldr "$1" 2>/dev/null || man "$1"
  else
    man "$1"
  fi
}

# 안전 삭제: 휴지통으로 이동
function trm () {
  if command -v trash &>/dev/null; then
    trash "$@"
  else
    echo "trash 미설치. brew install trash 로 설치하세요"
    echo "삭제하지 않았습니다: $@"
  fi
}

# 웹 검색
function ? () {
  open "https://duckduckgo.com/?q=$(echo "$@" | sed 's/ /+/g')"
}
function ?? () {
  open "https://www.google.com/search?q=$(echo "$@" | sed 's/ /+/g')"
}

# JWT 확장 디코딩 (헤더 + 페이로드 + 만료시간)
function jwtx () {
  local token="$1"
  echo "=== Header ===" && echo "$token" | jq -R 'split(".") | .[0] | @base64d | fromjson'
  echo "=== Payload ===" && echo "$token" | jq -R 'split(".") | .[1] | @base64d | fromjson'
  local exp=$(echo "$token" | jq -R 'split(".") | .[1] | @base64d | fromjson | .exp // empty' 2>/dev/null)
  if [[ -n "$exp" ]]; then
    echo "=== 만료시간 ===" && date -r "$exp" 2>/dev/null || date -d "@$exp" 2>/dev/null
  fi
}

# ── local 설정 (기기별 환경변수, 회사 전용 설정) ──────────────
[[ -f ~/.config/zsh/local_rc.zsh ]] && source ~/.config/zsh/local_rc.zsh
