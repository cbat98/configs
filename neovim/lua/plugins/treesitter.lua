local M = {}

function M.setup()
  require("nvim-treesitter.config").setup({
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
