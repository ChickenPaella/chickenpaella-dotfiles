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
              -- poetry/venv 환경 자동 감지
              local ok, env = pcall(require, "utils.python_env")
              if ok then return env.get_python_path() end
              return vim.fn.exepath("python3") or "python3"
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
