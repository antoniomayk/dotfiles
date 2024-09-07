local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

lspconfig["bashls"].setup({
  capabilities = cmp_lsp.default_capabilities(),
})
