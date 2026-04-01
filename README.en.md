[한국어](README.md) | **English** | [日本語](README.ja.md)

# 🛠️ dotfiles

> Keyboard-driven macOS dev environment. One command to get up and running anywhere.

![macOS](https://img.shields.io/badge/macOS-12%2B-black?logo=apple)
![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?logo=neovim)
![Shell](https://img.shields.io/badge/shell-zsh-89e051)

---

## ✨ What's inside

- ⚡ **One-shot install** — Homebrew, Oh My Zsh, CLI tools, fonts, all at once
- 🪟 **AeroSpace** — Keyboard-driven window management (yabai replacement)
- 📟 **WezTerm** — Gruvbox theme, Nerd Font, kitty keyboard protocol
- 🖥️ **tmux** — `Ctrl+S` prefix, vi-style pane control
- 🔥 **Neovim** — LazyVim base, LSP + AI completion + debugger
- 🐍 **Python-first** — pyright, ruff, mypy, pytest, debugpy out of the box
- 🔒 **Machine-local secrets** — API keys and company config stay in `local_rc.zsh`

---

## ⚡ Quick start

```bash
git clone https://github.com/ChickenPaella/chickenpaella-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

---

## 📋 Requirements

| Item | Version |
|------|---------|
| macOS | 12 Monterey or later |
| Git | Must be pre-installed |
| Internet | Required for Homebrew bootstrap |

> Works on both Apple Silicon (M1+) and Intel Macs.

---

## ⌨️ Keybindings

### 🪟 AeroSpace — Window management

| Key | Action |
|-----|--------|
| `Alt + 1-6` | Switch workspace |
| `Alt + Shift + 1-6` | Move window to workspace |
| `Alt + h/j/k/l` | Focus window |
| `Alt + Shift + h/j/k/l` | Move window |
| `Alt + f` | Toggle fullscreen |
| `Alt + Shift + f` | Toggle floating/tiling |
| `Alt + Shift + b` | Balance window sizes |

### 📟 tmux — Prefix: `Ctrl+S`

| Key | Action |
|-----|--------|
| `Prefix + \|` | Vertical split |
| `Prefix + -` | Horizontal split |
| `Prefix + h/j/k/l` | Navigate panes |
| `Prefix + z` | Zoom current pane |
| `Prefix + Alt + arrow` | Resize pane |
| `Prefix + d` | Detach session |

### 🔥 Neovim — `<leader>` = Space

#### Navigation

| Key | Action |
|-----|--------|
| `H` | Jump to line start |
| `L` | Jump to line end |
| `J` / `K` | Next/prev paragraph |
| `jk` | Insert → Normal mode |
| `Tab` / `Shift+Tab` | Next/prev buffer |

#### Files & Search

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find file (Telescope) |
| `<leader>fg` | Live grep across project |
| `<leader>fs` | Save |
| `<leader>?` | Open cheatsheet |

#### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code actions |
| `<leader>lh` | Hover docs |
| `]d` / `[d` | Next/prev diagnostic |

#### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit |

#### Testing (pytest)

| Key | Action |
|-----|--------|
| `<leader>tf` | Run all tests in file |
| `<leader>tn` | Run nearest test |
| `<leader>to` | Show test output |
| `<leader>ts` | Toggle test summary |

#### Debugger (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Start/continue debug |
| `<leader>du` | Toggle DAP UI |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<leader>dq` | Stop debugger |

#### AI Completion (Codeium)

| Key | Action |
|-----|--------|
| `Alt + y` | Accept suggestion |
| `Alt + [` | Dismiss suggestion |
| `Alt + n` | Next suggestion |

---

## 📁 Structure

```
~/dotfiles/
├── config/
│   ├── zsh/
│   │   ├── .zshenv              # XDG paths, EDITOR, PATH
│   │   ├── .zshrc               # Oh My Zsh, vi mode, plugins
│   │   ├── aliases.zsh          # Aliases with feature detection
│   │   ├── functions.zsh        # tvim, ex, venv auto-activation, etc.
│   │   └── local_rc.template.zsh
│   ├── nvim/                    # Neovim config (LazyVim-based)
│   ├── tmux/tmux.conf
│   ├── wezterm/wezterm.lua
│   ├── aerospace/aerospace.toml
│   ├── git/config
│   └── git/ignore
├── install.sh                   # Bootstrap script
└── .gitignore
```

---

## 🔧 Post-install

#### 1. Edit machine-local config

```bash
vi ~/.config/zsh/local_rc.zsh
```

Store API keys, kubectl context, AWS profiles here. This file is gitignored.

#### 2. Authenticate Codeium

```
nvim → :Codeium Auth
```

#### 3. Install Neovim LSP / debugger packages

```
nvim → :Mason
```

Install `debugpy`, `pyright`, `ruff`, and anything else you need.

#### 4. Using tvim

```bash
tvim ~/your-project
```

Opens a split layout: Neovim on the left (70%) + terminal on the right (30%).

---

## 📝 License

MIT
