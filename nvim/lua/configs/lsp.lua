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
require("lspconfig").rust_analyzer.setup {
    capabilities = capabilities,
}

