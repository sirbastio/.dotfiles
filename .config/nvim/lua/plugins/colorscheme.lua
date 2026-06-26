return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                transparent = true,
            },
            groups = {
                all = {
                    CursorLine = { bg = "#161b22" },

                    -- cursor word highlight color
                    LspReferenceText = { bg = "#21262d" },
                    LspReferenceRead = { bg = "#21262d" },
                    LspReferenceWrite = { bg = "#21262d" },
                },
            },
        })
        vim.cmd.colorscheme("github_dark_default")
    end,
}
