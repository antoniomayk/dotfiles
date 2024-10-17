-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = true,
    opts = function(_, opts)
      return require("astrocore").extend_tbl({
        dev_log = {
          enabled = false,
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
      }, opts)
    end,
  }, -- add lsp plugin

  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "dartls")

      opts = require("astrocore").extend_tbl(opts, {
        setup_handlers = {
          -- add custom handler
          dartls = function(_, dartls_opts)
            require("flutter-tools").setup { require("astrocore").extend_tbl({ lsp = dartls_opts }, opts) }
          end,
        },
        config = {
          dartls = {
            -- any changes you want to make to the LSP setup, for example
            color = {
              enabled = true,
            },
            settings = {
              showTodos = true,
              completeFunctionCalls = true,
            },
          },
        },
      })

      return opts
    end,
  },
}
