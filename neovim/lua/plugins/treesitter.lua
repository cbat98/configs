local M = {}

-- Parsers to keep installed. `install` is async and a no-op when already present;
-- `:TSUpdate` (wired up in config/pack.lua on PackChanged) keeps them current.
local ensure_installed = {
  "bash",
  "c",
  "diff",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "powershell",
  "python",
  "query",
  "regex",
  "vim",
  "vimdoc",
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
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end,
  })
end

return M
