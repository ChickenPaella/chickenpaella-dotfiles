#!/usr/bin/env zsh
# dotfiles 설치 스크립트
# 새 맥북에서: git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh

set -e
DOTFILES="$HOME/dotfiles"

echo "📦 dotfiles 설치 시작..."

# ── Homebrew 확인 ─────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Homebrew 설치 중..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ── 필수 도구 설치 ────────────────────────────────────────────
brew install \
  neovim git eza bat ripgrep fd fzf \
  tmux zsh-autosuggestions zsh-syntax-highlighting \
  bazelisk trash tldr jq \
  pyenv poetry \
  gh

# ── 심볼릭 링크 생성 ──────────────────────────────────────────
link() {
  local src="$DOTFILES/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.backup.$(date +%Y%m%d)"
    echo "  백업: ${dst}.backup"
  fi
  ln -sf "$src" "$dst"
  echo "  링크: $dst → $src"
}

echo "\n🔗 심볼릭 링크 생성 중..."
link config/zsh/.zshrc         ~/.zshrc
link config/tmux/tmux.conf     ~/.config/tmux/tmux.conf
link config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
link config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
link config/git/config         ~/.config/git/config
link config/git/ignore         ~/.config/git/ignore
link config/nvim               ~/.config/nvim

# ── local_rc 설정 ─────────────────────────────────────────────
if [[ ! -f ~/.config/zsh/local_rc.zsh ]]; then
  mkdir -p ~/.config/zsh
  cp "$DOTFILES/config/zsh/local_rc.template.zsh" ~/.config/zsh/local_rc.zsh
  echo "\n⚠️  ~/.config/zsh/local_rc.zsh 를 편집해서 API 키 등을 설정하세요"
fi

echo "\n✅ 설치 완료! 터미널을 재시작하거나 'source ~/.zshrc' 실행"
