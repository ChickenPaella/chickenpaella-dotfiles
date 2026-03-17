return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- :help conform-formatters for more details
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
      kotlin = { "ktlint" },
      java = { "google-java-format" },
      jsonnet = { "jsonnetfmt" },
      json = { "jq" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      -- zsh = { "shfmt" },
      bazel = { "buildifier" },
      bzl = { "buildifier" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    },
    -- tell Conform how to run
    formatters = {
      shfmt = {
        command = "shfmt",
        args = {
          "-ln",
          "bash", -- closest match for zsh
          "-i",
          "2",
          "-ci",
          "-sr",
          "-bn",
        },
        stdin = true,
      },
    },
  },
  keys = require("plugins.conform.keymaps"),
}
