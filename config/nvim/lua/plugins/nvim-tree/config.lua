return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "파일 탐색기 토글" },
    },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })

      -- 디렉토리로 nvim 시작 시 파일 트리 자동 열기
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) ~= 1 then return end
          -- 디렉토리 버퍼를 빈 버퍼로 교체 후 트리 열기
          vim.cmd.enew()
          vim.cmd.bw(data.buf)
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end,
      })
    end,
  },
}
