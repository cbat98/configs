-- Plugin configuration loader. Each module under lua/plugins/ exposes M.setup().
local features = vim.g.nvim_features or {}

require("plugins.tokyonight").setup()

if features.treesitter then
  require("plugins.treesitter").setup()
end

if features.snacks_picker then
  require("plugins.snacks").setup()
end

require("plugins.mason-lspconfig").setup()
require("plugins.whichkey").setup()
require("plugins.origami").setup()
require("plugins.leap").setup()
require("plugins.oil").setup()
require("plugins.gitsigns").setup()
require('modicator').setup()
require("lualine").setup()
