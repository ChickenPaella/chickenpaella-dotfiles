local M = {}

M.create_keymaps = function()
  -- 이전/다음 버퍼 이동
  vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "다음 버퍼" })
  vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "이전 버퍼" })

  for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
      local buffers = require("bufferline.state").components
      local bufnr = buffers[i] and buffers[i].id
      if bufnr then
        vim.api.nvim_set_current_buf(bufnr)
      else
        vim.notify("No buffer " .. i, vim.log.levels.WARN)
      end
    end, { desc = "Go to bufferline buffer " .. i })
  end
end

return M
