return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<A-]>",   -- Alt+] 로 제안 수락
        clear_suggestion  = "<A-[>",   -- Alt+[ 로 제안 거절
        accept_word       = "<A-n>",   -- Alt+n 으로 단어 단위 수락
      },
      ignore_filetypes = { "TelescopePrompt" },
      color = {
        suggestion_color = "#928374",  -- Gruvbox gray
      },
      log_level = "off",
    })
  end,
}
