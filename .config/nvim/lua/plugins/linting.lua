return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        require("config.utils").mason_ensure_installed({
            "cspell",
        })

        lint.linters_by_ft = {
        }

        -- accept both US and British spelling
        table.insert(lint.linters.cspell.args, 2, "--locale=en,en-GB")

        -- cspell has no way to add words, so pull from neovim's spellfile (added with zg)
        local parse = lint.linters.cspell.parser
        lint.linters.cspell.parser = function(output, bufnr)
            local ok, words = pcall(vim.fn.readfile, vim.o.spellfile)
            return vim.tbl_filter(function(diagnostic)
                return not (ok and vim.list_contains(words, diagnostic.message:match("%((.-)%)")))
            end, parse(output, bufnr))
        end

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
            group = vim.api.nvim_create_augroup("Lint", { clear = true }),
            callback = require("config.utils").on_normal_file_buffer(function(event)
                if vim.bo[event.buf].filetype == "bigfile" then
                    return
                end

                vim.api.nvim_buf_call(event.buf, function()
                    lint.try_lint("cspell")
                    lint.try_lint()
                end)
            end),
        })
    end,
}
