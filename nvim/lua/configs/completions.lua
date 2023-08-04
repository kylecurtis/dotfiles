local cmp = require'cmp'

-- Setup for main completion
cmp.setup({
    -- Snippet support
    snippet = {
        expand = function(args)
            -- Use luasnip for snippet expansion
            require('luasnip').lsp_expand(args.body)
        end,
    },
  
    -- Key mappings
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping.select_next_item({ "i", "s" }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ "i", "s" }),
    },

    -- Sources for completion
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },  -- For luasnip users
        { name = 'buffer' },
    }
})

-- Setup for commandline '/' and '?' completion
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Setup for commandline ':' completion
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})

