return {
  "folke/noice.nvim",
  -- Do not load noice in VSCode Neovim
  cond = function()
    return not vim.g.vscode
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({})
  end,
}
