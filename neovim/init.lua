require("config.prefs")
require("config.keymaps")
require("config.autocmds")

if not require("config.prereqs").run() then
  return
end

require("config.pack")
require("config.plugins")

require("config.lsp")
