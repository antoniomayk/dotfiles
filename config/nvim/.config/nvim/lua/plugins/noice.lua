return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    keys = {
      -- stylua: ignore start
      { "<leader>sn",   "",                                                                             desc = "+noice"                                                                                    },
      { "<S-Enter>",    function() require("noice").redirect(vim.fn.getcmdline()) end,                  desc = "Redirect Cmdline",                  mode = "c",                                            },
      { "<leader>snl",  function() require("noice").cmd("last") end,                                    desc = "Noice Last Message"                                                                        },
      { "<leader>snh",  function() require("noice").cmd("history") end,                                 desc = "Noice History"                                                                             },
      { "<leader>sna",  function() require("noice").cmd("all") end,                                     desc = "Noice All"                                                                                 },
      { "<leader>snd",  function() require("noice").cmd("dismiss") end,                                 desc = "Dismiss All"                                                                               },
      { "<leader>snt",  function() require("noice").cmd("pick") end,                                    desc = "Noice Picker (Telescope/FzfLua)"                                                           },
      { "<c-f>",        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,   desc = "Scroll Forward",                    mode = {"i", "n", "s"} ,  silent = true,  expr = true, },
      { "<c-b>",        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,  desc = "Scroll Backward",                   mode = {"i", "n", "s"},   silent = true,  expr = true, },
      -- stylua: ignore end
    },
    opts = {
      lsp = {
        signature = {
          auto_open = { enabled = false },
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
      },
      popupmenu = {
        backend = "nui",
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        popupmenu = {
          border = {
            style = "rounded",
          },
        },
      },
    },
    config = function(_, opts)
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },
}
