local toggles = {
  clean_mode = true,
}

M = {}

M.clean_mode = function()
  if toggles.clean_mode then
    vim.cmd [[set nolist]]
    vim.cmd [[set signcolumn=no]]
    vim.cmd [[set foldcolumn=0]]
    vim.cmd [[set relativenumber]] -- no
    vim.cmd [[set number]] -- no
    vim.cmd [[set laststatus=0]]
  else
    vim.cmd [[set list]]
    vim.cmd [[set signcolumn=yes]]
    vim.cmd [[set foldcolumn=1]]
    vim.cmd [[set relativenumber]]
    vim.cmd [[set number]]
    vim.cmd [[set laststatus=3]]
  end
  toggles.clean_mode = not toggles.clean_mode
end

return M
