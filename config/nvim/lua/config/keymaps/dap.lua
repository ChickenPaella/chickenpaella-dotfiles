local M = {}

M.create_keymaps = function()
  local map = vim.keymap.set

  -- ── 실행 제어 ────────────────────────────────────────────────
  map("n", "<F5>",  function() require("dap").continue() end,          { desc = "디버그 시작/계속" })
  map("n", "<F10>", function() require("dap").step_over() end,         { desc = "Step Over" })
  map("n", "<F11>", function() require("dap").step_into() end,         { desc = "Step Into" })
  map("n", "<F12>", function() require("dap").step_out() end,          { desc = "Step Out" })
  map("n", "<leader>dq", function() require("dap").terminate() end,    { desc = "디버그 종료" })

  -- ── 중단점 ──────────────────────────────────────────────────
  map("n", "<F9>",       function() require("dap").toggle_breakpoint() end, { desc = "중단점 토글" })
  map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "중단점 토글" })
  map("n", "<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("조건식: "))
  end, { desc = "조건부 중단점" })

  -- ── UI ──────────────────────────────────────────────────────
  map("n", "<leader>du", function() require("dapui").toggle() end,     { desc = "DAP UI 토글" })
  map("n", "<leader>de", function() require("dapui").eval() end,       { desc = "표현식 평가" })
  map("v", "<leader>de", function() require("dapui").eval() end,       { desc = "선택 영역 평가" })

  -- ── Python 전용 ──────────────────────────────────────────────
  map("n", "<leader>dm", function() require("dap-python").test_method() end,  { desc = "현재 메서드 디버그" })
  map("n", "<leader>dC", function() require("dap-python").test_class() end,   { desc = "현재 클래스 디버그" })
end

return M
