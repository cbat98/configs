local M = {}

-- Parsers to keep installed. Neovim 0.12 bundles c, lua, markdown, vim, and vimdoc.
-- `install` is async and a no-op when already present; `:TSUpdate` (wired up in
-- config/pack.lua on PackChanged) keeps them current.
local ensure_installed = {
  "bash",
  "diff",
  "json",
  "luadoc",
  "powershell",
  "yaml",
}

function M.setup()
  require("nvim-treesitter").install(ensure_installed)

  -- The nvim-treesitter `main` branch no longer enables features itself; Neovim does.
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-features", { clear = true }),
    callback = function(ev)
      if not pcall(vim.treesitter.start, ev.buf) then
        -- no parser for this filetype
        return
      end
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
