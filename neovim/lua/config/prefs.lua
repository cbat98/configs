-- map leader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- disable mouse
vim.opt.mouse = ''

-- auto indent on line break
vim.opt.breakindent = true

vim.o.undofile = true

-- smart-case searches
vim.o.ignorecase = true
vim.o.smartcase = true

-- show signcolumn
vim.o.signcolumn = 'yes'

-- change new split behaviour
vim.o.splitright = true
vim.o.splitbelow = true

-- live substitutions
vim.o.inccommand = 'split'

-- show current cursor line
vim.o.cursorline = true

-- show lines above/below cursor
vim.o.scrolloff = 11

-- show color column to indicate line length
vim.o.colorcolumn = '80'

-- disable line wrap
vim.wo.wrap = false

-- convert tabs to spaces
vim.o.expandtab = true

-- set default tab width
vim.o.tabstop = 4
vim.o.shiftwidth = 4
