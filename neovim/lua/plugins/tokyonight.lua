return {
  "folke/tokyonight.nvim",
  lazy = false,
  event = 'VeryLazy',
  opts = {
      style = 'night'
  },
  init = function()
      vim.cmd.colorscheme 'tokyonight'
  end
}
