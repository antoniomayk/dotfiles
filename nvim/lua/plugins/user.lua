---@type LazySpec
return {
  {
    dir = "~/.config/nvim/theme",
    name = "catppuccin",
    opts = {
      term_colors = true,
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "bold", "italic" },
        loops = {},
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = { "bold" },
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = function() return math.max(120, vim.o.columns * 0.75) end,
        height = 1,
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      default = {
        display = function(list_item)
          local function shortenPathWithFirstLetter(path)
            local components = {}
            for component in path:gmatch "([^/\\]+)" do
              table.insert(components, component)
            end
            for i = 1, #components - 1 do
              components[i] = components[i]:sub(1, 1)
            end
            return table.concat(components, "/")
          end
          return shortenPathWithFirstLetter(list_item.value)
        end,
      },
    },
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
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      source_selector = {
        winbar = false,
      },
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      filesystem = {
        window = {
          mappings = {
            ["/"] = "telescope_find",
            [";"] = "telescope_grep",
          },
        },
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {},
        },
        group_empty_dirs = false,
      },
      commands = {
        telescope_find = function(state)
          local node = state.tree:get_node()
          if node.type == "file" then node = state.tree:get_node(node:get_parent_id()) end
          local path = node:get_id()
          require("telescope.builtin").find_files(require("utils").getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          if node.type == "file" then node = state.tree:get_node(node:get_parent_id()) end
          local path = node:get_id()
          require("telescope.builtin").live_grep(require("utils").getTelescopeOpts(state, path))
        end,
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },

  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = {
        "toggleterm",
        direction = "float",
        highlights = nil,
        auto_scroll = nil,
        close_on_exit = false,
        quit_on_exit = "always",
        open_on_start = true,
        hidden = false,
        on_create = nil,
      },
    },
  },

  {
    "heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },
}
