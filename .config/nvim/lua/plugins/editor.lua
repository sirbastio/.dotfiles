return {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "nvim-mini/mini.statusline", version = false, opts = {} },
    { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "mbbill/undotree",
        lazy = true,
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            presets = {
                lsp_doc_border = true,
            },
        },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.rainbow_delimiters = {
                highlight = {
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterRed",
                    "RainbowDelimiterPink",
                    "RainbowDelimiterPurple",
                },
            }
        end,
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                diagnostics_clean = {
                    mode = "diagnostics",
                    filter = { ["not"] = { ["item.source"] = "cspell" } },
                },
                diagnostics_buffer = {
                    mode = "diagnostics",
                    filter = { buf = 0, ["not"] = { ["item.source"] = "cspell" } },
                },
                spelling = {
                    mode = "diagnostics",
                    desc = "Spelling diagnostics",
                    filter = { ["item.source"] = "cspell" },
                    format = "{message:md} {pos}",
                },
            },
        },
        keys = {
            { "X", vim.diagnostic.open_float, desc = "Current line diagnostics" },
            { "<leader>xx", "<cmd>Trouble diagnostics_clean toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics_buffer toggle<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>xs", "<cmd>Trouble spelling toggle<cr>", desc = "Spelling (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "lewis6991/gitsigns.nvim" },
        config = function()
            -- Written by AI: removes cspell (spellcheck) diagnostics in the sidebar
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

            require("scrollbar").setup({
                handle = { color = "#2B3038" },
                handlers = { diagnostic = false },
                marks = {
                    Cursor = { text = "━", color = "#3081F7" },
                    GitAdd = { text = "┃" },
                    GitChange = { text = "┃" },
                    GitDelete = { text = "▁" },
                },
            })
            setup_diagnostic_scrollbar()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    -- {
    --     -- smooth cursor
    --     "sphamba/smear-cursor.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         -- cursor_color = "#2f81f7",
    --         time_interval = 8,
    --         stiffness = 0.64,
    --         trailing_stiffness = 0.64,
    --         stiffness_insert_mode = 0.64,
    --         trailing_stiffness_insert_mode = 0.64,
    --         matrix_pixel_threshold = 0.5,
    --     },
    -- },
}
