return {
  { "<leader>ff", "<cmd>Telescope find_files<cr>",            desc = "파일 찾기",          noremap = true },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>",             desc = "전체 텍스트 검색",   noremap = true },
  { "<leader>fb", "<cmd>Telescope buffers<cr>",               desc = "버퍼 목록",          noremap = true },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>",              desc = "최근 파일",          noremap = true },
  { "<leader>fr", "<cmd>Telescope resume<cr>",                desc = "마지막 검색 재개",   noremap = true },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>",             desc = "도움말 검색",        noremap = true },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>",               desc = "키맵 검색",          noremap = true },
  { "<leader>fm", "<cmd>Telescope marks<cr>",                 desc = "마크 목록",          noremap = true },
  { "<leader>fC", "<cmd>Telescope commands<cr>",              desc = "명령어 목록",        noremap = true },
  { "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "문서 심볼 (LSP)",    noremap = true },
  { "<leader>fws", "<cmd>Telescope lsp_workspace_symbols<cr>",desc = "워크스페이스 심볼",  noremap = true },
  { "<leader>ft", "<cmd>Telescope treesitter<cr>",            desc = "Treesitter 심볼",   noremap = true },
  {
    "<leader>fP",
    function()
      require("telescope.builtin").find_files({
        cwd = require("lazy.core.config").options.root,
      })
    end,
    desc = "플러그인 파일 찾기",
  },
}
