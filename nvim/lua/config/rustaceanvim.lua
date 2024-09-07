local g = vim.g
local executors = require("rustaceanvim.executors")

g.rustaceanvim = {
  tools = {
    executor = executors.toggleterm,
    crate_test_executor = executors.toggleterm,
    float_win_config = {
      auto_focus = true,
      open_split = "horizontal",
    },
  },
}
