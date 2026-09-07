local M = {}

local is_windows = vim.fn.has("win32") == 1

function M.setup()
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

  -- powershell-editor-services is only wanted on Windows.
  local ensure_installed = { "lua_ls" }
  if is_windows then
    table.insert(ensure_installed, "powershell_es")
  end

  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
  })
end

return M
