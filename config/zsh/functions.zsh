# ── zsh 함수 모음 ─────────────────────────────────────────────
# .zshrc에서 source됨

# ── vi 모드 커서: 입력=막대, 명령=블록 ───────────────────────
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[1 q'  # 블록
  else
    echo -ne '\e[5 q'  # 막대
  fi
}
zle -N zle-keymap-select

# ── vi 모드 커서 이동: nvim 스타일 ──────────────────────────────
# H/L: 줄 처음/끝 (nvim의 H/L과 동일)
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

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

# ── fzf 최근 디렉토리 이동 (Ctrl+E) ──────────────────────────
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function fzf-cdr () {
  local preview_cmd
  if command -v eza &>/dev/null; then
    preview_cmd='eza -la --color=always {}'
  else
    preview_cmd='ls -la {}'
  fi
  local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | fzf -q "$LBUFFER" --prompt 'cd > ' +s --preview "$preview_cmd")"
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

# ── tvim: tmux 세션 + nvim(좌) + 터미널(우) 레이아웃 ──────────
function tvim() {
  local dir="${1:-.}"
  cd "$dir"
  local workdir="$(basename $PWD)"
  local session="${workdir//[^a-zA-Z0-9_-]/_}"
  # 이미 세션 있으면 그냥 붙기
  if tmux has-session -t "=$session" 2>/dev/null; then
    tmux switch-client -t "$session" 2>/dev/null || tmux attach -t "$session"
    return 0
  fi
  # 새 세션: 좌(nvim) + 우(터미널) 레이아웃
  tmux new-session -s "$session" -d
  tmux send-keys -t "$session" "nvim ." ENTER
  # 오른쪽에 터미널 패널 추가 (전체 너비의 30%)
  tmux split-window -t "$session" -h -p 30
  # 포커스를 nvim 패널(왼쪽)로 되돌리기
  tmux select-pane -t "$session:.0"
  tmux switch-client -t "$session" 2>/dev/null || tmux attach -t "$session"
}

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

# ── cd 오버라이드: Python 가상환경 자동 활성화/비활성화 ────────
function cd () {
  builtin cd "$@" || return
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  elif [[ -f "venv/bin/activate" ]]; then
    source venv/bin/activate
  elif [[ -f "pyproject.toml" ]] && command -v poetry &>/dev/null; then
    local venv_path="$(poetry env info --path 2>/dev/null)"
    if [[ -n "$venv_path" && -f "$venv_path/bin/activate" ]]; then
      source "$venv_path/bin/activate"
    fi
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_parent="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD" != "$venv_parent"* ]]; then
      deactivate 2>/dev/null
    fi
  fi
}

# ── HTTP 서버 ─────────────────────────────────────────────────
function serve () {
  local port="${1:-8000}"
  echo "http://localhost:${port} 에서 서버 시작"
  python3 -m http.server "$port"
}

# ── 명령어 설명 (man + tldr 통합) ────────────────────────────
function def () {
  if command -v tldr &>/dev/null; then
    tldr "$1" 2>/dev/null || man "$1"
  else
    man "$1"
  fi
}

# ── 안전 삭제: 휴지통으로 이동 ───────────────────────────────
function trm () {
  if command -v trash &>/dev/null; then
    trash "$@"
  else
    echo "trash 미설치. brew install trash 로 설치하세요"
    echo "삭제하지 않았습니다: $@"
  fi
}

# ── 웹 검색 ──────────────────────────────────────────────────
function s () {
  open "https://duckduckgo.com/?q=$(echo "$@" | sed 's/ /+/g')"
}
function sg () {
  open "https://www.google.com/search?q=$(echo "$@" | sed 's/ /+/g')"
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

# ── kubectl 래퍼 ─────────────────────────────────────────────
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

# ── Git Worktree 관리 ────────────────────────────────────────
# wt           : worktree 목록
# wtadd <브랜치> : 새 worktree 생성 (../프로젝트-브랜치명 디렉토리)
# wtrm <브랜치>  : worktree 삭제
# wts          : fzf로 worktree 선택 후 이동
function wt () {
  git worktree list
}
function wtadd () {
  [ -z "$1" ] && echo "사용법: wtadd <브랜치명>" && return 1
  local branch="$1"
  local root="$(git rev-parse --show-toplevel)"
  local project="$(basename "$root")"
  local safe_branch="${branch//\//-}"   # feat/login → feat-login
  local target="$(dirname "$root")/${project}__${safe_branch}"
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$target" "$branch"
  else
    git worktree add -b "$branch" "$target"
  fi
  echo "→ $target"
}
function wtrm () {
  [ -z "$1" ] && echo "사용법: wtrm <브랜치명>" && return 1
  local branch="$1"
  local target
  target=$(git worktree list | awk -v b="[$branch]" '$3==b {print $1}')
  [ -z "$target" ] && echo "worktree 없음: $branch" && return 1
  git worktree remove --force "$target" && echo "삭제됨: $target"
}
function wts () {
  local selected
  selected=$(git worktree list | fzf --prompt='worktree > ' | awk '{print $1}')
  [ -n "$selected" ] && cd "$selected"
}
function wtvim () {
  [ -z "$1" ] && echo "사용법: wtvim <브랜치명>" && return 1
  local branch="$1"
  local root="$(git rev-parse --show-toplevel)"
  local project="$(basename "$root")"
  local safe_branch="${branch//\//-}"
  local target="$(dirname "$root")/${project}__${safe_branch}"

  # worktree 없으면 생성
  if ! git worktree list | grep -q "$target"; then
    wtadd "$branch"
  fi

  # 현재 세션에 새 window 추가 (tvim 레이아웃: 좌 nvim 70% + 우 터미널 30%)
  local window_name="${safe_branch}"
  local session="$(tmux display-message -p '#S')"
  tmux new-window -t "$session" -n "$window_name" -c "$target"
  tmux send-keys -t "$session:$window_name" "nvim ." ENTER
  tmux split-window -t "$session:$window_name" -h -p 30 -c "$target"
  tmux select-pane -t "$session:$window_name.0"
  echo "→ window: $window_name"
}

# ── JWT 디코딩 ────────────────────────────────────────────────
function jwtd () {
  echo "${1}" | jq -R 'split(".") | .[0],.[1] | @base64d | fromjson'
}
function jwtx () {
  local token="$1"
  echo "=== Header ===" && echo "$token" | jq -R 'split(".") | .[0] | @base64d | fromjson'
  echo "=== Payload ===" && echo "$token" | jq -R 'split(".") | .[1] | @base64d | fromjson'
  local exp=$(echo "$token" | jq -R 'split(".") | .[1] | @base64d | fromjson | .exp // empty' 2>/dev/null)
  if [[ -n "$exp" ]]; then
    echo "=== 만료시간 ===" && date -r "$exp" 2>/dev/null || date -d "@$exp" 2>/dev/null
  fi
}
