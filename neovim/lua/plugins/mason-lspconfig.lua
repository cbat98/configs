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
                vim.lsp.config('ansiblels', {
                    filetypes = { 'yaml.ansible', 'yml', 'yaml', 'ansible' }
                })
                vim.lsp.config('lua_ls', {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
                vim.lsp.config('powershell_es', {
                    settings = {
                        powershell = {
                            codeFormatting = {
                                AddWhitespaceAroundPipe = true,
                                AutoCorrectAliases = true,
                                AvoidSemicolonsAsLineTerminators = true,
                                Preset = 'OTBS',
                                WhitespaceBeforeOpenBrace = true,
                                WhitespaceBeforeOpenParen = true,
                                WhitespaceAroundOperator = true,
                                WhitespaceAfterSeparator = true,
                                WhitespaceBetweenParameters = true,
                                WhitespaceInsideBrace = true,
                                AlignPropertyValuePairs = true,
                                UseCorrectCasing = true,
                            },
                        }
                    }
                })
            end,
        }
    },
    opts = {}
}
