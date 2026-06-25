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
        -- default_format_opts = {
        --     lsp_format = "fallback",
        -- },
        format_on_save = {
            timeout_ms = 1000,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
        },
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
        }
    },
    init = function()
        -- use conform for formatting instead of vim's built-in formatter
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
