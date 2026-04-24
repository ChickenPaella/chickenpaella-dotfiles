# nvim-pets — plugin idea

vscode-pets처럼 에디터 안에서 펫이 살아 움직이는 Neovim 플러그인.

## 목표

- 픽셀아트 스프라이트가 실제로 움직임 (ASCII art 아님)
- 여러 종류의 펫, 여러 스킨
- 코딩 행동에 반응 (저장하면 기뻐하는 등)

---

## 핵심 기술 문제

터미널에서 이미지를 표시하려면 그래픽 프로토콜이 필요함:

| 프로토콜 | 지원 터미널 |
|---|---|
| Kitty Graphics Protocol | Kitty, WezTerm (부분) |
| Sixel | WezTerm, iTerm2, xterm |
| iTerm2 Inline Image | iTerm2, WezTerm |

**결론:** [image.nvim](https://github.com/3rd/image.nvim) 을 렌더링 백엔드로 사용하면
여러 프로토콜을 추상화해서 쓸 수 있음. WezTerm은 Sixel 또는 iTerm2 프로토콜로 안정적으로 동작.

---

## 아키텍처 스케치

```
nvim-pets/
├── lua/
│   ├── pets/
│   │   ├── init.lua          -- setup(), public API
│   │   ├── pet.lua           -- Pet 객체 (상태, 스프라이트, 위치)
│   │   ├── renderer.lua      -- image.nvim 호출, float window 관리
│   │   ├── animator.lua      -- 타이머 기반 스프라이트 프레임 전환
│   │   ├── behavior.lua      -- autocmd 반응 (저장, yank, idle 등)
│   │   └── sprites/
│   │       ├── cat/          -- cat 스프라이트 PNG 프레임들
│   │       └── dog/
└── README.md
```

### 렌더링 흐름

```
autocmd / timer
    → behavior.lua  (상태 계산)
    → animator.lua  (현재 프레임 선택)
    → renderer.lua  (image.nvim으로 float window에 이미지 표시)
```

### 펫 상태 머신

```
idle → walk → sit → react(happy/sad) → idle
```

autocmd 트리거:
- `BufWritePost` → happy 애니메이션
- `DiagnosticChanged` (에러 증가) → sad 애니메이션
- 일정 시간 idle → walk/sit 랜덤 전환

---

## 스프라이트 소스 후보

- vscode-pets의 스프라이트 (MIT 라이선스 확인 필요)
- [itch.io](https://itch.io) 픽셀아트 펫 에셋

---

## 의존성

- [image.nvim](https://github.com/3rd/image.nvim) — 이미지 렌더링
- Neovim >= 0.10 (`vim.uv` 타이머 사용)

---

## 참고

- vscode-pets: https://github.com/tonybaloney/vscode-pets
- image.nvim: https://github.com/3rd/image.nvim
