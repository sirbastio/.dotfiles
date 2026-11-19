return {
    "stevearc/conform.nvim",
    lazy = true,
    init = function()
        require("config.utils").mason_ensure_installed({
            "stylua",
            "ruff",
            "clang-format",
            "prettier"
        })

        -- use conform for formatting instead of vim's built-in formatter with
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
        default_format_opts = { lsp_format = "fallback" },
        -- format_on_save = { timeout_ms = 1000 },
        formatters_by_ft = {
            lua = { "stylua" },
            markdown = { "prettier" },

            python = { "ruff_format" },
            c = { "clang-format" },

            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
        },
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
        },
    },
    keys = {
        {
            "<leader>f",
            function() require("conform").format({ async = true }) end,
            mode = { "n", "v" },
            desc = "[f]ormat",
        },
        {
            "<leader>F",
            "mzgg=G`z",
            desc = "[F]ormat with Vim (keep cursor position)"
        },
    },
}
