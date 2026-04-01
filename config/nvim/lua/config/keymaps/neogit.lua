local M = {}

M.create_keymaps = function()
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
  end, { desc = "Lazygit" })
end

return M
