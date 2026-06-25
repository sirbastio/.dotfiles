return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        ensure_installed = {
            "lua_ls",
        },
        automatic_enable = true,
    },
    init = function()
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                },
            },
            severity_sort = true,
            float = {
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
                focusable = false,
                style = "minimal",
            }
        })
    end,
}
