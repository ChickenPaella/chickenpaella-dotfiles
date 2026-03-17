local M = {}

M.create_keymaps = function()
  -- Insert mode에서 jk로 Normal 모드 전환
  vim.keymap.set("i", "jk", "<Esc>", { desc = "Normal 모드로" })

  -- 행 이동: H (첫 비공백 문자), L (행 끝)
  vim.keymap.set({ "n", "v" }, "H", "^", { desc = "행 첫 문자로" })
  vim.keymap.set({ "n", "v" }, "L", "$", { desc = "행 끝으로" })

  -- 단락 이동: J/K (꾹 눌러서 연속 이동, LazyVim 기본 join/hover 덮어씀)
  vim.keymap.set({ "n", "v" }, "J", "}", { desc = "다음 단락" })
  vim.keymap.set({ "n", "v" }, "K", "{", { desc = "이전 단락" })

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
