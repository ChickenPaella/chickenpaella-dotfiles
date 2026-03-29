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
    -- format_on_save는 LazyVim이 관리하므로 여기서 설정하지 않음
    -- 저장 시 자동 포맷은 <leader>mp 또는 :ConformFormat 으로 수동 실행
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
