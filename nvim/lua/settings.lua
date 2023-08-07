-- TRUE COLOR
vim.opt.termguicolors = true

-- SET LEADER TO SPACEBAR
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- LINE NUMBERS
vim.opt.nu = true
vim.opt.relativenumber = true

-- TABS & SPACES
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true

-- OTHER
vim.opt.laststatus = 2
vim.opt.backspace = '2'
vim.opt.scrolloff = 8
vim.opt.showcmd = true

-- CURSOR
vim.o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50'

-- COLOR SCHEME
--vim.cmd.colorscheme "catppuccin"
vim.cmd[[colorscheme tokyonight-night]]

-- TRANSPARENCY
--vim.cmd[[highlight Normal guibg=NONE ctermbg=NONE]]
--vim.cmd[[highlight NonText guibg=NONE ctermbg=NONE]]

