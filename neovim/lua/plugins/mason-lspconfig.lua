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
  -- powershell_es uses nvim-lspconfig / PowerShell Editor Services defaults for now.

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
