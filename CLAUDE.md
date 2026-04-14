# dotfiles — AI Agent Instructions

## Language Rules
- Response language: follow the user's message language
- Code comments: English
- Commit messages: English
- Variable/function names: English (code convention)

## Repository Structure

```
~/dotfiles/
├── config/
│   ├── zsh/
│   │   ├── .zshenv                    ← environment variables (XDG, EDITOR, PATH)
│   │   ├── .zshrc                     ← main zsh config
│   │   ├── aliases.zsh                ← aliases (with feature detection)
│   │   ├── functions.zsh              ← shell functions
│   │   └── local_rc.template.zsh      ← per-machine config template
│   ├── nvim/                          ← Neovim config (LazyVim-based)
│   ├── tmux/tmux.conf                 ← Prefix=Ctrl+S
│   ├── wezterm/wezterm.lua
│   ├── aerospace/aerospace.toml       ← window manager
│   ├── git/config                     ← git aliases, fsmonitor
│   ├── git/ignore                     ← global gitignore
│   └── python/pythonrc.py             ← Python REPL config
├── install.sh                         ← bootstrap script for new machines
├── CLAUDE.md                          ← this file
└── .gitignore                         ← excludes local_rc.zsh, API keys
```

## Key Patterns

### Symlink structure
`~/dotfiles/config/*` → `~/.config/*`
- This repo is the source of truth
- Symlinks are created by the `link()` function in `install.sh`

### Per-machine local config
- `~/.config/zsh/local_rc.zsh` — not committed to the repo
- Stores API keys, company-specific aliases, kubectl CONTEXT/NAMESPACE, etc.
- Copy `local_rc.template.zsh` to get started

### Feature detection
- Aliases and functions use `command -v tool &>/dev/null` before applying tool-specific config
- Ensures fallback behavior on machines where optional tools (eza, bat, etc.) are not installed

## Neovim Structure (`config/nvim/`)
- Based on LazyVim (`lua/config/lazy.lua`)
- Custom keymaps under `lua/config/keymaps/`
- `<leader>` = Space
- Key swap: Alt (physical Cmd position) / Cmd (physical Option position)

## Important Notes
- Never commit `local_rc.zsh` — it contains API keys
- `.zshenv` symlink: `~/.zshenv` → `~/dotfiles/config/zsh/.zshenv`
- When adding a new tool, also update the brew install list in `install.sh`
