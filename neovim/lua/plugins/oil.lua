local M = {}

function M.setup()
  require("oil").setup({
    columns = { "icon" },
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Oil" })
end

return M
