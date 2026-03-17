local M = {}

M.create_keymaps = function()
  local map = vim.keymap.set

  -- ── 테스트 실행 ─────────────────────────────────────────────
  map("n", "<leader>tn", function() require("neotest").run.run() end,
    { desc = "가장 가까운 테스트 실행" })
  map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,
    { desc = "현재 파일 테스트 전체 실행" })
  map("n", "<leader>tl", function() require("neotest").run.run_last() end,
    { desc = "마지막 테스트 재실행" })
  map("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,
    { desc = "가장 가까운 테스트 디버그" })

  -- ── 결과/UI ──────────────────────────────────────────────────
  map("n", "<leader>ts", function() require("neotest").summary.toggle() end,
    { desc = "테스트 요약 패널 토글" })
  map("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end,
    { desc = "테스트 출력 보기" })
  map("n", "<leader>tp", function() require("neotest").output_panel.toggle() end,
    { desc = "테스트 출력 패널 토글" })

  -- ── 테스트 간 이동 ───────────────────────────────────────────
  map("n", "]t", function() require("neotest").jump.next({ status = "failed" }) end,
    { desc = "다음 실패한 테스트" })
  map("n", "[t", function() require("neotest").jump.prev({ status = "failed" }) end,
    { desc = "이전 실패한 테스트" })
end

return M
