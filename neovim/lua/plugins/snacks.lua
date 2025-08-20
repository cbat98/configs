return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {},
        indent = {
            animate = {
                enabled = false
            }
        },
        notifier = {},
        picker = {},
        quickfile = {},
    },
    keys = {
        {"<leader>sp", function() require("snacks").picker() end, desc = "[S]earch [P]ickers" },
        {"<leader>sf", function() require("snacks").picker.files() end, desc = "[S]earch [F]iles"},
        {"<leader>sg", function() require("snacks").picker.grep() end, desc = "[S]earch [G]rep"},
        {"<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "[S]earch [D]iagnostics"},
        {"<leader>sr", function() require("snacks").picker.resume() end, desc = "[S]earch [R]esume"},
        {"<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "[S]earch [S]ymbols"},
        {"<leader>sk", function() require("snacks").picker.keymaps() end, desc = "[S]earch [K]eymaps"}
    }
}
