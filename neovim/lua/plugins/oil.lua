local M = {}

function M.setup()
  require("oil").setup({
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Oil" })
end

return M
