-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    config = function(_, opts)
      vim.g.haskell_tools = require("astrocore").extend_tbl(
        require("astrocore").extend_tbl({
          tools = {
            hoogle = {
              mode = "telescope-local",
            },
            hover = {
              auto_focus = true,
            },
            definition = {
              hoogle_signature_fallback = true,
            },
            repl = {
              handler = "toggleterm",
            },
          },
        }, opts),
        vim.g.haskell_tools
      )
    end,
  },
}
