return {
  dir = vim.fn.expand("~/projects/nvim-pets"),
  dependencies = { "3rd/image.nvim" },
  keys = {
    { "<leader>pp", "<cmd>Pets<cr>", desc = "Pets: toggle" },
  },
  config = function()
    require("pets").setup()
  end,
}
