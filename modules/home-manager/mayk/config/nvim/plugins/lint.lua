require("lint").linters_by_ft = {
  bash = { "bash" },
  java = { "checkstyle" },
  sql = { "sqlfluff" },
  yaml = { "yamllint" },
  ["yaml.docker-compose"] = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWinEnter", "BufRead", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
