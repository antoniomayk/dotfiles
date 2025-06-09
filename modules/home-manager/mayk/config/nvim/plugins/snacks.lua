require("snacks").setup({
  bigfile = { enabled = true },
  bufdelete = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = true },
  indent = {
    animate = {
      enabled = true,
      style = "out",
      easing = "linear",
      duration = {
        step = 20,
        total = 200,
      },
    },
    chunk = {
      enabled = true,
      only_current = false,
      priority = 200,
      hl = "SnacksIndentChunk",
      char = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = "─",
      },
    },
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = {
    sources = {
      explorer = {
        title = "",
      },
    },
    layout = {
      layout = {
        backdrop = 100,
      },
    },
  },
  quickfile = { enabled = true },
  rename = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
