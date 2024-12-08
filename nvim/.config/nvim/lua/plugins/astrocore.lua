return {
  "AstroNvim/astrocore",
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = false,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      -- o = {
      --   foldcolumn = "0",
      -- },
      opt = {
        shell = "fish",
        -- number = true,
        -- relativenumber = true,
        colorcolumn = { 80, 120 },
        -- guifont = "JetBrainsMono NF:h12.5:#e-subpixelantialias:#h-slight",
        list = true,
        listchars = {
          eol = "¶",
          tab = "» ",
          extends = "›",
          precedes = "‹",
          trail = "~",
          space = "•",
        },
      },
    },
    mappings = {
      n = {
        -- ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        -- ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<c-w>>"] = { [[<cmd>vertical resize +5<cr>]], desc = "Increase width" },
        ["<c-w><"] = { [[<cmd>vertical resize -5<cr>]], desc = "Decrease width" },
        ["<c-w>+"] = { [[<cmd>horizontal resize +5<cr>]], desc = "Increase height" },
        ["<c-w>-"] = { [[<cmd>horizontal resize -5<cr>]], desc = "Decrease height" },
      },
    },
  },
}
