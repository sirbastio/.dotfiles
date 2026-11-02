return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            attach_to_untracked = true,
            signs = {
                add = { text = " ┃" },
                change = { text = " ┃" },
                delete = { text = " ▁" },
                topdelete = { text = " ▔" },
                changedelete = { text = " ┃" },
                untracked = { text = " ┆" },
            },
        },
        keys = {
            { "<leader>gh", ":Gitsigns preview_hunk<CR>", desc = "[g]it [h]unk preview" },
            { "<leader>gH", ":Gitsigns preview_hunk_inline<CR>", desc = "[G]it [H]unk preview inline" },
            { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "[g]it [d]iff" },
            { "<leader>gn", ":Gitsigns nav_hunk next<CR>", desc = "[g]it [n]ext hunk" },
            { "<leader>gp", ":Gitsigns nav_hunk prev<CR>", desc = "[g]it [p]revious hunk" },
            { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "[g]it [r]eset hunk" },
        },
    },
    {
        "NeogitOrg/neogit",
        lazy = true,
        cmd = "Neogit",
        dependencies = {
            "folke/snacks.nvim",
            { "m00qek/baleia.nvim", config = function() vim.g.baleia = require("baleia").setup({}) end },
        },
        opts = {
            log_pager = {"sh", "-c", [[delta --file-style omit --hunk-header-style omit | tail -n +2 | perl -pe 's/\e\[0K/" " x 400/ge']],},
            commit_editor = { staged_diff_split_kind = "vsplit" },
            graph_style = "unicode",
            process_spinner = true,
            treesitter_diff_highlight = true,
        },
        keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" } },
        init = function()
            -- clean up hunk headers
            vim.api.nvim_create_autocmd("BufWinEnter", {
                callback = function(args)
                    local diff_views = { "NeogitStatus", "NeogitCommitView", "NeogitDiffView" }
                    if not vim.tbl_contains(diff_views, vim.bo[args.buf].filetype) or vim.w.neogit_hunk_conceal then
                        return
                    end
                    vim.wo.conceallevel = 3
                    vim.wo.concealcursor = "nvic"
                    vim.w.neogit_hunk_conceal = vim.fn.matchadd("Conceal", [[^@@ [^@]* @@ \?]], 10, -1, { conceal = "" })
                end,
            })
        end,
    },
}
