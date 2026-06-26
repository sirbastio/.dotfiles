return
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        image = { enabled = true },
        lazygit = { enabled = true },
        picker = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
    },
    keys = {
        -- General Pickers
        { "<D-p>",      function() Snacks.picker.smart() end,                 desc = "pick [p]roject files" }, -- TODO: Add git files fallback
        { "<leader>pf", function() Snacks.picker.files() end,                 desc = "[p]ick [f]iles (all)" },
        { "<leader>pr", function() Snacks.picker.recent() end,                desc = "[p]ick [r]ecent" },
        { "<D-P>",      function() Snacks.picker.commands() end,              desc = "[cmd] [P]ick" },
        { "<leader>pw", function() Snacks.picker.grep() end,                  desc = "[p]ick [w]ords" },                                     -- TODO: Fallback
        { "<leader>pW", function() Snacks.picker.grep_word() end,             desc = "[p]ick [W]ord",                 mode = { "n", "x" } }, -- TODO: Fallback to git_grep
        { "<leader>ps", function() Snacks.picker.lsp_symbols() end,           desc = "[p]ick [s]ymbols (document)" },
        { "<leader>pS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[p]ick [S]ymbols (workspace)" },
        { "<leader>pb", function() Snacks.picker.buffers() end,               desc = "[p]ick [b]uffers" },
        { "<leader>pd", function() Snacks.picker.diagnostics() end,           desc = "[p]ick [d]iagnostics (project)" },
        { "<leader>ph", function() Snacks.picker.help() end,                  desc = "[p]ick [h]elp" },

        -- Git
        { "<leader>gg", function() Snacks.lazygit() end,                      desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end,                  desc = "Lazygit Logs" },

    },
}
