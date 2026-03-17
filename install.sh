#!/usr/bin/env zsh
# dotfiles 설치 스크립트
# 새 맥북에서: git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh

set -e
DOTFILES="${DOTFILES:-$HOME/dotfiles}"

echo "📦 dotfiles 설치 시작..."

# ── Homebrew 확인/설치 ────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Oh My Zsh 설치 ────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh 설치 중..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── 필수 도구 설치 ────────────────────────────────────────────
echo "\n📥 필수 도구 설치 중..."
brew install \
  neovim \
  git \
  fzf \
  fd \
  ripgrep \
  tmux \
  jq \
  gh \
  tree \
  zsh-autosuggestions \
  zsh-syntax-highlighting

# ── 선택적 도구 (있으면 좋은 것들) ───────────────────────────
echo "\n📥 CLI 개선 도구 설치 중..."
brew install eza bat trash tldr nvm || true  # 실패해도 계속

# ── Python 개발 환경 ──────────────────────────────────────────
echo "\n🐍 Python 도구 설치 중..."
brew install pyenv || true
if command -v pyenv &>/dev/null; then
  pyenv install 3.12 --skip-existing 2>/dev/null || true
  pyenv global 3.12 2>/dev/null || true
fi
brew install poetry || true

# ── 폰트 ─────────────────────────────────────────────────────
echo "\n🔤 Nerd Font 설치 중..."
brew install --cask font-jetbrains-mono-nerd-font || true

# ── macOS 전용 앱 ─────────────────────────────────────────────
if [[ "$(uname)" == "Darwin" ]]; then
  echo "\n🍎 macOS 앱 설치 중..."
  brew install --cask wezterm || true
  brew tap nikitabobko/tap 2>/dev/null && brew install --cask aerospace || true
fi

# ── 심볼릭 링크 생성 ──────────────────────────────────────────
link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  백업: ${dst}.backup"
  fi
  ln -sf "$src" "$dst"
  echo "  링크: $dst → $src"
}

echo "\n🔗 심볼릭 링크 생성 중..."
link config/zsh/.zshenv         ~/.zshenv
link config/zsh/.zshrc          ~/.zshrc
# ZDOTDIR=~/.config/zsh 이므로 zsh가 이 경로에서 .zshrc를 찾음
link config/zsh/.zshrc          ~/.config/zsh/.zshrc
link config/tmux/tmux.conf      ~/.config/tmux/tmux.conf
link config/git/config          ~/.config/git/config
link config/git/ignore          ~/.config/git/ignore
link config/nvim                ~/.config/nvim

# Python REPL 설정
mkdir -p ~/.config/python
link config/python/pythonrc.py  ~/.config/python/pythonrc.py

# macOS 전용 링크
if [[ "$(uname)" == "Darwin" ]]; then
  link config/wezterm/wezterm.lua      ~/.config/wezterm/wezterm.lua
  link config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
fi

# ── local_rc 초기화 ───────────────────────────────────────────
if [[ ! -f ~/.config/zsh/local_rc.zsh ]]; then
  mkdir -p ~/.config/zsh
  cp "$DOTFILES/config/zsh/local_rc.template.zsh" ~/.config/zsh/local_rc.zsh
  echo "\n⚠️  ~/.config/zsh/local_rc.zsh 를 편집해서 API 키 등을 설정하세요"
fi

# ── Neovim 플러그인 설치 (선택) ───────────────────────────────
if command -v nvim &>/dev/null; then
  echo "\n🔌 Neovim 플러그인 설치 중..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
fi

echo "\n✅ 설치 완료!"
echo "   다음 단계:"
echo "   1. ~/.config/zsh/local_rc.zsh 편집 (API 키, 회사 설정)"
echo "   2. 새 터미널 열기 또는: source ~/.zshrc"
echo "   3. p10k configure (처음 실행 시 프롬프트 설정)"
