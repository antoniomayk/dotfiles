require("which-key").setup({
  preset = "helix",
  defaults = {},
  win = {
    no_overlap = true,
    border = "rounded",
    padding = { 1, 2 },
    title = true,
    title_pos = "center",
    zindex = 1000,
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
    ellipsis = "…",
    mappings = false,
  },
  spec = {
    {
      mode = { "n", "v" },
      { "[", group = "Unimpaired" },
      { "]", group = "Unimpaired" },
      { "g", group = "Goto" },
      { "<leader>", group = "Space" },
      {
        "<leader>w",
        group = "Window",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
  },
})
