return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            timeout_ms = 1000,
        },
    },
    init = function()
        -- use conform for formatting instead of vim's built-in formatter
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
