return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})

      local api = vim.api
      local keymap = vim.keymap

      api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            keymap.set(mode, lhs, rhs, opts)
          end

          -- stylua: ignore start
          bufmap('n', 'K',    '<cmd>lua vim.lsp.buf.hover()<cr>')             -- Displays hover information about the symbol under the cursor
          bufmap('n', 'gd',   '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')        -- Jump to the definition
          bufmap('n', 'gD',   '<cmd>lua vim.lsp.buf.declaration()<cr>')       -- Jump to declaration
          bufmap('n', 'gi',   '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')    -- Lists all the implementations for the symbol under the cursor
          bufmap('n', 'go',   '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')   -- Jumps to the definition of the type symbol
          bufmap('n', 'gr',   '<cmd>lua require("telescope.builtin").lsp_references()<cr>')        -- Lists all the references 
          bufmap('n', 'gs',   '<cmd>lua vim.lsp.buf.signature_help()<cr>')    -- Displays a function's signature information
          bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')            -- Renames all references to the symbol under the cursor
          bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')       -- Selects a code action available at the current cursor position
          bufmap('n', 'gl',   '<cmd>lua require("telescope.builtin").diagnostics()<cr>')     -- Show diagnostics in a floating window
          bufmap('n', '[d',   '<cmd>lua vim.diagnostic.goto_prev()<cr>')      -- Move to the previous diagnostic
          bufmap('n', ']d',   '<cmd>lua vim.diagnostic.goto_next()<cr>')      -- Move to the next diagnostic

          -- ^ builtin.lsp_references	Lists LSP references for word under the cursor
          -- builtin.lsp_incoming_calls	Lists LSP incoming calls for word under the cursor
          -- builtin.lsp_outgoing_calls	Lists LSP outgoing calls for word under the cursor
          -- builtin.lsp_document_symbols	Lists LSP document symbols in the current buffer
          -- builtin.lsp_workspace_symbols	Lists LSP document symbols in the current workspace
          -- builtin.lsp_dynamic_workspace_symbols	Dynamically Lists LSP for all workspace symbols
          -- ^ builtin.diagnostics	Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
          -- ^ builtin.lsp_implementations	Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
          -- ^ builtin.lsp_definitions	Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
          -- ^ builtin.lsp_type_definitions	Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope

          -- stylua: ignore end
        end,
      })
    end,
  },
}
