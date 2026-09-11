local M = {}

function M.setup()
  local wk = require("which-key")
  wk.setup({
    plugins = {
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
  })
  wk.add({
    { "<leader>c", group = "[C]ount" },
    { "<leader>p", group = "[P]lugins" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]rim" },
  })
  vim.keymap.set("n", "<leader>?", function()
    wk.show({ global = true })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end

return M
