local M = {}

function M.setup()
  require("peek").setup({
    app = { "msedge", "--new-window" },
    theme = "light",
  })
  local peek = require("peek")
  vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
  vim.api.nvim_create_user_command("PeekClose", peek.close, {})
end

return M
