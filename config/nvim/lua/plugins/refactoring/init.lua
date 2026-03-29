return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    -- visual 모드에서 선택 후 사용
    { "<leader>re", function() require("refactoring").refactor("Extract Function") end,
      mode = "x", desc = "함수로 추출" },
    { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end,
      mode = "x", desc = "변수로 추출" },
    { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end,
      mode = { "n", "x" }, desc = "변수 인라인화" },
    -- 리팩토링 목록 팝업
    { "<leader>R", function() require("refactoring").select_refactor() end,
      mode = { "n", "x" }, desc = "리팩토링 선택" },
  },
  config = function()
    require("refactoring").setup()
  end,
}
