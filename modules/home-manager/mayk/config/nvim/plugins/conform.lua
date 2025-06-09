require("conform").setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    markdown = { "markdown-toc" },
    sh = { "shfmt" },
    c = { "clang-format" },
    cmake = { "cmake_format" },
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt" },
    haskell = { "fourmolu", "stylish-haskell" },
    java = { "google-java-format", lsp_format = "never" },
    scala = { "scalafmt" },
    sql = { "sqlfluff" },
    xml = { "xmlformat" },
    default_format_opts = {
      lsp_format = "never",
    },
  },
  notify_on_error = true,
  notify_no_formatters = true,
})
