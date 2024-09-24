-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function(_, opts)
      local executors = require "rustaceanvim.executors"
      vim.g.rustaceanvim = require("astrocore").extend_tbl(
        require("astrocore").extend_tbl({
          tools = {
            executor = executors.toggleterm,
            crate_test_executor = executors.toggleterm,
            float_win_config = {
              auto_focus = true,
              open_split = "horizontal",
              border = "rounded",
            },
          },
        }, opts),
        vim.g.rustaceanvim
      )
    end,
  },
}
