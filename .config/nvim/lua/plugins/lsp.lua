return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        ensure_installed = {
            "lua_ls",
            "stylua",
        },
        automatic_enable = {
            exclude = { "stylua" },
        },
    },
    init = function()
        vim.diagnostic.config({
            signs = false,
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
