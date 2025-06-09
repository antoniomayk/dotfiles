vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = ".sqlfluff",
  command = "set filetype=ini",
})
