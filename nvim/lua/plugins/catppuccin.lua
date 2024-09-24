-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "catppuccin/nvim",
    opts = function(_, opts) return require("astrocore").extend_tbl({ term_colors = true }, opts) end,
  },
}
