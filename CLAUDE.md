# dotfiles — AI Agent 지침

## 언어 규칙
- 응답: 한국어
- 코드 주석: 한국어
- 커밋 메시지: 한국어
- 쉘 스크립트 주석: 한국어

## 레포 구조

```
~/dotfiles/
├── config/
│   ├── zsh/
│   │   ├── .zshenv           ← 환경변수 (XDG, EDITOR, PATH)
│   │   ├── .zshrc            ← 메인 zsh 설정
│   │   ├── aliases.zsh       ← alias 모음 (feature detection 포함)
│   │   ├── functions.zsh     ← 함수 모음
│   │   └── local_rc.template.zsh  ← 기기별 설정 템플릿
│   ├── nvim/                 ← Neovim 설정 (LazyVim 기반)
│   ├── tmux/tmux.conf        ← Prefix=Ctrl+S
│   ├── wezterm/wezterm.lua
│   ├── aerospace/aerospace.toml  ← 윈도우 매니저
│   ├── git/config            ← git alias, fsmonitor
│   ├── git/ignore            ← 전역 gitignore
│   └── python/pythonrc.py    ← Python REPL 설정
├── install.sh                ← 새 PC 설치 스크립트
├── CLAUDE.md                 ← 이 파일
└── .gitignore                ← local_rc.zsh, API 키 제외
```

## 핵심 패턴

### symlink 구조
`~/dotfiles/config/*` → `~/.config/*`
- dotfiles 레포가 source of truth
- `install.sh`의 `link()` 함수로 생성

### 기기별 설정 분리
- `~/.config/zsh/local_rc.zsh` — **레포에 포함되지 않음**
- API 키, 회사 전용 alias, CONTEXT/NAMESPACE(kubectl) 등 저장
- `local_rc.template.zsh`를 복사해서 시작

### feature detection
- alias/함수에서 `command -v tool &>/dev/null` 로 도구 존재 확인 후 설정
- 회사 PC에 없는 도구(eza, bat 등)가 있어도 기본 동작 보장

## Neovim 구조 (`config/nvim/`)
- LazyVim 기반 (`lua/config/lazy.lua`)
- 커스텀 키맵: `lua/config/keymaps/` 하위 파일들
- `<leader>` = Space
- 키보드 스왑: Alt(물리적 Cmd 위치) / Cmd(물리적 Option 위치)

## 주의사항
- `local_rc.zsh`는 절대 커밋하지 않을 것 (API 키 포함)
- `.zshenv` symlink: `~/.zshenv` → `~/dotfiles/config/zsh/.zshenv`
- 새 도구 추가 시 `install.sh`의 brew install 목록도 업데이트
