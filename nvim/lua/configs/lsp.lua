require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- PYTHON
require("lspconfig").pyright.setup {
    capabilities = capabilities,
}
