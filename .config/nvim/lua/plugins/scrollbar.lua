return {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        local scrollbar = require("scrollbar")
        local config = require("scrollbar.config").get()
        local colors = vim.g.github_dark_default_colors

        vim.list_extend(config.excluded_filetypes, {
            "oil",
            "minifiles",
            "codediff-explorer",
            "snacks_notif",
            "snacks_picker_input",
            "snacks_picker_list",
            "gitcommit",
        })

        -- refresh when diagnostics change
        table.insert(config.autocmd.render, "DiagnosticChanged")

        local diagnostic_types = { "Error", "Warn", "Info", "Hint" }

        -- custom handler to remove cspell diagnostics from the scrollbar
        require("scrollbar.handlers").register("diagnostics", function(bufnr)
            return vim.iter(vim.diagnostic.get(bufnr))
                :filter(function(diagnostic)
                    return diagnostic.source ~= "cspell"
                end)
                :map(function(diagnostic)
                    return {
                        line = diagnostic.lnum,
                        type = diagnostic_types[diagnostic.severity],
                    }
                end)
                :totable()
        end)

        scrollbar.setup({
            handle = { color = colors.neutral },
            handlers = { diagnostic = false },
            marks = { Cursor = { text = "━", color = colors.cursor } },
        })
    end,
}
