vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
local use_git_pickers = vim.v.shell_error == 0

local function pick_project_files()
    if use_git_pickers then
        return Snacks.picker.smart({
            multi = { "buffers", "recent", { source = "git_files", untracked = true } },
        })
    end

    return Snacks.picker.smart()
end

local function pick_words()
    if use_git_pickers then
        return Snacks.picker.git_grep({ untracked = true })
    end

    return Snacks.picker.grep()
end

local function pick_word()
    if use_git_pickers then
        return Snacks.picker.git_grep({
            untracked = true,
            cmd_args = { "--fixed-strings", "--word-regexp" },
            search = function(picker)
                return picker:word()
            end,
            live = false,
        })
    end

    return Snacks.picker.grep_word()
end

local function set_snacks_colors()
    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#21262d" })
    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#40464B" })
    vim.api.nvim_set_hl(0, "SnacksLazygitBorder", { fg = "#8b949e" })
    vim.api.nvim_set_hl(0, "SnacksLazygitActiveBorder", { fg = "#58a6ff", bold = true })
    vim.api.nvim_set_hl(0, "SnacksLazygitTitle", { fg = "#79c0ff", bold = true })
end

return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        image = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        words = { enabled = true, debounce = 0 },
        indent = { enabled = true, animate = { enabled = false } },
        picker = { enabled = true, formatters = { file = { filename_first = true } } },
        scroll = {
            enabled = true,
            animate = { duration = { step = 8, total = 160 }, easing = "outQuad" },
            animate_repeat = { elay = 80, duration = { step = 5, total = 80 }, easing = "outQuad" },
        },
    },
    lazygit = {
        enabled = true,
        theme = {
            activeBorderColor = { fg = "SnacksLazygitActiveBorder", bold = true },
            inactiveBorderColor = { fg = "SnacksLazygitBorder" },
            searchingActiveBorderColor = { fg = "SnacksLazygitActiveBorder", bold = true },
        },
        win = {
            border = "rounded",
            title = " Lazygit ",
            title_pos = "center",
            wo = {
                winhighlight = {
                    Normal = "SnacksNormal",
                    NormalNC = "SnacksNormalNC",
                    NormalFloat = "SnacksNormal",
                    FloatBorder = "SnacksLazygitBorder",
                    FloatTitle = "SnacksLazygitTitle",
                    FloatFooter = "SnacksFooter",
                    WinBar = "SnacksWinBar",
                    WinBarNC = "SnacksWinBarNC",
                    WinSeparator = "SnacksWinSeparator",
                },
            },
        },
    },
    keys = {
        -- General Pickers
        { "<D-p>",      pick_project_files,                                   desc = "pick [p]roject files" },
        { "<leader>pf", function() Snacks.picker.files() end,                 desc = "[p]ick [f]iles (all)" },
        { "<leader>pr", function() Snacks.picker.recent() end,                desc = "[p]ick [r]ecent" },
        { "<D-P>",      function() Snacks.picker.commands() end,              desc = "[cmd] [P]ick" },
        { "<leader>pw", pick_words,                                           desc = "[p]ick [w]ords" },
        { "<leader>pW", pick_word,                                            desc = "[p]ick [W]ord",                 mode = { "n", "x" } },
        { "<leader>ps", function() Snacks.picker.lsp_symbols() end,           desc = "[p]ick [s]ymbols (document)" },
        { "<leader>pS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[p]ick [S]ymbols (workspace)" },
        { "<leader>pb", function() Snacks.picker.buffers() end,               desc = "[p]ick [b]uffers" },
        { "<leader>pd", function() Snacks.picker.diagnostics() end,           desc = "[p]ick [d]iagnostics (project)" },
        { "<leader>ph", function() Snacks.picker.help() end,                  desc = "[p]ick [h]elp" },

        -- Git
        { "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end,                  desc = "Lazygit Logs" },

    },
    config = function(_, opts)
        require("snacks").setup(opts)
        set_snacks_colors()
    end,
}
