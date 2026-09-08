if vim.fn.has("win32") == 1 and vim.fn.executable("gcc") == 1 then
  -- tree-sitter CLI on Windows is MSVC-built; MinGW needs an explicit GNU target.
  vim.env.TARGET = "x86_64-pc-windows-gnu"
  vim.env.CC = "gcc"
end

require("config.prefs")
require("config.keymaps")
require("config.autocmds")

if not require("config.prereqs").run() then
  return
end

require("config.pack")
require("config.plugins")

require("config.lsp")
