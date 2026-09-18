local M = {}

function M.setup()
    require("starfall").setup({
        density               = 6,
        falling_stars         = 1,
        shooting_spawn_chance = 0.02,
        min_life              = 70,
        max_life              = 100,
        margin                = 16,
        ignore_filetypes      = {
            "TelescopePrompt", "TelescopeResults", "NvimTree", "neo-tree",
            "lazy", "mason", "help", "dashboard", "alpha", "starter",
            "notify", "noice", "trouble", "qf", "fugitive", "oil", ""
        },

    })

    vim.cmd.StarfallStart()
end

return M
