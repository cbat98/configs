-- Plugin revisions are recorded in nvim-pack-lock.json next to init.lua; keep that file in version control.
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
  { src = gh("neovim/nvim-lspconfig"), version = "16812abf0e8d8175155f26143a8504e8253e92b0" },
  { src = gh("mason-org/mason.nvim"), version = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65" },
  { src = gh("mason-org/mason-lspconfig.nvim"), version = "037398b9ce4a53ba48d5f94765c641a1fd16d906" },
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "7caec274fd19c12b55902a5b795100d21531391f" },
  { src = gh("folke/tokyonight.nvim"), version = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6" },
  { src = gh("folke/snacks.nvim"), version = "ad9ede6a9cddf16cedbd31b8932d6dcdee9b716e" },
  { src = gh("folke/which-key.nvim"), version = "3aab2147e74890957785941f0c1ad87d0a44c15a" },
  { src = gh("chrisgrieser/nvim-origami"), name = "nvim-origami", version = "e5b527f41d18c2ee5af868e1a3939b60f15fdb90" },
  { src = "https://codeberg.org/andyg/leap.nvim", version = "e20f33507bd2d6c671b7273f797f2d3cf521ac61" },
  { src = gh("stevearc/oil.nvim"), version = "0fcc83805ad11cf714a949c98c605ed717e0b83e" },
  { src = gh("lewis6991/gitsigns.nvim"), version = "8a796a440fde3eeed3f33aecce9dab863b2be218" },
  { src = gh("barrettruth/diffs.nvim"), version = "0cb16a0e2384f1d3dd6330f6ea517de8e07aa8e8" },
  { src = gh("hedyhli/markdown-toc.nvim"), version = "869af35bce0c27e2006f410fa3f706808db4843d" },
}

if vim.fn.executable("deno") == 1 then
  table.insert(
    specs,
    { src = gh("toppair/peek.nvim"), version = "5820d937d5414baea5f586dc2a3d912a74636e5b" }
  )
end

vim.pack.add(specs, { load = true, confirm = false })
