return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", desc = "터미널 토글" },
    { "<leader>rr", desc = "현재 파일 실행" },
  },
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.85),
        height = math.floor(vim.o.lines * 0.8),
      },
      shade_terminals = false,
      persist_mode = true,
    })

    -- 파일타입별 실행 명령어
    local runners = {
      python     = "python3 %s",
      javascript = "node %s",
      typescript = "npx ts-node %s",
      lua        = "lua %s",
      sh         = "bash %s",
      zsh        = "zsh %s",
      go         = "go run %s",
    }

    -- 현재 파일 실행 (<leader>rr)
    vim.keymap.set("n", "<leader>rr", function()
      local ft = vim.bo.filetype
      local cmd_tpl = runners[ft]
      if not cmd_tpl then
        vim.notify("실행 미지원 파일타입: " .. ft, vim.log.levels.WARN)
        return
      end
      local file = vim.fn.expand("%:p")
      local cmd = string.format(cmd_tpl, file)
      require("toggleterm.terminal").Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,   -- 결과를 볼 수 있도록 종료 후 유지
      }):toggle()
    end, { desc = "현재 파일 실행" })
  end,
}
