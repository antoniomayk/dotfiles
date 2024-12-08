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
      xml = { "xmlformat" },
      default_format_opts = {
        lsp_format = "never",
      },
    },
  },
}
