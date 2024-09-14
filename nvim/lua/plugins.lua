return {
  -- keymaps
  --

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      win = {
        border = "rounded",
      },
      defaults = {},
      spec = {
        -- stylua: ignore
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "Tabs" },
          { "<leader>c", group = "Code" },
          { "<leader>f", group = "File/Find" },
          { "<leader>g", group = "Git" },
          { "<leader>d", group = "Debug" },
          { "<leader>gh", group = "Hunks" },
          { "<leader>q", group = "Quit/Session" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Test", icon = { icon = "󰙨", color = "green" }},
          { "<leader>u", group = "UI", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "Prev" },
          { "]", group = "Next" },
          { "g", group = "Goto" },
          { "gs", group = "Surround" },
          { "z", group = "Fold" },
          { "<leader>b", group = "Buffer", expand = function() return require("which-key.extras").expand.buf() end },
          { "<leader>w", group = "Windows", proxy = "<c-w>", expand = function() return require("which-key.extras").expand.win() end },
          { "gx", desc = "Open with system app" },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
      { "<c-w><space>", function() require("which-key").show({ keys = "<c-w>", loop = true }) end, desc = "Window Hydra Mode (which-key)" },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },

  -- ui
  --

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() vim.cmd("colorscheme catppuccin-mocha") end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "muniftanjim/nui.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice last message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice history" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice all" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss all" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice picker (telescope)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    -- stylua: ignore
    keys = {
      { "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss all notifications" },
    },
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
      on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 100 }) end,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      -- stylua: ignore
      local colors = {
        bg       = '#181825',
        fg       = '#cdd6f4',
        yellow   = '#f9e2af',
        cyan     = '#94e2d5',
        darkblue = '#74c7ec',
        green    = '#a6e3a1',
        orange   = '#fab387',
        violet   = '#cba6f7',
        magenta  = '#f5c2e7',
        blue     = '#89b4fa',
        red      = '#f38ba8',
      }
      local conditions = {
        buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
        hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }
      local function ins_left(component) table.insert(config.sections.lualine_c, component) end
      local function ins_right(component) table.insert(config.sections.lualine_x, component) end
      ins_left({
        function() return " " end,
        color = { fg = colors.bg },
        padding = { left = 0 },
      })
      ins_left({
        function() return "" end,
        color = function()
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      })
      ins_left({
        "filesize",
        cond = conditions.buffer_not_empty,
      })
      ins_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      })
      ins_left({ "location" })
      ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      })
      ins_left({
        function() return "%=" end,
      })
      ins_left({
        function()
          local msg = "NO ACTIVE LSP"
          local buf_ft = vim.api.nvim_get_option_value("filetype", {})
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then return string.upper(msg) end
          for _, client in ipairs(clients) do
            ---@diagnostic disable-next-line: undefined-field
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return string.upper(client.name) end
          end
          return msg
        end,
        icon = "  LSP:",
        color = { fg = "#ffffff", gui = "bold" },
      })
      ins_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
      })
      ins_right({
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      })
      ins_right({
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      })
      ins_right({
        function() return "" end,
        color = { fg = colors.bg },
        padding = { left = 1 },
      })
      lualine.setup(config)
    end,
  },

  -- buffer
  --

  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", mode = "n", desc = "Delete Buffer" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete other buffers" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = {
      options = {
        themable = true,
        numbers = "buffer_id",
        indicator = {
          icon = "|",
          style = "icon",
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = false,
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        separator_style = "thick",
        -- style_preset = require("bufferline").style_preset.minimal,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("nvim-tree").setup({}) end,
    keys = {
      { "<leader>n", group = "NvimTree" },
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "Explorer (root dir)" },
      { "<leader>fe", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "Explorer (root dir)" },
    },
  },

  --- <leader>be	Buffer Explorer	n
  --- <leader>e	Explorer NeoTree (Root Dir)	n
  --- <leader>E	Explorer NeoTree (cwd)	n
  --- <leader>fe	Explorer NeoTree (Root Dir)	n
  --- <leader>fE	Explorer NeoTree (cwd)	n
  --- <leader>ge	Git Explorer	n

  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = function()
      local logo = [[
  
   ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
   ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
  ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
  ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
  ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
  ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
           ░    ░  ░    ░ ░        ░   ░         ░   
                                  ░                  
    ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            --stylua: ignore start
            { action = "Telescope find_files",                                          desc = " Find File",        icon = " ",    key = "f" },
            { action = "Telescope find_files follow=true no_ignore=true hidden=true",   desc = " Find All Files",   icon = " ",    key = "a" },
            { action = "ene | startinsert",                                             desc = " New File",         icon = " ",    key = "n" },
            { action = "Telescope oldfiles",                                            desc = " Recent Files",     icon = " ",    key = "r" },
            { action = "Telescope live_grep",                                           desc = " Find Text",        icon = " ",    key = "g" },
            { action =  function() require("persistence").load() end,                   desc = " Restore Session",  icon = " ",    key = "s" },
            --stylua: ignore end
            {
              action = function()
                local config = "~/.config/nvim/"
                local telescope = require("telescope.builtin")
                local fn = vim.fn
                fn.chdir(config)
                telescope.find_files()
              end,
              desc = " Config",
              icon = " ",
              key = "c",
            },
            {
              action = function() vim.api.nvim_input("<cmd>qa<cr>") end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function() vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" }) end)
          end,
        })
      end
      return opts
    end,
  },

  -- editor
  --

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = true,
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = true,
      enable_bracket_in_quote = true, --
      enable_abbr = false,
      break_undo = true,
      check_ts = false,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    },
  },

  {
    "nmac427/guess-indent.nvim",
    opts = {
      auto_cmd = true,
      override_editorconfig = false,
      filetype_exclude = { "netrw", "tutor" },
      buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
      on_tab_options = {
        ["expandtab"] = false,
      },
      on_space_options = {
        ["expandtab"] = true,
        ["tabstop"] = "detected",
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    -- stylua: ignore
    keys = {
      { "<leader>ft", "<cmd>ToggleTerm direction=float<cr>", mode = { "n" }, desc = "Terminal" },
    },
  },

  {
    "smjonas/inc-rename.nvim",
    config = function() require("inc_rename").setup({}) end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })
      end)
      require("ibl").setup({
        indent = { highlight = highlight, char = "┆" },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
        exclude = {
          filetypes = { "dashboard" },
        },
      })
    end,
  },

  -- code
  --

  {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    -- stylua: ignore
    keys = {
      { "<leader>cF", function() require('conform').format({ lsp_fallback = true }) end, mode = { "n", "v" }, desc = "Format injected langs" },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
    },
  },

  {
    "whoissethdaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", mode = "n", desc = "Mason" },
    },
    config = function()
      local mason = require("mason")
      local mason_installer = require("mason-tool-installer")
      mason.setup({})
      mason_installer.setup({
        ensure_installed = {
          -- rust
          "codelldb",
          "rust-analyzer",
          -- lua
          "lua-language-server",
          "stylua",
          -- bash
          "bash-language-server",
          "shellcheck",
          "shfmt",
          -- vim
          "vim-language-server",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (trouble)" },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle focus=true<cr>", desc = "Todo (trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle focus=true filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- search

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
      "nvim-telescope/telescope-project.nvim",
    },
    -- stylua: ignore
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch buffer" },
      { "<leader>/", function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<leader><space>", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find files (root dir)", }, { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all files (Root Dir)" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files (Root Dir)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fp", function() require("telescope").extensions.project.project() end, desc = "Projects" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
      { "<leader>s\"", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", function() require('telescope').extensions.live_grep_args.live_grep_args() end, desc = "Grep (root dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search highlight groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location list" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix list" },
      { "<leader>uC", function() require('telescope.builtin').colorscheme({enable_preview = true}) end, desc = "Colorscheme with preview" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          ".git/",
          ".cache",
          "%.o",
          "%.a",
          "%.out",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
      },
    },
    -- stylua: ignore
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("project")
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function()
          local map = vim.keymap.set
          map("n", "cl", "<cmd>LspInfo<cr>", { buffer = true, desc = "Lsp Info" })
          map("n", "gd", "<cmd>lua require(\"telescope.builtin\").lsp_definitions()<cr>", { buffer = true, desc = "Goto definition" })
          map("n", "gr", "<cmd>lua require(\"telescope.builtin\").lsp_references()<cr>", { buffer = true, desc = "References" })
          map("n", "gI", "<cmd>lua require(\"telescope.builtin\").lsp_implementations()<cr>", { buffer = true, desc = "Goto implementation" })
          map("n", "gy", "<cmd>lua require(\"telescope.builtin\").lsp_type_definitions()<cr>", { buffer = true, desc = "Goto t[y]pe definition" })
          map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = true, desc = "Goto declaration" })
          map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = true, desc = "Hover" })
          map("n", "gl", "<cmd>lua require(\"telescope.builtin\").diagnostics()<cr>", { buffer = true, desc = "Diagnostics" })
          map("n", "c-k", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { buffer = true, desc = "Signature Help" })
          map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = true, desc = "Code action" })
          map("n", "<leader>cc", "<cmd>lua vim.lsp.codelens.run()<cr>", { buffer = true, desc = "Run codelens" })
          map("n", "<leader>cC", "<cmd>lua vim.lsp.codelens.refresh()<cr>", { buffer = true, desc = "Refresh & Display codelens" })
          map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = true, desc = "Rename" })
        end,
      })
    end,
  },

  -- debug & test

  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
    keys = function()
      ---@param config {args?:string[]|fun():string[]?}
      local function get_args(config)
        local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
        config = vim.deepcopy(config)
        ---@cast args string[]
        config.args = function()
          local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
          return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
        end
        return config
      end
      -- stylua: ignore
      return {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover(nil, { border = 'rounded' }) end, desc = "Widgets" },
      }
    end,
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      local vscode = require("dap.ext.vscode")
      vscode.json_decode = require("json5").parse
      if vim.fn.filereadable(".vscode/launch.json") then vscode.load_launchjs() end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {},
    },
    config = function() end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap", suite = false }) end, desc = "Debug Nearest" },
    },
    opts = {
      -- stylua: ignore
      icons = {
        running_animated = { "⠋", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋" },
        passed = "",
        running = "",
        failed = "",
        skipped = "",
        unknown = "",
        watching = "󰈈",
        notify = "",
        non_collapsible = "─",
        collapsed = "─",
        expanded = "╮",
        child_prefix = "├",
        final_child_prefix = "╰",
        child_indent = "│",
        final_child_indent = " ",
      },
      adapters = {
        "neotest-rust",
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function() require("trouble").open({ mode = "quickfix", focus = false }) end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      opts.consumers = opts.consumers or {}
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then return end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))
          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == "failed" and tree:get_key(pos_id) then failed = failed + 1 end
          end
          vim.schedule(function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then trouble.close() end
            end
          end)
          return {}
        end
      end
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then config = require(config) end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end
      require("neotest").setup(opts)
    end,
  },

  -- lsp
  --

  {
    { "neovim/nvim-lspconfig" },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-calc" },
        { "l3mon4d3/LuaSnip" },
      },
      opts = function()
        local cmp = require("cmp")
        return {
          snippet = {
            expand = function(args) require("luasnip").lsp_expand(args.body) end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "crates" },
          }, {
            { name = "buffer" },
          }, {
            name = "lazydev",
            group_index = 0,
          }),
        }
      end,
      config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup(opts)
        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
          matching = {
            disallow_fuzzy_matching = false,
            disallow_fullfuzzy_matching = false,
            disallow_partial_fuzzy_matching = false,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = false,
            disallow_symbol_nonprefix_matching = false,
          },
        })
      end,
    },
  },

  -- rust

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function()
      local wk = require("which-key")
      local executors = require("rustaceanvim.executors")
      vim.g.rustaceanvim = {
        tools = {
          executor = executors.toggleterm,
          crate_test_executor = executors.toggleterm,
          float_win_config = {
            auto_focus = true,
            open_split = "horizontal",
          },
        },
      }
      -- stylua: ignore
      wk.add({
        { "<leader>r",                                                                group = "Rustacean", icon = { icon = "", color = "red" }},
        { "<leader>rx",    "<cmd>RustLsp expandMacro<cr>",                mode = "n", desc  = "Format" },
        { "<leader>ra",    "<cmd>RustLsp hover actions<cr>",              mode = "n", desc  = "Actions" },
        { "<leader>rj",    "<cmd>RustLsp joinLines<cr>",                  mode = "n", desc  = "Join Lines" },
        -- Errors
        { "<leader>re",                                                               group = "Errors", icon = { icon = "", color = "red" }},
        { "<leader>rec",   "<cmd>RustLsp explainError current<cr>",       mode = "n", desc  = "Current" },
        { "<leader>ren",   "<cmd>RustLsp explainError cycle<cr>",         mode = "n", desc  = "Next" },
        -- Diagnostics
        { "<leader>rd",                                                               group = "Diagnostics" },
        { "<leader>rdc",   "<cmd>RustLsp renderDiagnostic current<cr>",   mode = "n", desc  = "Current" },
        { "<leader>rdn",   "<cmd>RustLsp renderDiagnostic cycle<cr>",     mode = "n", desc  = "Next" },
        -- Move Items
        { "<leader>rm",                                                               group = "Move Items" },
        { "<leader>rmu",   "<cmd>RustLsp moveItem up<cr>",                mode = "n", desc  = "Up" },
        { "<leader>rmd",   "<cmd>RustLsp moveItem down<cr>",              mode = "n", desc  = "Down" },
        -- Open
        { "<leader>ro",                                                               group = "Open", icon = { icon = "", color = "cyan"}},
        { "<leader>rod",   "<cmd>RustLsp openDocs<cr>",                   mode = "n", desc  = "Docs" },
        { "<leader>roc",   "<cmd>RustLsp openCargo<cr>",                  mode = "n", desc  = "Cargo.toml" },
        -- Fly Check
        { "<leader>rc",                                                               group = "Fly [C]heck", icon = { icon = "", color = "green"}},
        { "<leader>rcr",   "<cmd>RustLsp flyCheck run<cr>",               mode = "n", desc  = "Run" },
        { "<leader>rcc",   "<cmd>RustLsp flyCheck clear<cr>",             mode = "n", desc  = "Clear" },
        { "<leader>rcC",   "<cmd>RustLsp flyCheck cancel<cr>",            mode = "n", desc  = "Cancel" },
        -- Unpretty
        { "<leader>ru",                                                               group = "Unpretty", icon = { icon = "󰮳", color = "grey" }},
        { "<leader>rur",   "<cmd>Rustc unpretty hir<cr>",                 mode = "n", desc  = "HIR" },
        { "<leader>ruc",   "<cmd>Rustc unpretty mir<cr>",                 mode = "n", desc  = "MIR" },
        -- Runnables
        { "<leader>rr",                                                               group = "Run", icon = { icon = "", color = "green"}},
        { "<leader>rrr",   "<cmd>RustLsp run<cr>",                        mode = "n", desc  = "Run target" },
        { "<leader>rrl",   "<cmd>RustLsp runnables<cr>",                  mode = "n", desc  = "List availables target" },
        { "<leader>rrp",   "<cmd>RustLsp[!] runnables<cr>",               mode = "n", desc  = "Run previous runnables" },
        { "<leader>rra",   "<cmd>RustLsp runnables ",                     mode = "n", desc  = "Custom arguments" },
        -- Debuggables
        { "<leader>rD",                                                               group = "Debug" },
        { "<leader>rDr",   "<cmd>RustLsp debug<cr>",                      mode = "n", desc  = "Run" },
        { "<leader>rDl",   "<cmd>RustLsp debuggables<cr>",                mode = "n", desc  = "List debuggables" },
        { "<leader>rDp",   "<cmd>RustLsp[!] debuggables<cr>",             mode = "n", desc  = "List previous debuggables" },
        { "<leader>rDa",   "<cmd>RustLsp debuggables ",                   mode = "n", desc  = "Debuggables (Override args)" },
        -- Testables
        { "<leader>rt",                                                               group = "Test", icon = { icon = "󰙨", color = "green" }},
        { "<leader>rtr",   "<cmd>RustLsp testables<cr>",                  mode = "n", desc  = "Run tests" },
        { "<leader>rtp",   "<cmd>RustLsp[!] testables<cr>",               mode = "n", desc  = "Run the previous testables" },
        { "<leader>rtc",   "<cmd>RustLsp testables ",                     mode = "n", desc  = "Override args" },
      })
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "stable",
    config = function()
      require("crates").setup({
        {
          smart_insert = true,
          insert_closing_quote = true,
          autoload = true,
          autoupdate = true,
          autoupdate_throttle = 250,
          loading_indicator = true,
          search_indicator = true,
          date_format = "%Y-%m-%d",
          thousands_separator = ".",
          notification_title = "crates.nvim",
          curl_args = { "-sL", "--retry", "1" },
          max_parallel_requests = 80,
          open_programs = { "xdg-open", "open" },
          expand_crate_moves_cursor = true,
          enable_update_available_warning = true,
          on_attach = function(_) end,
          text = {
            searching = "   Searching",
            loading = "   Loading",
            version = "   %s",
            prerelease = "   %s",
            yanked = "   %s",
            nomatch = "   No match",
            upgrade = "   %s",
            error = "   Error fetching crate",
          },
          highlight = {
            searching = "CratesNvimSearching",
            loading = "CratesNvimLoading",
            version = "CratesNvimVersion",
            prerelease = "CratesNvimPreRelease",
            yanked = "CratesNvimYanked",
            nomatch = "CratesNvimNoMatch",
            upgrade = "CratesNvimUpgrade",
            error = "CratesNvimError",
          },
          popup = {
            autofocus = false,
            hide_on_select = false,
            copy_register = "\"",
            style = "minimal",
            border = "rounded",
            show_version_date = false,
            show_dependency_version = true,
            max_height = 30,
            min_width = 20,
            padding = 1,
            text = {
              title = " %s",
              pill_left = "",
              pill_right = "",
              description = "%s",
              created_label = " created        ",
              created = "%s",
              updated_label = " updated        ",
              updated = "%s",
              downloads_label = " downloads      ",
              downloads = "%s",
              homepage_label = " homepage       ",
              homepage = "%s",
              repository_label = " repository     ",
              repository = "%s",
              documentation_label = " documentation  ",
              documentation = "%s",
              crates_io_label = " crates.io      ",
              crates_io = "%s",
              lib_rs_label = " lib.rs         ",
              lib_rs = "%s",
              categories_label = " categories     ",
              keywords_label = " keywords       ",
              version = "  %s",
              prerelease = " %s",
              yanked = " %s",
              version_date = "  %s",
              feature = "  %s",
              enabled = " %s",
              transitive = " %s",
              normal_dependencies_title = " Dependencies",
              build_dependencies_title = " Build dependencies",
              dev_dependencies_title = " Dev dependencies",
              dependency = "  %s",
              optional = " %s",
              dependency_version = "  %s",
              loading = "  ",
            },
            highlight = {
              title = "CratesNvimPopupTitle",
              pill_text = "CratesNvimPopupPillText",
              pill_border = "CratesNvimPopupPillBorder",
              description = "CratesNvimPopupDescription",
              created_label = "CratesNvimPopupLabel",
              created = "CratesNvimPopupValue",
              updated_label = "CratesNvimPopupLabel",
              updated = "CratesNvimPopupValue",
              downloads_label = "CratesNvimPopupLabel",
              downloads = "CratesNvimPopupValue",
              homepage_label = "CratesNvimPopupLabel",
              homepage = "CratesNvimPopupUrl",
              repository_label = "CratesNvimPopupLabel",
              repository = "CratesNvimPopupUrl",
              documentation_label = "CratesNvimPopupLabel",
              documentation = "CratesNvimPopupUrl",
              crates_io_label = "CratesNvimPopupLabel",
              crates_io = "CratesNvimPopupUrl",
              lib_rs_label = "CratesNvimPopupLabel",
              lib_rs = "CratesNvimPopupUrl",
              categories_label = "CratesNvimPopupLabel",
              keywords_label = "CratesNvimPopupLabel",
              version = "CratesNvimPopupVersion",
              prerelease = "CratesNvimPopupPreRelease",
              yanked = "CratesNvimPopupYanked",
              version_date = "CratesNvimPopupVersionDate",
              feature = "CratesNvimPopupFeature",
              enabled = "CratesNvimPopupEnabled",
              transitive = "CratesNvimPopupTransitive",
              normal_dependencies_title = "CratesNvimPopupNormalDependenciesTitle",
              build_dependencies_title = "CratesNvimPopupBuildDependenciesTitle",
              dev_dependencies_title = "CratesNvimPopupDevDependenciesTitle",
              dependency = "CratesNvimPopupDependency",
              optional = "CratesNvimPopupOptional",
              dependency_version = "CratesNvimPopupDependencyVersion",
              loading = "CratesNvimPopupLoading",
            },
            keys = {
              hide = { "q", "<esc>" },
              open_url = { "<cr>" },
              select = { "<cr>" },
              select_alt = { "s" },
              toggle_feature = { "<cr>" },
              copy_value = { "yy" },
              goto_item = { "gd", "K", "<C-LeftMouse>" },
              jump_forward = { "<c-i>" },
              jump_back = { "<c-o>", "<C-RightMouse>" },
            },
          },
          completion = {
            insert_closing_quote = true,
            text = {
              prerelease = "  pre-release ",
              yanked = "  yanked ",
            },
            cmp = {
              enabled = true,
              use_custom_kind = true,
              kind_text = {
                version = "Version",
                feature = "Feature",
              },
              kind_highlight = {
                version = "CmpItemKindVersion",
                feature = "CmpItemKindFeature",
              },
            },
            coq = {
              enabled = false,
              name = "crates.nvim",
            },
            crates = {
              enabled = false,
              min_chars = 3,
              max_results = 8,
            },
          },
          null_ls = {
            enabled = false,
            name = "crates.nvim",
          },
          lsp = {
            enabled = true,
            name = "crates.nvim",
            on_attach = nil,
            actions = true,
            completion = true,
            hover = true,
          },
        },
      })
    end,
  },

  -- lua

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        "luvit-meta/library",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        "LazyVim",
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
      },
      enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. "/.luarc.json") end,
    },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
  },

  -- markdown

  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
}
