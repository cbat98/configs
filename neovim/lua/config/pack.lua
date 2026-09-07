-- Plugins are tracked on their default branch (no pinned revisions) so they can be
-- updated in bulk with `:lua vim.pack.update()`, reviewing the diff before confirming.
local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end
    local name = ev.data.spec.name
    if name == "nvim-treesitter" then
      pcall(function()
        vim.cmd.TSUpdate()
      end)
    elseif name == "peek.nvim" then
      vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = ev.data.path }):wait()
    end
  end,
})

local specs = {
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
  { src = gh("nvim-treesitter/nvim-treesitter") },
  { src = gh("folke/tokyonight.nvim") },
  { src = gh("folke/snacks.nvim") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("chrisgrieser/nvim-origami"), name = "nvim-origami" },
  { src = "https://codeberg.org/andyg/leap.nvim" },
  { src = gh("stevearc/oil.nvim") },
  { src = gh("lewis6991/gitsigns.nvim") },
}

-- peek.nvim needs deno at build and run time; gate the spec and its config on it.
vim.g.have_deno = vim.fn.executable("deno") == 1

if vim.g.have_deno then
  table.insert(specs, { src = gh("toppair/peek.nvim") })
end

vim.pack.add(specs, { load = true, confirm = false })
