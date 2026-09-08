local M = {}

local is_windows = vim.fn.has("win32") == 1
local is_linux = vim.fn.has("linux") == 1

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

  -- Ansible language server: only attach to YAML files that live under a
  -- directory named "ansible" so plain YAML files are left alone. root_dir
  -- never calls on_dir for other paths, which stops the client from starting.
  vim.lsp.config("ansiblels", {
    filetypes = { "yaml", "yaml.ansible" },
    root_dir = function(bufnr, on_dir)
      local fname = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
      if not fname:match("/ansible/") then
        return
      end
      on_dir(vim.fs.root(bufnr, { "ansible.cfg", ".git" }) or vim.fs.dirname(fname))
    end,
  })

  -- powershell-editor-services is only wanted on Windows; the Ansible and
  -- bash language servers only on Linux hosts (npm required for the latter).
  local features = vim.g.nvim_features or {}
  local ensure_installed = { "lua_ls" }
  if is_windows then
    table.insert(ensure_installed, "powershell_es")
  end
  if is_linux and features.mason_npm_lsps then
    vim.list_extend(ensure_installed, { "ansiblels", "bashls" })
  end

  require("mason").setup({})
  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
  })
end

return M
