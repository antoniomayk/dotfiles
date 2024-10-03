-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "angularls",
        "basedpyright",
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "emmet_ls",
        "eslint",
        "hls",
        "css_variables",
        "cssls",
        "cssmodules_ls",
        "tailwindcss",
        "unocss",
        "html",
        "jdtls",
        "jsonls",
        "lemminx",
        "lua_ls",
        "ruff",
        "taplo",
        "yamlls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "black",
        "google-java-format",
        "isort",
        "prettierd",
        "ruff",
        "shfmt",
        "stylua",
        "checkstyle",
        "ruff",
        "selene",
        "shellcheck",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "bash",
        "codelldb",
        "python",
        "dart",
        "haskell",
        "javadbg",
        "javatest",
        "js",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
