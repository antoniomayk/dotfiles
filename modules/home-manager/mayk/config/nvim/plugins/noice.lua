require("noice").setup({
  lsp = {
    signature = {
      auto_open = { enabled = false },
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = false,
    },
  },
  popupmenu = {
    backend = "nui",
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },
  views = {
    popupmenu = {
      border = {
        style = "rounded",
      },
    },
  },
})
