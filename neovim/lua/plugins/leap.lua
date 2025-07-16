return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', 's', '<Plug>(leap-forward)')
    vim.keymap.set('n', 'S', '<Plug>(leap-backward)')
  end,
}
