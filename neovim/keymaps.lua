-- clear search highlight on <escape>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear Search' })

-- disable arrow keys
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- selectively remove whitespace errors
vim.keymap.set('n', '<leader>tw', '<cmd>%s/^\\s\\+$\\|\\s\\+$//gc<CR>', { desc = '[T]rim [W]hitespace' })
