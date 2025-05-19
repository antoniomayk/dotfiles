return {
  {
    "nmac427/guess-indent.nvim",
    lazy = false,
    opts = {},
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1d2021",
    },
  },

  {
    "brenoprata10/nvim-highlight-colors",
    cmd = "HighlightColors",
    event = { "BufRead" },
    opts = {
      render = "background",
      virtual_symbol = "󱓻",
      virtual_symbol_prefix = "",
      virtual_symbol_suffix = " ",
      virtual_symbol_position = "inline",
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_ansi = true,
      enable_hsl_without_function = true,
      enable_var_usage = true,
      enable_named_colors = true,
      enable_tailwind = false,
    },
  },

  { "mfussenegger/nvim-jdtls" },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    lazy = false,
    opts = {},
  },

  {
    "junegunn/vim-easy-align",
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
  },

  {
    "yorickpeterse/nvim-tree-pairs",
    opts = {},
  },

  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {
  --     restricted_keys = {
  --       ["b"] = { "n", "x" },
  --       ["e"] = { "n", "x" },
  --       ["w"] = { "n", "x" },
  --     },
  --     max_time = 1000,
  --     max_count = 2,
  --     timeout = 1000,
  --     disable_mouse = false,
  --     allow_different_key = true,
  --   },
  -- },

  -- {
  --   "chrisgrieser/nvim-spider",
  --   keys = {
  --     { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
  --     { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
  --     { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
  --   },
  -- },

  -- {
  --   "tris203/precognition.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     startVisible = true,
  --     showBlankVirtLine = true,
  --     highlightColor = { link = "Comment" },
  --     hints = {
  --          Caret = { text = "^", prio = 2 },
  --          Dollar = { text = "$", prio = 1 },
  --          MatchingPair = { text = "%", prio = 5 },
  --          Zero = { text = "0", prio = 1 },
  --          w = { text = "w", prio = 10 },
  --          b = { text = "b", prio = 9 },
  --          e = { text = "e", prio = 8 },
  --          W = { text = "W", prio = 7 },
  --          B = { text = "B", prio = 6 },
  --          E = { text = "E", prio = 5 },
  --     },
  --     gutterHints = {
  --         G = { text = "G", prio = 10 },
  --         gg = { text = "gg", prio = 9 },
  --         PrevParagraph = { text = "{", prio = 8 },
  --         NextParagraph = { text = "}", prio = 8 },
  --     },
  --     disabled_fts = {
  --         "startify",
  --     },
  --   },
  -- },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = 10000,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr)
          return true
        end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
        -- disable_keymaps: disable default keymaps
        disable_keymaps = false,
      })
    end,
  },
}
