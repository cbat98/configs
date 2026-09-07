local M = {}

function M.setup()
  local wk = require("which-key")
  wk.setup({})
  wk.add({
    { "<leader>c", group = "[C]ount" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]rim" },
  })
  vim.keymap.set("n", "<leader>?", function()
    wk.show({ global = true })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end

return M
