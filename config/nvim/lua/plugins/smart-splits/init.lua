return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    -- pane/split 이동 (tmux pane ↔ nvim split 구분 없이)
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "왼쪽 이동" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "아래 이동" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "위 이동" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "오른쪽 이동" },
  },
}
