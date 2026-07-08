return {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        -- Function written by AI: removes cspell (spellcheck) diagnostics in the sidebar
        local function setup_diagnostic_scrollbar()
            local diagnostic_handler = require("scrollbar.handlers.diagnostic")

            local diagnostic_mark_type = {
                [vim.diagnostic.severity.ERROR] = "Error",
                [vim.diagnostic.severity.WARN] = "Warn",
                [vim.diagnostic.severity.INFO] = "Info",
                [vim.diagnostic.severity.HINT] = "Hint",
            }

            local function update(bufnr)
                if not bufnr or bufnr == 0 then
                    bufnr = vim.api.nvim_get_current_buf()
                end

                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end

                local config = require("scrollbar.config").get()
                local function get_diagnostics()
                    return vim.tbl_filter(function(diagnostic)
                        return diagnostic.source ~= "cspell"
                    end, vim.diagnostic.get(bufnr))
                end

                local function diagnostic_mapper(diagnostic)
                    local mark_type = diagnostic_mark_type[diagnostic.severity]

                    return {
                        line = diagnostic.lnum,
                        text = config.marks[mark_type].text[1],
                        type = mark_type,
                        level = 1,
                    }
                end

                diagnostic_handler.generic_handler(bufnr, get_diagnostics, diagnostic_mapper)
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
                group = vim.api.nvim_create_augroup("ScrollbarDiagnostics", { clear = true }),
                callback = function(args)
                    update(args.buf)
                end,
            })

            update(0)
        end

        vim.list_extend(require("scrollbar.config").get().excluded_filetypes, {
            "oil",
            "minifiles",
            "codediff-explorer",
            "snacks_notif",
            "snacks-picker-input",
            "snacks-picker-list",
        })

        require("scrollbar").setup({
            handle = { color = "#2B3038" },
            handlers = { diagnostic = false },
            marks = { Cursor = { text = "━", color = "#3081F7" } },
        })
        setup_diagnostic_scrollbar()
    end,
}
