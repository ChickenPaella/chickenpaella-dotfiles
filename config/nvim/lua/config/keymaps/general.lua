local M = {}

M.create_keymaps = function()
  vim.keymap.set("n", "<leader>ul", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
  end, { desc = "Toggle Relative Line Numbers" })

  vim.keymap.set("n", "<leader>fp", function()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then
      vim.notify("No file path", vim.log.levels.WARN)
    else
      local full_path = vim.fn.fnamemodify(path, ":p")
      vim.fn.setreg("+", full_path)
      vim.notify(full_path, vim.log.levels.INFO, { title = "Full Path (copied)" })
    end
  end, { desc = "Copy Full Path to Clipboard" })
end

return M
