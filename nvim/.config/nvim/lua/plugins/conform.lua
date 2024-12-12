return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ["xmlformat"] = {
        args = { "--indent-char", " ", "-" },
      },
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
      java = { "google-java-format" },
      scala = { "scalafmt" },
      dart = { "dart_format" },
      xml = { "xmlformat" },
      default_format_opts = {
        lsp_format = "never",
      },
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 10000,
    },
  },
}
