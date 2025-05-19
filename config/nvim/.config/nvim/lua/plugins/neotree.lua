return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>e", "", desc = "explorer" },
      { "<leader>ee", "<cmd>Neotree float reveal toggle<cr>", desc = "Toggle Neo-tree" },
      { "<leader>ef", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
      { "<leader>en", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neo-tree" },
      { "<leader>ec", "<cmd>Neotree close<cr>", desc = "Close Neo-tree" }, -- Or use <leader>ee to toggle
      { "<leader>eN", "<cmd>Neotree float<cr>", desc = "Neo-tree Float" },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
        callback = function()
          local f = vim.fn.expand("%:p")
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd("Neotree current dir=" .. f)
            vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
          end
        end,
      })
    end,
    opts = {
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      source_selector = {
        winbar = false,
        statusline = false,
      },
      window = {
        popup = {
          size = { height = "80%", width = "80%" },
          position = "50%",
        },
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      popup_border_style = "rounded",
      filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {},
        },
        group_empty_dirs = false,
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
    end,
  },
}
