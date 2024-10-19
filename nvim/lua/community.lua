-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- code-runner
  { import = "astrocommunity.code-runner.overseer-nvim" },
  -- color
  { import = "astrocommunity.color.nvim-highlight-colors" },
  -- editing-support
  { import = "astrocommunity.editing-support.conform-nvim" },
  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- diagnostics
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- docker
  { import = "astrocommunity.docker.lazydocker" },
  -- keybindings
  { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },
  -- lsp
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  { import = "astrocommunity.lsp.lsp-lens-nvim" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  -- motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.nvim-spider" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.nvim-tree-pairs" },
  -- markdown & latex
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- pack
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.fish" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.haskell" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.angular" },
  { import = "astrocommunity.pack.dart" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.scala" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  -- { import = "astrocommunity.pack.zig" },
  -- quickfix
  { import = "astrocommunity.quickfix.quicker-nvim" },
  -- recipes
  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
  { import = "astrocommunity.recipes.neovide" },
  -- scrolling
  { import = "astrocommunity.scrolling.satellite-nvim" },
  -- syntax
  { import = "astrocommunity.syntax.vim-easy-align" },
  -- search
  { import = "astrocommunity.search.grug-far-nvim" },
  -- utility
  { import = "astrocommunity.utility.noice-nvim" },
  -- import/override with your plugins folder
}
