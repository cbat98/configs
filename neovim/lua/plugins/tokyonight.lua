return {
  "folke/tokyonight.nvim",
  lazy = false,
  event = 'VeryLazy',
  opts = {
      style = 'night',
      transparent = true
  },
  init = function()
      vim.cmd.colorscheme 'tokyonight'
  end
}
