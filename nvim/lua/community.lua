-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- color
  { import = "astrocommunity.color.nvim-highlight-colors" },
  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- debugging
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  -- diagnostics
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- keybindings
  { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },
  -- pack
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.haskell" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.angular" },
  { import = "astrocommunity.pack.dart" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.scala" },
  -- { import = "astrocommunity.pack.kotlin" }, Doesn't work well!
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },
  -- lsp
  { import = "astrocommunity.lsp.delimited-nvim" },
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-endhints" },
  -- markdown & latex
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- neovim-lua-development
  { import = "astrocommunity.neovim-lua-development.helpview-nvim" },
  { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },
  -- quickfix
  { import = "astrocommunity.quickfix.quicker-nvim" },
  -- recipes
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.recipes.neovide" },
  -- scrolling
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  -- search
  { import = "astrocommunity.search.grug-far-nvim" },
  -- utility
  { import = "astrocommunity.utility.noice-nvim" },
  -- import/override with your plugins folder
}
