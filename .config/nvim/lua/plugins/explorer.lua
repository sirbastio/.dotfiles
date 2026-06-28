return {
    "nvim-mini/mini.files",
    version = false,
    lazy = true,
    opts = {},
    keys = {
        { "<leader>e", function() require("mini.files").open() end, desc = "[e]xplorer" },
    },
}
