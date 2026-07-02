return {
    {
        "nvim-mini/mini.files",
        version = false,
        opts = {},
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
