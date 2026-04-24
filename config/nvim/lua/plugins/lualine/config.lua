-- Utility for detecting & caching Python env (Poetry, .venv, system)
-- local python_env = require("utils.python_env")

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- 📁 Current Directory
      local function current_directory()
        return "📁 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end

      -- 🔧 Active LSP
      local function active_lsp()
        local buf_ft = vim.bo.filetype
        local clients = vim.lsp.get_clients()
        for _, client in ipairs(clients) do
          if client.config and client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
            return "🔧 " .. client.name
          end
        end
        return "🔧 No LSP"
      end

      -- -- 🐍 Python venv / Poetry env
      -- local function python_venv()
      --   local name = python_env.get_name()
      --   return (name ~= "" and ("🐍 " .. name)) or ""
      -- end

      -- --  Git branch via gitsigns
      -- local function git_branch()
      --   local branch = vim.b.gitsigns_head
      --   return (branch and (" " .. branch)) or ""
      -- end

      -- Extend the 'x' section of the statusline
      vim.list_extend(opts.sections.lualine_x, {
        current_directory,
        active_lsp,
        -- python_venv,
        -- git_branch,
      })

      -- Winbar: show full path (~/... form) at top of each window
      opts.winbar = {
        lualine_c = {
          { "filename", path = 4, shorting_target = 60, symbols = { modified = " ●", readonly = " " } },
        },
      }
      opts.inactive_winbar = {
        lualine_c = {
          { "filename", path = 4, shorting_target = 60 },
        },
      }
    end,
  },
}
