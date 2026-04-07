local M = {}

function M.setup()
  require("which-key").setup({})
  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = true })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end

return M
