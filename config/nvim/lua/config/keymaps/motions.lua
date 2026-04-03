local M = {}

M.create_keymaps = function()
  -- Insert mode에서 jk로 Normal 모드 전환
  vim.keymap.set("i", "jk", "<Esc>", { desc = "Normal 모드로" })

  -- 행 이동: H (첫 비공백 문자), L (행 끝) — o 포함으로 dL, cL 등도 동작
  vim.keymap.set({ "n", "v", "o" }, "H", "^", { desc = "행 첫 문자로" })
  vim.keymap.set({ "n", "v", "o" }, "L", "$", { desc = "행 끝으로" })

  -- 단락 이동: J/K (꾹 눌러서 연속 이동, LazyVim 기본 join/hover 덮어씀)
  vim.keymap.set({ "n", "v", "o" }, "J", "}", { desc = "다음 단락" })
  vim.keymap.set({ "n", "v", "o" }, "K", "{", { desc = "이전 단락" })

  -- 검색 이동 시 화면 중앙 정렬
  vim.keymap.set("n", "n", "nzz", { desc = "다음 검색 결과 (중앙)" })
  vim.keymap.set("n", "N", "Nzz", { desc = "이전 검색 결과 (중앙)" })
  vim.keymap.set("n", "*", "*zz", { desc = "단어 검색 (중앙)" })
  vim.keymap.set("n", "#", "#zz", { desc = "단어 역검색 (중앙)" })

  -- 검색 하이라이트 제거
  vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "검색 하이라이트 제거" })

  -- Visual mode 붙여넣기: 기존 복사 내용 레지스터 보존
  vim.keymap.set("v", "p", '"_dP', { desc = "레지스터 보존 붙여넣기" })

  -- 저장 (<leader>w는 LazyVim window 서브키와 충돌하므로 <leader>fs 사용)
  vim.keymap.set({ "n", "i", "v" }, "<leader>fs", "<cmd>w<CR><Esc>", { desc = "저장" })

  -- 전체 선택
  vim.keymap.set("n", "<C-a>", "ggVG", { desc = "전체 선택" })
end

return M
