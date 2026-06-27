return {
    -- notifications
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
            -- Move to bottom right corner
            window = {
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
    end,
}
