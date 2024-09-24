-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "rust",
      "java",
      "scala",
      "kotlin",
      "html",
      "css",
      "javascript",
      "typescript",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
