vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local picker = Snacks.picker

    -- stylua: ignore start
    local mappings = {
      -- { "gd",         picker.lsp_definitions,      mode = { "n" },       desc = "Goto Definition",             has = "definitionProvider",     nowait = false, },
      -- { "gr",         picker.lsp_references,       mode = { "n" },       desc = "References",                  has = "referencesProvider",     nowait = true,  },
      -- { "gI",         picker.lsp_implementations,  mode = { "n" },       desc = "Goto Implementation",         has = "implementationProvider", nowait = false, },
      -- { "gy",         picker.lsp_type_definitions, mode = { "n" },       desc = "Goto T[y]pe Definition",      has = "typeDefinitionProvider", nowait = false, },
      -- { "gD",         picker.lsp_declarations,     mode = { "n" },       desc = "Goto Declaration",            has = "declarationProvider",    nowait = false, },
      -- { "K",          vim.lsp.buf.hover,           mode = { "n" },       desc = "Hover",                       has = "hoverProvider",          nowait = false, },
      -- { "gK",         vim.lsp.buf.signature_help,  mode = { "n" },       desc = "Signature Help",              has = "signatureHelpProvider",  nowait = false, },
      -- { "<c-k>",      vim.lsp.buf.signature_help,  mode = { "i" },       desc = "Signature Help",              has = "signatureHelpProvider",  nowait = false, },
      -- { "<leader>la", vim.lsp.buf.code_action,     mode = { "n", "v" },  desc = "Code Action" ,                has = "codeActionProvider",     nowait = false, },
      -- { "<leader>lc", vim.lsp.codelens.run,        mode = { "n", "v" },  desc = "Run Codelens",                has = "codeLensProvider",       nowait = false, },
      -- { "<leader>lC", vim.lsp.codelens.refresh,    mode = { "n" },       desc = "Refresh & Display Codelens",  has = "codeLensProvider",       nowait = false, },
      -- { "<leader>lr", vim.lsp.buf.rename,          mode = { "n" },       desc = "Rename",                      has = nil,                      nowait = false, },
      { "gd",         picker.lsp_definitions,      mode = { "n" },       desc = "Goto Definition",             has = nil,                      nowait = false, },
      { "gr",         picker.lsp_references,       mode = { "n" },       desc = "References",                  has = nil,                      nowait = true,  },
      { "gI",         picker.lsp_implementations,  mode = { "n" },       desc = "Goto Implementation",         has = nil,                      nowait = false, },
      { "gy",         picker.lsp_type_definitions, mode = { "n" },       desc = "Goto T[y]pe Definition",      has = nil,                      nowait = false, },
      { "gD",         picker.lsp_declarations,     mode = { "n" },       desc = "Goto Declaration",            has = nil,                      nowait = false, },
      { "K",          vim.lsp.buf.hover,           mode = { "n" },       desc = "Hover",                       has = nil,                      nowait = false, },
      { "gK",         vim.lsp.buf.signature_help,  mode = { "n" },       desc = "Signature Help",              has = nil,                      nowait = false, },
      { "<c-k>",      vim.lsp.buf.signature_help,  mode = { "i" },       desc = "Signature Help",              has = nil,                      nowait = false, },
      { "<leader>la", vim.lsp.buf.code_action,     mode = { "n", "v" },  desc = "Code Action" ,                has = nil,                      nowait = false, },
      { "<leader>lc", vim.lsp.codelens.run,        mode = { "n", "v" },  desc = "Run Codelens",                has = nil,                      nowait = false, },
      { "<leader>lC", vim.lsp.codelens.refresh,    mode = { "n" },       desc = "Refresh & Display Codelens",  has = nil,                      nowait = false, },
      { "<leader>lr", vim.lsp.buf.rename,          mode = { "n" },       desc = "Rename",                      has = nil,                      nowait = false, },
    }
    -- stylua: ignore end

    require("utils").lsp_keymaps(ev, mappings)
  end,
})

vim.lsp.enable({ "clangd", "lua-language-server", "rust-analyzer" })
