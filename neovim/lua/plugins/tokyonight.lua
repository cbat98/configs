local M = {}

function M.setup()
  require("tokyonight").setup({
    style = "night",
    transparent = true,
  })
  vim.cmd.colorscheme("tokyonight")
end

return M
