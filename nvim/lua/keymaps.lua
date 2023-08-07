-- JK TO EXIT INSERT
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})

-- TELESCOPE FILE BROWSER
vim.api.nvim_set_keymap(
  "n",
  "<space>n",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
  "n",
  "<space>n",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  { noremap = true }
)


-- TMUX CONFIG
vim.g.tmux_navigator_no_mappings = 1
vim.api.nvim_set_keymap('n', '<c-h>', ':<C-U>TmuxNavigateLeft<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-j>', ':<C-U>TmuxNavigateDown<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-k>', ':<C-U>TmuxNavigateUp<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-l>', ':<C-U>TmuxNavigateRight<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-p>', ':<C-U>TmuxNavigatePrevious<cr>', {noremap = true, silent = true})

