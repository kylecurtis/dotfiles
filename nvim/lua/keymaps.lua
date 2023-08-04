-- JK TO EXIT INSERT
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})

-- TMUX CONFIG
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<c-h>', ':<C-U>TmuxNavigateLeft<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-j>', ':<C-U>TmuxNavigateDown<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-k>', ':<C-U>TmuxNavigateUp<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-l>', ':<C-U>TmuxNavigateRight<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-p>', ':<C-U>TmuxNavigatePrevious<cr>', {noremap = true, silent = true})

