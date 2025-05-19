vim.diagnostic.config({
  virtual_lines = {
   current_line = true,
  },
})

vim.lsp.config["rust-analyzer"] = {
  cmd = { "rust-analyzer" },
  root_markers = {
    "Cargo.toml",
    "Cargo.lock",
    ".git",
  },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true
      },
      check = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
}

