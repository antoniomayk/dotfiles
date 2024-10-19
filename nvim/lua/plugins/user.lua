-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = true,
    },
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      hide_numbers = false,
      winbar = {
        enabled = true,
      },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = function(_, opts)
      -- opts.templates = { "builtin", "user.cpp_build" }
      opts.default_template_prompt = "always"
    end,
  },

  {
    "onsails/lspkind.nvim",
    opts = {
      maxwidth = 35,
      -- before = nil
      show_labelDetails = false,
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      -- opts variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"

      -- require "cmp".config.window.bordered

      -- Check supported formatters and linters
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

      -- Only insert new sources, do not replace the existing ones
      -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        -- Set a formatter
        -- null_ls.builtins.diagnostics.checkstyle.with {
        --   extra_args = { "-c", "/sun_checks.xml" }, -- or "/google_checks.xml" or path to self written rules
        -- },
        null_ls.builtins.diagnostics.checkstyle.with {
          extra_args = { "-c", "/google_checks.xml" }, -- or "/google_checks.xml" or path to self written rules
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["xmlformat"] = {
          args = { "--indent-char", " ", "-" },
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
        xml = { "xmlformat" },
        default_format_opts = {
          lsp_format = "never",
        },
      },
    },
  },

  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        vim.fn.stdpath "data" .. "/lazy",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 70,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
  },

  {
    "scalameta/nvim-metals",
    opts = function(_, opts)
      opts.inlayHints = {
        hintsInPatternMatch = { enable = true },
        implicitArguments = { enable = true },
        implicitConversions = { enable = true },
        inferredTypes = { enable = true },
        typeParameters = { enable = true },
      }
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    opts = {
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

  {
    "mrcjkb/haskell-tools.nvim",
    opts = {
      tools = {
        hoogle = {
          mode = "telescope-local",
        },
        hover = {
          auto_focus = true,
        },
        definition = {
          hoogle_signature_fallback = true,
        },
        repl = {
          handler = "toggleterm",
        },
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    opts = function()
      local executors = require "rustaceanvim.executors"

      return {
        tools = {
          executor = executors.toggleterm,
          crate_test_executor = executors.toggleterm,
          float_win_config = {
            auto_focus = true,
            open_split = "horizontal",
            border = "rounded",
          },
        },
      }
    end,
  },

  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- Disabling AstroNvim Core plugins

  -- { "folke/lazydev.nvim", enabled = false },
  -- { "stevearc/dressing.nvim", enabled = false },
}
