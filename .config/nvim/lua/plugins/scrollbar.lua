return {
    "petertriho/nvim-scrollbar",
    -- TODO: drop once v2 lands on main (2026-11-16)
    branch = "refactor/v2",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        local colors = vim.g.github_dark_default_colors
        local blend = 40

        -- marks carry the thumb's blend themselves, so they keep one color on and off the thumb
        local function mark(color, text)
            if not color:find("^#") then
                color = vim.api.nvim_get_hl(0, { name = color, link = false }).fg
            end
            return { text = text, highlight = { fg = color, blend = blend } }
        end

        local diagnostic_types = { "Error", "Warn", "Info", "Hint" }

        local function collect(bufnr)
            return vim.iter(vim.diagnostic.get(bufnr))
                :filter(function(diagnostic)
                    return diagnostic.source ~= "cspell"
                end)
                :map(function(diagnostic)
                    return {
                        line = diagnostic.lnum,
                        type = diagnostic_types[diagnostic.severity],
                    }
                end)
                :totable()
        end

        -- replaces the built-in diagnostic provider to remove cspell diagnostics from the scrollbar
        require("scrollbar.providers").register({
            name = "diagnostic_no_cspell",
            refresh_owner = { buffer = "provider" },
            setup = function(context)
                vim.api.nvim_create_autocmd("DiagnosticChanged", {
                    group = context.create_augroup("updates"),
                    callback = function(args)
                        -- set_marks ignores and clears buffers that get no scrollbar
                        context.set_marks(args.buf, collect(args.buf))
                    end,
                })
            end,
            refresh = collect,
        })

        require("scrollbar").setup({
            -- NOTE: floating windows never get a scrollbar
            exclude = {
                filetypes = {
                    oil = true,
                    ["codediff-explorer"] = true,
                    gitcommit = true,
                },
            },
            providers = { diagnostic = false, gitsigns = true },
            marks = {
                Cursor = mark(colors.cursor, "━"),
                Search = mark(colors.orange),
                Error = mark("DiagnosticVirtualTextError", ""),
                Warn = mark("DiagnosticVirtualTextWarn", ""),
                Info = mark("DiagnosticVirtualTextInfo", ""),
                Hint = mark("DiagnosticVirtualTextHint", ""),
                Mark = mark("Special"),
                GitAdd = mark("GitSignsAdd"),
                GitChange = mark("GitSignsChange"),
                GitDelete = mark("GitSignsDelete"),
            },
            scrollbar = {
                unit = "screenline",                                -- account for folds
                layout = { columns = { { "thumb", "marks" } } },    -- scrollbar inclusions
                thumb = { blend = blend, highlight = { bg = colors.neutral } }, -- scrollbar color
                window = {
                    wo = {
                        -- fully see-through so blank cells keep the cursorline and text colors underneath
                        winblend = 100,
                        -- marks blend with the float's base, so a cursorline base keeps their cells
                        -- matching the cursorline (and near the editor background elsewhere)
                        winhighlight = "Normal:CursorLine,NormalNC:CursorLine",
                    },
                },
            },
        })
    end,
}
