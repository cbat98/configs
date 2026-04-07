local M = {}

function M.setup()
  require("snacks").setup({
    bigfile = {},
    indent = {
      animate = {
        enabled = false,
      },
    },
    notifier = {},
    picker = {},
    quickfile = {},
  })

  local snacks = require("snacks")
  vim.keymap.set("n", "<leader>sp", function()
    snacks.picker()
  end, { desc = "[S]earch [P]ickers" })
  vim.keymap.set("n", "<leader>sf", function()
    snacks.picker.files()
  end, { desc = "[S]earch [F]iles" })
  vim.keymap.set("n", "<leader>sg", function()
    snacks.picker.grep()
  end, { desc = "[S]earch [G]rep" })
  vim.keymap.set("n", "<leader>sd", function()
    snacks.picker.diagnostics()
  end, { desc = "[S]earch [D]iagnostics" })
  vim.keymap.set("n", "<leader>sr", function()
    snacks.picker.resume()
  end, { desc = "[S]earch [R]esume" })
  vim.keymap.set("n", "<leader>ss", function()
    snacks.picker.lsp_symbols()
  end, { desc = "[S]earch [S]ymbols" })
  vim.keymap.set("n", "<leader>sk", function()
    snacks.picker.keymaps()
  end, { desc = "[S]earch [K]eymaps" })
end

return M
