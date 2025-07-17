return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {}
        },
        {
            'neovim/nvim-lspconfig',
            init = function()
                vim.lsp.config('lua_ls', {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
            end,
        }
    },
    opts = {}
}
