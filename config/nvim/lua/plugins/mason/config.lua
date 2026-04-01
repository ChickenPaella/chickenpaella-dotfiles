local M = {
  "mason-org/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}

M.tools = {
  -- LSP servers
  "pyright",
  "kotlin-language-server",
  "jdtls",

  -- DAP
  "debugpy",

  -- Linters
  "buf",
  "cmakelang",
  "cpplint",
  "eslint_d",
  -- "flake8", -- if using flake8 instead of ruff
  "markdownlint",
  -- "mypy", -- pip install mypy 사용
  "pylint",
  "yamllint",
  "shellcheck",
  -- jsonnet-language-server: Mason 빌드 불가 (Go 미설치)
  -- ~/.local/bin/jsonnet-language-server 바이너리 직접 설치됨

  -- Formatters
  "autopep8",
  "black",
  "cmakelang",
  -- "isort",
  "prettier",
  "ruff",
  "shfmt",
  "stylua",
  "ktlint",
  "google-java-format",
}

M.config = function()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    PATH = "append",
  })

  require("mason-tool-installer").setup({
    ensure_installed = M.tools,
    auto_update = true,
    run_on_start = true,
  })
end

return M
