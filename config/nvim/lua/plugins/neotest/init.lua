return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Python (pytest) 어댑터
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            -- pytest 기본 사용, unittest 자동 감지
            runner = "pytest",
            python = function()
              -- venv가 있으면 사용, 없으면 시스템 python3
              local venv = vim.fn.expand("~/.venv/bin/python")
              if vim.fn.executable(venv) == 1 then return venv end
              venv = vim.fn.expand("~/venv/bin/python")
              if vim.fn.executable(venv) == 1 then return venv end
              return vim.fn.exepath("python3")
            end,
          }),
        },
        output = { open_on_run = true },
        summary = { animated = true },
        -- 테스트 결과 아이콘
        icons = {
          passed  = "✓",
          failed  = "✗",
          running = "↻",
          skipped = "○",
          unknown = "?",
        },
      })
    end,
  },
}
