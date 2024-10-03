-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl({
      formatters = {
        ["google-java-format"] = {
          args = { "--aosp", "-" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        haskell = { "fourmolu", "stylish-haskell" },
        java = { "google-java-format" },
        scala = { "scalafmt" },
        default_format_opts = {
          lsp_format = "fallback",
        },
      },
    }, opts)
  end,
}
