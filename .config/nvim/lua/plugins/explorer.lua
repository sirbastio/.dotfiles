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
        config = function()
            local files = require("mini.files")
            setup_mini_files_window()
            files.setup({
                mappings = {
                    go_in = "<CR>",
                    go_out = "_",
                },
            })

            vim.keymap.set("n", "<leader>e", files.open, { desc = "[e]xplorer" })
            vim.keymap.set("n", "<leader>E", function()
                files.open(vim.api.nvim_buf_get_name(0), false)
                files.reveal_cwd()
            end, { desc = "[E]xplorer current file" })
        end,
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
            { "<leader>O", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
    },
}
