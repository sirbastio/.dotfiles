return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
                -- core
                "vim",
                "vimdoc",
                "lua",
                "query",
                "gitignore",
                "markdown",
                "markdown_inline",
                "json",

                -- others
                "c",
                "javascript",
                "typescript",
                "html",
                "css",
                "tsx",
                "python",
            }

            local group = vim.api.nvim_create_augroup("Treesitter", { clear = true })

            -- Start treesitter highlighting when a buffer's file type is set for the current buffer
            -- Avoid errors if the parser is not installed
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })

            -- Lazy install parsers
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "VeryLazy",
                once = true,
                callback = function()
                    require("nvim-treesitter").install(parsers)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "HiPhish/rainbow-delimiters.nvim" },
        opts = {},
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async", "HiPhish/rainbow-delimiters.nvim" },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            open_fold_hl_timeout = 0,
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        },
        config = function(_, opts)
            local ufo = require("ufo")

            ufo.setup(opts)

            vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
            vim.keymap.set("n", "zK", function()
                if not ufo.peekFoldedLinesUnderCursor() then
                    vim.lsp.buf.hover()
                end
            end, { desc = "Peek fold" })
        end,
    },
}
