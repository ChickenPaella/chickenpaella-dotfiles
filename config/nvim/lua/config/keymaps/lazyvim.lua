local M = {}

M.create_keymaps = function()
  pcall(vim.keymap.del, "n", "<leader>gG")
end

return M
