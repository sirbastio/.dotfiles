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
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                end

                map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
                map("gD", vim.lsp.buf.declaration, "[g]o to [D]eclaration")
                map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
                map("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")

                map("<leader>r", vim.lsp.buf.rename, "Rename symbol")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
            end,
        })

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
            },
        })
    end,
}
