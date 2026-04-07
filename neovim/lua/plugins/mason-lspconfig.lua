local M = {}

function M.setup()
  vim.lsp.config("ansiblels", {
    filetypes = { "yaml.ansible", "yml", "yaml", "ansible" },
  })
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })
  vim.lsp.config("powershell_es", {
    settings = {
      powershell = {
        codeFormatting = {
          AddWhitespaceAroundPipe = true,
          AutoCorrectAliases = true,
          AvoidSemicolonsAsLineTerminators = true,
          Preset = "OTBS",
          WhitespaceBeforeOpenBrace = true,
          WhitespaceBeforeOpenParen = true,
          WhitespaceAroundOperator = true,
          WhitespaceAfterSeparator = true,
          WhitespaceBetweenParameters = true,
          WhitespaceInsideBrace = true,
          AlignPropertyValuePairs = true,
          UseCorrectCasing = true,
        },
      },
    },
  })

  require("mason").setup({})
  require("mason-lspconfig").setup({})
end

return M
