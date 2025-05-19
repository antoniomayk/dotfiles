return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    event = { "BufWritePre" },
    -- stylua: ignore start
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true }) end, mode = { "n", "v" },  desc = "Format Injected Langs	" },
    },
    -- stylua: ignore end
    opts = {
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
        xml = { "xmlformat" },
        default_format_opts = {
          lsp_format = "never",
        },
      },
      formatters = {
        ["xmlformat"] = {
          args = { "--indent-char", " ", "-" },
        },
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    },
  },
}
