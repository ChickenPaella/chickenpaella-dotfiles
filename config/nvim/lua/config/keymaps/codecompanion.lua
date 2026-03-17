local M = {}

M.create_keymaps = function()
  local map = vim.keymap.set
  local base = { noremap = true, silent = true }

  map(
    { "n", "v" },
    "<leader>aa",
    "<cmd>CodeCompanionActions<CR>",
    vim.tbl_extend("force", base, { desc = "AI: 액션 팔레트" })
  )

  map(
    { "n", "v" },
    "<Leader>ac",
    "<cmd>CodeCompanionChat Toggle<CR>",
    vim.tbl_extend("force", base, { desc = "AI: 채팅 토글" })
  )

  map(
    "v",
    "<Leader>as",
    "<cmd>CodeCompanionChat Add<CR>",
    vim.tbl_extend("force", base, { desc = "AI: 선택 코드를 채팅에 추가" })
  )
end

return M
