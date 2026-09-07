local M = {}

function M.setup()
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  require("origami").setup({
    foldKeymaps = {
      setup = true,
      closeOnlyOnFirstColumn = true,
      scrollLeftOnCaret = false,
    },
  })
end

return M
