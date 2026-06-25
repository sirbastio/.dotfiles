return {
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
            callback = function(args) pcall(vim.treesitter.start, args.buf) end
        })

        -- Lazy install parsers
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "VeryLazy",
            once = true,
            callback = function() require("nvim-treesitter").install(parsers) end
        })
    end,
}
