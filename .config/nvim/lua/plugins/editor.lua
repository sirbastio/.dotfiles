return {
    { "lewis6991/gitsigns.nvim",   event = { "BufReadPre", "BufNewFile" }, opts = {} },
    { "nvim-mini/mini.icons",      version = false,                        opts = {} },
    { "nvim-mini/mini.statusline", version = false,                        opts = {} },
    { "folke/which-key.nvim",      event = "VeryLazy",                     opts = {} },
    {
        "nvim-mini/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        version = false,
        config = function()
            require("mini.indentscope").setup({
                symbol = "┃",
            })

            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3b4261" })
        end,
    },
    {
        "nvim-mini/mini.notify",
        version = "*",
        config = function()
            require("mini.notify").setup({
                -- only show the message
                content = {
                    format = function(notif)
                        return notif.msg
                    end,
                },
                -- make transparent and move to bottom right corner
                window = {
                    winblend = 0,
                    config = function()
                        return {
                            title = "",
                            anchor = "SE",
                            row = vim.o.lines - 3,
                            col = vim.o.columns - 2,
                            border = "none",
                        }
                    end,
                },
            })
            -- remove background
            vim.api.nvim_set_hl(0, "MiniNotifyNormal", { bg = "NONE" })
        end,
    },
}
