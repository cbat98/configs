-- Plugin configuration loader. Each module under lua/plugins/ exposes M.setup().
require("plugins.tokyonight").setup()
require("plugins.mason-lspconfig").setup()
require("plugins.treesitter").setup()
require("plugins.snacks").setup()
require("plugins.whichkey").setup()
require("plugins.leap").setup()
require("plugins.oil").setup()
require("plugins.gitsigns").setup()
