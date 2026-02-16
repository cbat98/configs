return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
        foldKeymaps = {
            setup = true,
            closeOnlyOnFirstColumn = true,
            scrollLeftOnCaret = false,
	    },
    },
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
}
