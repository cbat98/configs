local M = {}

function M.setup()
  vim.keymap.set("n", "s", "<Plug>(leap-forward)")
  vim.keymap.set("n", "S", "<Plug>(leap-backward)")
end

return M
