local function setup_mini_files_window()
    local group = vim.api.nvim_create_augroup("MiniFilesTopLeft", { clear = true })

    vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
            local config = vim.api.nvim_win_get_config(args.data.win_id)

            config.anchor = "NW"
            config.row = 0

            vim.api.nvim_win_set_config(args.data.win_id, config)
        end,
    })
end

return {
    {
        "nvim-mini/mini.files",
        version = false,
        opts = {},
        config = function(_, opts)
            require("mini.files").setup(opts)
            setup_mini_files_window()
        end,
        keys = {
            { "<leader>E", function() require("mini.files").open() end, desc = "[e]xplorer" },
        },
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            keymaps = {
                ["<C-S-s>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-h>"] = false,
                ["<C-l>"] = false,
            },
        },
        keys = {
            { "<leader>e", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
    },
}
