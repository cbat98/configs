local M = {}

function M.setup()
  require("catppuccin").setup({
    flavour = "macchiato",
    transparent_background = true,
    integrations = {
      gitsigns = true,
      mason = true,
      snacks = true,
      which_key = true,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end

return M
