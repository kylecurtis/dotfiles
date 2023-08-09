require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LUA
require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
}

-- PYTHON
require("lspconfig").pyright.setup {
    capabilities = capabilities,
}

-- JAVASCRIPT / TYPESCRIPT
require("lspconfig").tsserver.setup {
    capabilities = capabilities,
}

-- C / C++
require("lspconfig").clangd.setup {
    capabilities = capabilities,
}

-- RUST
local rt = require("rust-tools")
rt.setup({
  server = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<Leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
})
