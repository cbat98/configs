local M = {}

function M.setup()
  require("mtoc").setup({
    fences = {
      start_text = "markdown-toc start",
      end_text = "markdown-toc end",
    },
    toc_list = {
      markers = "-",
    },
  })
end

return M
