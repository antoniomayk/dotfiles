local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

lspconfig["lua_ls"].setup({
  capabilities = cmp_lsp.default_capabilities(),
})
