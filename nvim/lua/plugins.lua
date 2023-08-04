local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   
    -- LSP CONFIG (MUST BE IN THIS ORDER)
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- LUALINE
    "nvim-lualine/lualine.nvim",
    
    -- TREESITTER
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    
    -- TELESCOPE
    {'nvim-telescope/telescope.nvim', tag = '0.1.2', 
    dependencies = { 'nvim-lua/plenary.nvim' }},

    -- LUASNIP
    {"L3MON4D3/LuaSnip", version = "2.0", build = "make install_jsregexp"},

    -- AUTOCOMPLETE
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- TMUX NAVIGATION
    "christoomey/vim-tmux-navigator",

    -- COLOR SCHEME
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    
})
