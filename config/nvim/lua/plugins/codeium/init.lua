return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  config = function()
    vim.keymap.set("i", "<A-y>", function() return vim.fn["codeium#Accept"]() end,
      { expr = true, silent = true, desc = "Codeium 제안 수락" })
    vim.keymap.set("i", "<A-[>", function() return vim.fn["codeium#Clear"]() end,
      { expr = true, silent = true, desc = "Codeium 제안 거절" })
    vim.keymap.set("i", "<A-n>", function() return vim.fn["codeium#CycleCompletions"](1) end,
      { expr = true, silent = true, desc = "다음 Codeium 제안" })
  end,
}
