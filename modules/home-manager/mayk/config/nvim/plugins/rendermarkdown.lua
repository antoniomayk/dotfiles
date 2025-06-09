-- vim

local o = vim.o

--=========================================================
--= setup
--=========================================================

require("render-markdown").setup({
  completions = { blink = { enabled = true } },
  anti_conceal = {
    enabled = true,
    ignore = {
      code_background = true,
      sign = true,
      link = true,
    },
    above = 0,
    below = 0,
  },
  win_options = {
    conceallevel = {
      default = o.conceallevel,
      rendered = 3,
    },
    concealcursor = {
      default = o.concealcursor,
      rendered = "",
    },
  },
  injections = {
    gitcommit = {
      enabled = true,
      query = [[
            ((message) @injection.content
                (#set! injection.combined)
                (#set! injection.include-children)
                (#set! injection.language "markdown"))
        ]],
    },
  },
})
