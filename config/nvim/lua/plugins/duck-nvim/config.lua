return {
  "tamton-aquib/duck.nvim",
  keys = {
    { "<leader>dd", function() require("duck").hatch() end,  desc = "Duck: hatch" },
    { "<leader>dk", function() require("duck").cook() end,   desc = "Duck: cook (kill)" },
    { "<leader>da", function() require("duck").cook_all() end, desc = "Duck: cook all" },
  },
  opts = {
    character = "🦆",
    speed = 10,
  },
}
