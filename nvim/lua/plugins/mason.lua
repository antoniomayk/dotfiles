---@type LazySpec
return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "black",
        "google-java-format",
        "isort",
        "prettierd",
        "ruff",
        "shfmt",
        "stylua",
        "ruff",
        "shellcheck",
        "xmlformatter",
      },
    },
  },
}
