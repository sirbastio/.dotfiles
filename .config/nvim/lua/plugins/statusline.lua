local function lualine_theme()
    local theme = vim.deepcopy(require("lualine.themes.github_dark_default"))
    local middle_bg = require("github-theme.spec").load("github_dark_default").bg0

    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }) do
        theme[mode].c.bg = middle_bg
    end

    return theme
end

local function wide_statusline()
    return vim.go.columns >= 100
end

local function format_mode(mode)
    if wide_statusline() then
        return mode
    end

    return mode:sub(1, 1)
end

return {
    -- { "nvim-mini/mini.statusline", version = false, opts = {} },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                options = {
                    globalstatus = true,
                    section_separators = { left = "█", right = "█" },
                    component_separators = { left = "", right = "" },
                    theme = lualine_theme(),
                },
                sections = {
                    lualine_a = { { "mode", fmt = format_mode } },
                    lualine_b = { "branch", { "diff", cond = wide_statusline }, "diagnostics" },
                    lualine_c = {
                        { "filename", path = 1, cond = wide_statusline },
                        { "filename", path = 0, cond = function() return not wide_statusline() end },
                    },
                    lualine_x = {},
                    lualine_y = { "filetype", { "lsp_status", cond = wide_statusline } },
                    lualine_z = { "location" },
                },
            }
        end,
    },
}
