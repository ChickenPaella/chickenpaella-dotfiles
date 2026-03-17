return {
  -- DAP 코어
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- DAP UI (변수/스택/중단점 패널)
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup({
            layouts = {
              {
                elements = {
                  { id = "scopes",      size = 0.4 },
                  { id = "breakpoints", size = 0.2 },
                  { id = "stacks",      size = 0.2 },
                  { id = "watches",     size = 0.2 },
                },
                position = "left",
                size = 40,
              },
              {
                elements = {
                  { id = "repl",    size = 0.5 },
                  { id = "console", size = 0.5 },
                },
                position = "bottom",
                size = 12,
              },
            },
          })

          -- 디버그 시작/종료 시 UI 자동 토글
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end
        end,
      },
      -- 중단점 아이콘 표시
      "theHamsta/nvim-dap-virtual-text",
      -- Python DAP 어댑터 (Mason의 debugpy 연결)
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          -- Mason이 설치한 debugpy 경로
          local debugpy = require("mason-registry").get_package("debugpy"):get_install_path()
          require("dap-python").setup(debugpy .. "/venv/bin/python")
        end,
      },
    },
    config = function()
      require("nvim-dap-virtual-text").setup({ commented = true })

      -- 중단점 아이콘 커스터마이징 (Gruvbox 친화적)
      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine" })
    end,
  },
}
