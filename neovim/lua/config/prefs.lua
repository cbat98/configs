-- map leader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- disable mouse
vim.o.mouse = ''

-- auto indent on line break
vim.o.breakindent = true

-- persist undo history across sessions
vim.o.undofile = true

-- smart-case searches
vim.o.ignorecase = true
vim.o.smartcase = true

-- always show signcolumn
vim.o.signcolumn = 'yes'

-- change new split behaviour
vim.o.splitright = true
vim.o.splitbelow = true

-- live substitutions
vim.o.inccommand = 'split'

-- show current cursor line
vim.o.cursorline = true

-- keep lines above/below cursor
vim.o.scrolloff = 11

-- show colour column to indicate line length
vim.o.colorcolumn = '80'

-- disable line wrap
vim.o.wrap = false

-- convert tabs to spaces
vim.o.expandtab = true

-- default tab width
vim.o.tabstop = 4
vim.o.shiftwidth = 4
