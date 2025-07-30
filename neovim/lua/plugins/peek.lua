return {
  'toppair/peek.nvim',
  enabled = function()
      return vim.fn.executable('deno') == 1
  end,
  event = { 'VeryLazy' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup {
      app = {'msedge', '--new-window'},
      theme = 'light',
    }
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
}
