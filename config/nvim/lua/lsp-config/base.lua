local M = {}

-- List of all LSP servers to register
M.lsp_list = {
  "pyright",
  "lua_ls",
  "jsonls",
  "bashls",
  "gopls",
  -- Foloow https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonnet_ls to use jsonnet_ls
  "jsonnet_ls",
  -- Add more as needed
  "powershell_es",
  -- Python, Kotlin, Java
  "kotlin_language_server",
  "jdtls",
}

-- Enhanced capabilities (e.g., for nvim-cmp)
M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp.default_capabilities(capabilities)
  end

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = false,
  }

  return capabilities
end

-- Called when any LSP attaches to a buffer
M.on_attach = function(client, bufnr)
  -- Keymaps
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "정의로 이동" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "구현으로 이동" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "참조 목록" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "타입 정의로 이동" }))
  -- K는 단락 이동으로 사용 중이므로 <leader>lh로 hover 접근
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover 문서" }))
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "심볼 이름 변경" }))
  vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "코드 액션" }))
  vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "진단 상세 보기" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "다음 진단" }))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "이전 진단" }))

  -- Optional: LSP formatting
  -- require("lsp-format").on_attach(client)

  -- Optional: navic
  if client.server_capabilities.documentSymbolProvider then
    local ok, navic = pcall(require, "nvim-navic")
    if ok then
      navic.attach(client, bufnr)
    end
  end
end

return M
