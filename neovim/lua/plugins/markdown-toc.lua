return {
    "hedyhli/markdown-toc.nvim",
    ft = "markdown",
    cmd = { "Mtoc" },
    opts = {
        fences = {
            start_text = "markdown-toc start",
            end_text = "markdown-toc end"
        },
        toc_list = {
            markers = "-"
        }
    },
}
