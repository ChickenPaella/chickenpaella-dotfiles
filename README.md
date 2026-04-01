**한국어** | [English](README.en.md) | [日本語](README.ja.md)

# 🛠️ dotfiles

> 키보드 중심 macOS 개발환경. 어디서든 `./install.sh` 한 번으로 셋업.

![macOS](https://img.shields.io/badge/macOS-12%2B-black?logo=apple)
![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?logo=neovim)
![Shell](https://img.shields.io/badge/shell-zsh-89e051)

---

## ✨ 특징

- ⚡ **빠른 설치** — Homebrew, Oh My Zsh, CLI 도구, 폰트까지 한 번에
- 🪟 **AeroSpace** — 키보드로 창 관리 (yabai 대체)
- 📟 **WezTerm** — Gruvbox 테마, Nerd Font, kitty keyboard protocol
- 🖥️ **tmux** — `Ctrl+S` prefix, vi 스타일 pane 조작
- 🔥 **Neovim** — LazyVim 기반, LSP + AI 자동완성 + 디버거 완비
- 🐍 **Python 완전체** — pyright, ruff, mypy, pytest, debugpy
- 🔒 **기기별 설정 분리** — API 키, 회사 설정은 `local_rc.zsh`로 격리

---

## ⚡ 빠른 시작

```bash
git clone https://github.com/ChickenPaella/chickenpaella-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

---

## 📋 요구사항

| 항목 | 버전 |
|------|------|
| macOS | 12 Monterey 이상 |
| Git | 설치되어 있어야 함 |
| 인터넷 | Homebrew 설치에 필요 |

> Apple Silicon(M1~) 및 Intel Mac 모두 지원.

---

## ⌨️ 단축키

### 🪟 AeroSpace — 창 관리

| 단축키 | 동작 |
|--------|------|
| `Alt + 1-6` | 워크스페이스 이동 |
| `Alt + Shift + 1-6` | 현재 창을 워크스페이스로 이동 |
| `Alt + h/j/k/l` | 포커스 이동 |
| `Alt + Shift + h/j/k/l` | 창 이동 |
| `Alt + f` | 전체화면 토글 |
| `Alt + Shift + f` | 플로팅/타일링 전환 |
| `Alt + Shift + b` | 창 크기 균등 분배 |

### 📟 tmux — Prefix: `Ctrl+S`

| 단축키 | 동작 |
|--------|------|
| `Prefix + \|` | 세로 분할 |
| `Prefix + -` | 가로 분할 |
| `Prefix + h/j/k/l` | pane 이동 |
| `Prefix + z` | 현재 pane 전체화면 |
| `Prefix + Alt + 화살표` | pane 크기 조절 |
| `Prefix + d` | 세션 detach |

### 🔥 Neovim — `<leader>` = Space

#### 기본 이동

| 단축키 | 동작 |
|--------|------|
| `H` | 줄 처음으로 |
| `L` | 줄 끝으로 |
| `J` / `K` | 다음/이전 단락 |
| `jk` | Insert → Normal |
| `Tab` / `Shift+Tab` | 다음/이전 버퍼 |

#### 파일 & 검색

| 단축키 | 동작 |
|--------|------|
| `<leader>e` | 파일 탐색기 토글 |
| `<leader>ff` | 파일 검색 (Telescope) |
| `<leader>fg` | 전체 텍스트 검색 (grep) |
| `<leader>fs` | 저장 |
| `<leader>?` | 치트시트 열기 |

#### LSP

| 단축키 | 동작 |
|--------|------|
| `gd` | 정의로 이동 |
| `gr` | 참조 목록 |
| `<leader>lr` | 심볼 이름 변경 |
| `<leader>la` | 코드 액션 |
| `<leader>lh` | Hover 문서 |
| `]d` / `[d` | 다음/이전 진단 |

#### Git

| 단축키 | 동작 |
|--------|------|
| `<leader>gg` | lazygit 열기 |

#### 테스트 (pytest)

| 단축키 | 동작 |
|--------|------|
| `<leader>tf` | 파일 전체 테스트 |
| `<leader>tn` | 커서 위 테스트 하나 |
| `<leader>to` | 테스트 출력 보기 |
| `<leader>ts` | 테스트 요약 패널 |

#### 디버거 (DAP)

| 단축키 | 동작 |
|--------|------|
| `<leader>db` | 중단점 토글 |
| `<leader>dc` | 디버그 시작/계속 |
| `<leader>du` | DAP UI 토글 |
| `F10` | Step Over |
| `F11` | Step Into |
| `F12` | Step Out |
| `<leader>dq` | 디버그 종료 |

#### AI 자동완성 (Codeium)

| 단축키 | 동작 |
|--------|------|
| `Alt + y` | 제안 수락 |
| `Alt + [` | 제안 거절 |
| `Alt + n` | 다음 제안 |

---

## 📁 레포 구조

```
~/dotfiles/
├── config/
│   ├── zsh/
│   │   ├── .zshenv              # XDG 경로, EDITOR, PATH
│   │   ├── .zshrc               # Oh My Zsh, vi mode, 플러그인
│   │   ├── aliases.zsh          # alias (feature detection 포함)
│   │   ├── functions.zsh        # tvim, ex, venv 자동활성화 등
│   │   └── local_rc.template.zsh
│   ├── nvim/                    # Neovim (LazyVim 기반)
│   ├── tmux/tmux.conf
│   ├── wezterm/wezterm.lua
│   ├── aerospace/aerospace.toml
│   ├── git/config
│   └── git/ignore
├── install.sh                   # 설치 스크립트
└── .gitignore
```

---

## 🔧 포스트 인스톨

#### 1. 기기별 설정 편집

```bash
vi ~/.config/zsh/local_rc.zsh
```

API 키, kubectl context, AWS 프로파일 등을 여기에 저장 (gitignored).

#### 2. Codeium 인증

```
nvim → :Codeium Auth
```

#### 3. Neovim LSP / 디버거 패키지

```
nvim → :Mason
```

`debugpy`, `pyright`, `ruff` 등 필요한 패키지 설치.

#### 4. tvim 사용법

```bash
tvim ~/프로젝트폴더
```

Neovim + 터미널 pane이 분할된 IDE 레이아웃으로 열림.

---

## 📝 라이선스

MIT
