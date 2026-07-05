return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("Lint", { clear = true }),
            callback = function()
                require("lint").try_lint("cspell")
            end,
        })
    end,
}
