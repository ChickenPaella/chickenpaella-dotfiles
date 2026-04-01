[한국어](README.md) | [English](README.en.md) | **日本語**

# 🛠️ dotfiles

> キーボード中心のmacOS開発環境。どのマシンでも `./install.sh` 一発でセットアップ完了。

![macOS](https://img.shields.io/badge/macOS-12%2B-black?logo=apple)
![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?logo=neovim)
![Shell](https://img.shields.io/badge/shell-zsh-89e051)

---

## ✨ 特徴

- ⚡ **ワンコマンドインストール** — Homebrew、Oh My Zsh、CLIツール、フォントまで一括セットアップ
- 🪟 **AeroSpace** — キーボードでウィンドウ管理（yabaiの代替）
- 📟 **WezTerm** — Gruvboxテーマ、Nerd Font、kittyキーボードプロトコル対応
- 🖥️ **tmux** — `Ctrl+S`プレフィックス、viスタイルのペイン操作
- 🔥 **Neovim** — LazyVimベース、LSP + AI補完 + デバッガー完備
- 🐍 **Python対応** — pyright、ruff、mypy、pytest、debugpyをすぐ使える状態で提供
- 🔒 **マシン固有の設定を分離** — APIキーや会社設定は `local_rc.zsh` で管理

---

## ⚡ クイックスタート

```bash
git clone https://github.com/ChickenPaella/chickenpaella-dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

---

## 📋 動作環境

| 項目 | バージョン |
|------|-----------|
| macOS | 12 Monterey以降 |
| Git | インストール済みであること |
| インターネット | Homebrewのインストールに必要 |

> Apple Silicon（M1以降）・Intel Mac どちらにも対応。

---

## ⌨️ キーバインド

### 🪟 AeroSpace — ウィンドウ管理

| キー | 動作 |
|------|------|
| `Alt + 1-6` | ワークスペース切り替え |
| `Alt + Shift + 1-6` | ウィンドウをワークスペースへ移動 |
| `Alt + h/j/k/l` | フォーカス移動 |
| `Alt + Shift + h/j/k/l` | ウィンドウ移動 |
| `Alt + f` | フルスクリーン切り替え |
| `Alt + Shift + f` | フローティング/タイリング切り替え |
| `Alt + Shift + b` | ウィンドウサイズを均等に |

### 📟 tmux — プレフィックス: `Ctrl+S`

| キー | 動作 |
|------|------|
| `Prefix + \|` | 垂直分割 |
| `Prefix + -` | 水平分割 |
| `Prefix + h/j/k/l` | ペイン移動 |
| `Prefix + z` | 現在のペインをズーム |
| `Prefix + Alt + 矢印` | ペインのリサイズ |
| `Prefix + d` | セッションをデタッチ |

### 🔥 Neovim — `<leader>` = Space

#### 移動

| キー | 動作 |
|------|------|
| `H` | 行頭へ |
| `L` | 行末へ |
| `J` / `K` | 次/前の段落 |
| `jk` | インサート → ノーマルモード |
| `Tab` / `Shift+Tab` | 次/前のバッファ |

#### ファイル・検索

| キー | 動作 |
|------|------|
| `<leader>e` | ファイルエクスプローラー切り替え |
| `<leader>ff` | ファイル検索（Telescope） |
| `<leader>fg` | プロジェクト全体をgrep |
| `<leader>fs` | 保存 |
| `<leader>?` | チートシートを開く |

#### LSP

| キー | 動作 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `<leader>lr` | シンボルのリネーム |
| `<leader>la` | コードアクション |
| `<leader>lh` | ホバードキュメント |
| `]d` / `[d` | 次/前の診断 |

#### Git

| キー | 動作 |
|------|------|
| `<leader>gg` | lazygitを開く |

#### テスト（pytest）

| キー | 動作 |
|------|------|
| `<leader>tf` | ファイル内のテストを全実行 |
| `<leader>tn` | カーソル位置のテストを実行 |
| `<leader>to` | テスト出力を表示 |
| `<leader>ts` | テストサマリーパネルを切り替え |

#### デバッガー（DAP）

| キー | 動作 |
|------|------|
| `<leader>db` | ブレークポイント切り替え |
| `<leader>dc` | デバッグ開始/継続 |
| `<leader>du` | DAP UI切り替え |
| `F10` | ステップオーバー |
| `F11` | ステップイン |
| `F12` | ステップアウト |
| `<leader>dq` | デバッグ終了 |

#### AI補完（Codeium）

| キー | 動作 |
|------|------|
| `Alt + y` | 候補を確定 |
| `Alt + [` | 候補を却下 |
| `Alt + n` | 次の候補 |

---

## 📁 構成

```
~/dotfiles/
├── config/
│   ├── zsh/
│   │   ├── .zshenv              # XDGパス、EDITOR、PATH
│   │   ├── .zshrc               # Oh My Zsh、viモード、プラグイン
│   │   ├── aliases.zsh          # エイリアス（feature detection付き）
│   │   ├── functions.zsh        # tvim、ex、venv自動アクティベートなど
│   │   └── local_rc.template.zsh
│   ├── nvim/                    # Neovim設定（LazyVimベース）
│   ├── tmux/tmux.conf
│   ├── wezterm/wezterm.lua
│   ├── aerospace/aerospace.toml
│   ├── git/config
│   └── git/ignore
├── install.sh                   # セットアップスクリプト
└── .gitignore
```

---

## 🔧 インストール後の設定

#### 1. マシン固有の設定を編集

```bash
vi ~/.config/zsh/local_rc.zsh
```

APIキー、kubectlコンテキスト、AWSプロファイルなどをここに記載。このファイルはgitignore対象。

#### 2. Codeiumの認証

```
nvim → :Codeium Auth
```

#### 3. Neovim LSP / デバッガーパッケージのインストール

```
nvim → :Mason
```

`debugpy`、`pyright`、`ruff` などを必要に応じてインストール。

#### 4. tvimの使い方

```bash
tvim ~/your-project
```

左70%にNeovim、右30%にターミナルが開くIDEレイアウト。

---

## 📝 ライセンス

MIT
