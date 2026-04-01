local python_env = require("utils.python_env")

-- ~/venv가 있으면 추가 경로로 포함
local extra_paths = {}
local venv_site = vim.fn.expand("~/venv/lib/python3.9/site-packages")
if vim.fn.isdirectory(venv_site) == 1 then
  table.insert(extra_paths, venv_site)
end

return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        extraPaths = extra_paths,
      },
      pythonPath = python_env.get_path(),
    },
  },
}
