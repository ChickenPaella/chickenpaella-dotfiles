return {
  {
    "m4xshen/hardtime.nvim",
    enabled = false,  -- 적응 후 true로 변경
    lazy = false,
    opts = {
      disable_mouse = false,
      allow_different_key = true,
      disabled_filetypes = { "qf", "lazy", "mason", "neo-tree", "noice", "NeogitStatus" },
      disabled_keys = {},
    },
  },
}
