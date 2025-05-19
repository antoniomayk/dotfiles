M = {}

M.lsp_keymaps = function(ev, mappings)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)

  for _, map in ipairs(mappings) do
    local opts = { noremap = true, silent = true, buffer = ev.buf, desc = map.desc, nowait = map.nowait }
    if map.has then
      if client ~= nil and client.server_capabilities[map.has] then
        vim.keymap.set(map.mode, map[1], map[2], opts)
      end
    elseif map.has == nil then
      vim.keymap.set(map.mode, map[1], map[2], opts)
    end
  end
end

M.enable_inlay_hints = function(client, bufnr)
  if client ~= nil and client.server_capabilities.inlayHintProvider then
    vim.lsp.buf.inlay_hint(bufnr, true)
  end
end

return M
