require("blink.cmp").setup({
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
})
