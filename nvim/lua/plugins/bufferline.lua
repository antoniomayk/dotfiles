return {
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          themable = true,
          numbers = "buffer_id",
          indicator = {
            icon = "|",
            style = "icon",
          },
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = false,
            },
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          separator_style = "thick",
          style_preset = bufferline.style_preset.minimal,
        },
      })
    end,
  },
}
