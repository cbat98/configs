require("plugins.tokyonight").setup()
require("plugins.mason-lspconfig").setup()
require("plugins.treesitter").setup()
require("plugins.snacks").setup()
require("plugins.whichkey").setup()
require("plugins.origami").setup()
require("plugins.leap").setup()
require("plugins.oil").setup()
require("plugins.gitsigns").setup()
require("plugins.diffs").setup()
require("plugins.markdown-toc").setup()
if vim.fn.executable("deno") == 1 then
  require("plugins.peek").setup()
end
