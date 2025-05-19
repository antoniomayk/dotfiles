vim.diagnostic.config({ virtual_text = true })

vim.lsp.config["clangd"] = {
  cmd = { "clangd" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
}
