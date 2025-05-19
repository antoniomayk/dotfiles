return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "^1",
    build = "cargo build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          auto_show = false,
          border = "rounded",
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = false,
          window = {
            border = "rounded",
          },
        },
      },
      signature = {
        window = {
          border = "rounded",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
