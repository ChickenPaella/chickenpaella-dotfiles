-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- 키보드 멈춤 시 자동 저장
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.bo.modifiable then
      vim.cmd("silent! wa")
    end
  end,
  desc = "자동 저장",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmpl",
  callback = function(ev)
    local ext = ev.file:match("%.([^.]+)%.tmpl$")
    if ext then
      vim.bo.filetype = ext
      vim.b.is_chezmoi_tmpl = true
    end
  end,
})
